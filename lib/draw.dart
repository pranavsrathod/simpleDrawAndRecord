
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pranav_rathod_trail_project/floatingRecord.dart';

class draw extends StatefulWidget{
  @override
  _draw createState () => _draw();
}

class _draw extends State<draw>
{


  final startTime = DateTime.now().millisecondsSinceEpoch;
  var _lastX, _lastY;
  final _coordinates = <Offset>[];
  final _paths = <Path> [];

  // makes a dataset that will be then lgged into the fire store
  returnSubcollection (String status, double x, double y, var timeStamp){
    var newSubCollection = {
      "Status" : status,
      "Coordinates" : [x, y],
      "TimeStamp" : timeStamp
    };

    return newSubCollection;
  }

  // on start of drawing
  void startMovement (double x, double y) {
    // print ("Movement Started");
    var newPath = Path();
    newPath.moveTo(x, y);
    // create new dynamic instance, caluclate the timestamp in milliseconds
    var newSubcollection = returnSubcollection ("Touch Start", x, y, (DateTime.now().millisecondsSinceEpoch - startTime));
    // var _db = FirebaseDatabase.instance.reference().child("draw");
    // _db.set(newSubcollection);
    var db = FirebaseFirestore.instance;
    db.collection("draw").add(newSubcollection);
    // print (newSubcollection);
    _paths.add(newPath);
  }

  // when the pointer is on screen and moving...
  void updateMovement (double x, double y) {

    // create new dynamic instance, caluclate the timestamp in milliseconds
    var newCollection = returnSubcollection ("Touch Update", x, y, (DateTime.now().millisecondsSinceEpoch - startTime));
    // print (newCollection);
    var db = FirebaseFirestore.instance;
    db.collection("draw").add(newCollection).then((value) => print ("Updated Successfully") );
    // print ("x : ${x} , Y : ${y} TimeStamp : ${timeNow}");
    setState((){
      _paths.last.lineTo(x, y);
    });
  }

  // when the user lifts off their finger/pointer
  void endMovement (double x, double y) {
    // create new dynamic instance, caluclate the timestamp in milliseconds
    var newCollection = returnSubcollection ("Touch Stop", x, y, (DateTime.now().millisecondsSinceEpoch - startTime));
    // print (newCollection);
    var db = FirebaseFirestore.instance;
    db.collection("draw").add(newCollection);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text ("Record, Draw on the Screen"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onForcePressStart: (forcePressDetails){
          print ("Pressure ${forcePressDetails.pressure}");
        },
          onForcePressUpdate: (forcePressDetails){
            print ("Pressure ${forcePressDetails.pressure}");
          },
        onPanDown: (details){
          _coordinates.add(details.globalPosition);
          _lastX = details.localPosition.dx;
          _lastY = details.localPosition.dy;
          startMovement(details.localPosition.dx, details.localPosition.dy);
          // print(details.globalPosition);
        },
          onPanUpdate: (details) {
            _lastX = details.localPosition.dx;
            _lastY = details.localPosition.dy;
            updateMovement(details.localPosition.dx, details.localPosition.dy);
            // print(details.globalPosition);
          },
          onPanEnd: (details) {

            endMovement(_lastX, _lastY);
          // print ("Stop");
          },
        child: Center(
          child: CustomPaint(
            painter: SimpleDraw(_paths, Colors.purple),
            child : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              // color: Colors.grey
            )
          ),
        )
      ),
        floatingActionButton: floatingRecord(),
    );
  }

}

class SimpleDraw extends CustomPainter{
  final List<Path> coordinates;
  // final String shape;
  var setColor;
  SimpleDraw(this.coordinates, this.setColor);

  @override
  void paint(Canvas canvas, Size size) {
    for (var stroke in coordinates){
      final paint = Paint();
      paint.color = setColor;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 5;
      canvas.drawPath (stroke, paint);

    }
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  
}