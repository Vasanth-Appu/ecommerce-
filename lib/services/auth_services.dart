



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../Screens/Login/components/login_form.dart';
import '../farmer/welcomefarmer.dart';
import '../initial.dart';
import '../user/regsucc.dart';
import '../user/welcomescre.dart';

class AuthService {
  createuser(data, context) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
       DatabaseReference _database = FirebaseDatabase.instance.reference();
       FirebaseAuth _auth = FirebaseAuth.instance;
      User? user = _auth.currentUser;
      String? userId = user?.uid;

      DatabaseEvent databaseEvent = await _database.child('User').once();
      DataSnapshot dataSnapshot = databaseEvent.snapshot;

       _database.child('User').child(userId!).set({
        'email': data['email'],
        'password': data['password'],

        'mobile': data['mobile'],
        'username': data['name'],
        'ukey':userId ,

      });


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registered Successfully')),

      );
      sendVerificationEmail();

    } catch (e) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Sign Up Failed"),
          content: Text(e.toString()),

        );
      });
    }
  }


  createdonoruser(data, context) async {
    try {
      print("lllllllllll");
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],

      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registered Successfully')),

      );
      sendVerificationEmail();





      } catch (e) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Sign Up Failed"),
          content: Text(e.toString()),

        );
      });
    }
  }

  login(data, context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
        if (user!.emailVerified) {
          print("User is verified. Proceed with login.");
          // Perform the actions for a logged-in verified user.

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login  Successfully')),

          );

          Navigator.pushReplacement(
              context as BuildContext, MaterialPageRoute(builder: (context) => Userwelcome(),));

        } else {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text("Email not verified"),
              content: Text("Please Verify Your Email"),

            );
          });



          print("User is not verified. Please check your email for the verification link.");


        }
      }





    } catch (e) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Login Error"),
          content: Text(e.toString()),

        );
      });
    }
  }
  logindonor(data, context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
        if (user!.emailVerified) {
          print("User is verified. Proceed with login.");
          // Perform the actions for a logged-in verified user.

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login  Successfully')),

          );

          Navigator.pushReplacement(
              context as BuildContext, MaterialPageRoute(builder: (context) => farmerwelcome(),));

        } else {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text("Email not verified"),
              content: Text("Please Verify Your Email"),

            );
          });



          print("User is not verified. Please check your email for the verification link.");


        }
      }





    } catch (e) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Login Error"),
          content: Text(e.toString()),

        );
      });
    }
  }
  Future<void> sendVerificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();



      print("Verification email sent to ${user.email}");
    }
  }




}





