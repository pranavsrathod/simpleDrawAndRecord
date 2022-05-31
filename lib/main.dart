import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pranav_rathod_trail_project/draw.dart';
import 'package:pranav_rathod_trail_project/recordVoice.dart';


// Trial Project - Storing User Interactions data from handheld devices
// Name : Pranav S Rathod. (pratho2@uic.edu, 669687574)
// Dr Nikita Soni


// Summary : This projects enables user to interact with the app through drawing on the canvas or recording voice input and logging it into
// Firebase's cloud firestore


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


// Initial Screen
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/' : (context) => const MyHomePage(title: 'User Interactions : Trial Project'),
        '/Voice' : (context) => recordVoice(),
        'Draw' : (context) => draw()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'User Interactions : Trial Project'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Colors.purple, Colors.blue]
          ),
        ),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Card(
                elevation: 15,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, 'Draw');
                  },
                  child: Container (
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [Colors.blue, Colors.green, Colors.yellow]
                      ),
                    ),
                    height: 200,
                    width: 200,
                    child:
                    Center(
                      child: Text('Draw',
                          style: TextStyle(
                            fontSize: 50,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = Colors.black,)
                      ),
                    ),
                  ),
                )
              ),
              Card(
                  elevation: 15,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/Voice');
                    },
                    child: Container (
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Colors.blue, Colors.purple, Colors.red]
                        ),
                      ),
                      height: 200,
                      width: 200,
                      child:
                      Center(
                        child: Text('Record',
                            style: TextStyle(
                              fontSize: 45,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Colors.black,)
                        ),
                      ),
                    ),
                  )
              )

            ],
          ),
        ),
      ),
    );
  }
}
