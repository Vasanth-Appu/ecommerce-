import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),



  ));




}
/*class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Text("Tutor joes")






    );
  }
}*/
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
/*
String value='Text';
void Clickme(){

setState(() {
value='tutor';


});


}
*/





  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: new AppBar(
  title:new Text("Tutor joes"),
backgroundColor: Colors.red),
body: new Container(
child:new Text('Welcome to flutter'),


),
    );





  }
}








