import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pranav_rathod_trail_project/floatingRecord.dart';

// import 'package:stop_watch_timer_example/count_up_timer_page.dart';
class recordVoice extends StatefulWidget {
  @override
  _recordVoice createState () => _recordVoice();
  // State<StatefulWidget> createState() {
  //   // TODO: implement createState
  //   throw UnimplementedError();
  // }

}

class _recordVoice extends State<recordVoice>
{
  var _clickFlag = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Colors.purple, Colors.orange]
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Record Voice'),
          centerTitle: true,
        ),
        body: Center(
          child : Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Record Voice',
                  style: TextStyle(
                    fontSize: 50,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = Colors.blue[700]!,)
              ),
              GestureDetector(
                child: floatingRecord(),
                onTap: () {
                  // _clickFlag = !_clickFlag;
                  setState(() {
                    _clickFlag = !_clickFlag;
                  });
                },
              ),
              Text("Tap Icon to Start/Stop",
                  style: TextStyle(

                    fontSize: 35,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = Colors.blue[700]!,)
              ),
              // floatingRecord(),
            ],
          ),
          )

      ),
    );
    // throw UnimplementedError();
  }

}
