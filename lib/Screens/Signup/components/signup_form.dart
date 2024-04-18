import 'package:ecommercefarmer/user/regsucc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../../firebase_options.dart';
import '../../../services/auth_services.dart';
import '../../Login/components/login_form.dart';
import '../../Login/login_screen.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    runApp(new MaterialApp(
      home: new SignUpForm(),


    ));
  } catch (e) {
    print('Firebase initialization error: $e');
  }


}

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String email = "", password = "", name = "", confirmPassword = "";
  final _emailcontroller=TextEditingController();



  final _passwordcontroller=TextEditingController();
  final _mobilecontroller=TextEditingController();

  final _namecontroller=TextEditingController();
  var authservice=AuthService();


  Future<void> _submitform() async {
    try {
      var data = {
        "email": _emailcontroller.text,
        "password": _passwordcontroller.text,
        "mobile": _mobilecontroller.text,
        "name": _namecontroller.text,
      };

      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailcontroller.text,
        password: _passwordcontroller.text,
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
        'ukey': userId,
      });

      // Check if the widget is still mounted before performing UI-related actions
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registered Successfully')),
        );
        sendVerificationEmail();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => regsucc()),
        );
      }
    } catch (e) {
      // Check if the widget is still mounted before showing dialog
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Sign Up Failed"),
              content: Text(e.toString()),
            );
          },
        );
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _emailcontroller,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _passwordcontroller,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _namecontroller,
             textInputAction: TextInputAction.next,

              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "User name",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _mobilecontroller,
              textInputAction: TextInputAction.next,

              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Mobile number",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.mobile_friendly),
                ),
              ),
            ),
          ),





          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {


              _submitform();






            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


Future<void> sendVerificationEmail() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null && !user.emailVerified) {
    await user.sendEmailVerification();



    print("Verification email sent to ${user.email}");
  }
}