import 'package:ecommercefarmer/Screens/Login/login_screen.dart';
import 'package:ecommercefarmer/farmer/farmerlogin.dart';
import 'package:ecommercefarmer/farmer/welcomefarmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




void main() {
  runApp(new MaterialApp(
    home: new AuthGate2(),



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
class AuthGate2 extends StatelessWidget {
  const AuthGate2({super.key});

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
    return StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),

        builder: (context,snapshot){
          if(!snapshot.hasData) {
            return farmerlogin();

          }
          return farmerwelcome();
        }

    );

  }
}








