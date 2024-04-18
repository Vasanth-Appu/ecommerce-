import 'package:ecommercefarmer/Screens/Login/login_screen.dart';
import 'package:ecommercefarmer/farmer/addproduct.dart';
import 'package:ecommercefarmer/farmer/farmerlogin.dart';
import 'package:ecommercefarmer/farmer/userlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'orders.dart';

void main() {
  runApp(new MaterialApp(
    home: new farmerwelcome(),



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
class farmerwelcome extends StatefulWidget {
  const farmerwelcome({super.key});

  @override
  State<farmerwelcome> createState() => _MyAppState();
}

class _MyAppState extends State<farmerwelcome> {
/*
String value='Text';
void Clickme(){

setState(() {
value='tutor';


});


}
*/
  int _currentIndex = 0;

  // Define your pages/screens here
  final List<Widget> _pages = [
    orders(),
    addproduct(),
   userlist(),
  ];






  var islogoutloading=false;

  logout() async{
    setState(() {
      islogoutloading=true;

    });

    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  farmerlogin(

    ),));






    setState(() {
      islogoutloading=false;

    });


  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Welcome'),
        actions: [







          IconButton(onPressed: (){logout();}, icon:
          islogoutloading ? CircularProgressIndicator():


          Icon(Icons.exit_to_app,color: Colors.white,)),

        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}


















