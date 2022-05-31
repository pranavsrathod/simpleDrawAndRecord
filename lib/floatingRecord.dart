import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

// this class returns a stateful widget since the state of the widget changes when recorder is turned on off.
class floatingRecord extends StatefulWidget {
  @override
  _floatingRecord createState () => _floatingRecord();
// State<StatefulWidget> createState() {
//   // TODO: implement createState
//   throw UnimplementedError();
// }

}

// returns a widget of an elevated button.

class _floatingRecord extends State<floatingRecord> {
  var _recorderIsReady = false;
  var _startTime; // stores the start of the recording
  var _endTime;
  var _iconFlag = false;
  final recorder = FlutterSoundRecorder();

  Future startRecorder() async {
    if (!_recorderIsReady) {
      return;
    }
    await recorder.startRecorder(toFile: 'audio');
  }

  // stops the recorder,
  // after generating a file and path, the data is encoded as base64 string
  // this base64 data is then logged into the cloud firestore collection under "audio"
  Future stopRecorder() async {
    if (!_recorderIsReady) {
      return;
    }
    final path = await recorder.stopRecorder();
    final audioFile = File(path!);

    // print ('Recorded Audio $audioFile');
    var _fileBytes = await audioFile.readAsBytes();
    var _base64String = base64Encode(_fileBytes);
    var encoded = {
      "audioBase64": _base64String,
      "start": _startTime,
      "end": _endTime
    };
    // print(_base64String);

    // logging the data to the firebase collection.
    var db = FirebaseFirestore.instance;
    db.collection("audio").add(encoded).then((value) =>
        print("Recording Logged Successfully"));
  }

  // initialise the recorder

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Cannot Record, Microphone Permission Not Granted';
    }
    await recorder.openRecorder();
    _recorderIsReady = true;
  }

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    super.dispose();
    recorder.closeRecorder();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton (
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding : EdgeInsets.all(20)
      ),
      onPressed: () async {
        setState ((){});
        if (recorder.isRecording) {
          _endTime = DateTime.now();
          _iconFlag = false;
          await stopRecorder();

        } else {
          _iconFlag = true;
          await startRecorder();
          _startTime = DateTime.now();
        }
      },
      child: Icon (
        (_iconFlag)? Icons.stop : Icons.mic,
        size: 75,
        color: Colors.black,
      ),
    );
  }
}