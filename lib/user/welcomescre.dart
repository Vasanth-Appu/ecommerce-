import 'package:ecommercefarmer/user/uslogin.dart';
import 'package:ecommercefarmer/user/usreg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Screens/Login/login_screen.dart';
import 'home initial.dart';
import 'homeuser.dart';
import 'myord.dart';

void main() {
  runApp(new MaterialApp(
    home: new Userwelcome(),



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
class Userwelcome extends StatefulWidget {
  const Userwelcome({super.key});

  @override
  State<Userwelcome> createState() => _MyAppState();
}

class _MyAppState extends State<Userwelcome> {
/*
String value='Text';
void Clickme(){

setState(() {
value='tutor';


});


}
*/

  int _currentIndex = 0;
  final List<Widget> _pages = [
    myord(),
    homeinitial(),

  ];

  var islogoutloading=false;

  logout() async{
  setState(() {
  islogoutloading=true;

  });

  await FirebaseAuth.instance.signOut();

  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  CustomerLoginScreen(

  ),));






  setState(() {
  islogoutloading=false;

  });


  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Welcome'),
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: islogoutloading
                ? CircularProgressIndicator()
                : Icon(Icons.exit_to_app, color: Colors.white),
          ),
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
            icon: Icon(Icons.shopping_cart),
            label: 'My Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pageview),
            label: 'Products',
          ),

        ],
        selectedItemColor: Colors.red, // Customize the selected item color
        unselectedItemColor: Colors.grey, // Customize the unselected item color
        backgroundColor: Colors.white, // Customize the background color
        elevation: 10, // Add elevation to the bar
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold), // Customize the selected label style
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal), // Customize the unselected label style
      ),
    );
  }
}