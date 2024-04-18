import 'package:ecommercefarmer/farmer/farmerregister.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';
import '../services/auth_services.dart';
import '../utilll/appvalidator.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(new MaterialApp(
    home: new  farmerlogin(),



  ));




}

class farmerlogin extends StatefulWidget {
  farmerlogin({super.key});

  @override
  State<farmerlogin> createState() => _LoginPageState();
}

class _LoginPageState extends State<farmerlogin> {

  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  final _emailcontroller=TextEditingController();

  final _passwordcontroller=TextEditingController();

  var isLoader=false;

  var authservice=AuthService();

  Future<void> _submitform() async {

    setState(() {
      isLoader=true;


    });





    var data={

      "email":_emailcontroller.text,
      "password":_passwordcontroller.text,

    };





    await authservice.logindonor(data,context);



    setState(() {
      isLoader=false;


    });










  }



  var appvalidator=AppValidator();

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  // Custom logo or image can be added here
                  Image.asset(
                    'assets/images/farmer-100.png', // Replace with your logo image path
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Welcome back!\nLet\'s makes health!',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  _buildInputField("Email", Icons.email, _emailcontroller),
                  const SizedBox(height: 10),
                  _buildInputField("Password", Icons.lock, _passwordcontroller, isPassword: true),
                  const SizedBox(height: 20),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      isLoader ? print("Loading") : _submitform();
                    },
                    child: isLoader ? Center(child: CircularProgressIndicator()) : Text('Login', style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black87,
                      onPrimary: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => farmerregister()));
                    },
                    child: Text(
                      'Not a member? Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, IconData suffixIcon, TextEditingController controller, {bool isPassword = false}) {
    return Container(
      width: 380,
      height: 60,
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.blue,
        keyboardType: TextInputType.emailAddress,
        obscureText: isPassword,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: _buildInputDecoration(label, suffixIcon),
        validator: (value) {
          // Implement your validation logic here
          return null;
        },
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
      hintText: label,
      suffixIcon: Icon(suffixIcon, color: Colors.blue),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.transparent),
      ),
    );
  }

  Widget _buildSocialButton(String imagePath, String text) {
    return ElevatedButton(
      onPressed: () {
        // Implement your social login functionality
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }


}

