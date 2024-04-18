import 'package:ecommercefarmer/farmer/farmerlogin.dart';
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
    home: new  farmerregister(),



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
class farmerregister extends StatefulWidget {
  farmerregister({super.key});

  @override
  State<farmerregister> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<farmerregister> {
  /*@override
  State<MyForm> createState() => _MyAppState();
}

class _MyAppState extends State<MyForm> {*/
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  final _emailcontroller = TextEditingController();


  final _passwordcontroller = TextEditingController();

  var isLoader = false;

  var authservice = AuthService();

  Future<void> _submitform() async {
    setState(() {
      isLoader = true;
    });


    var data = {

      "email": _emailcontroller.text,
      "password": _passwordcontroller.text,

    };


    await authservice.createdonoruser(data, context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => farmerlogin(),));


    setState(() {
      isLoader = false;
    });
  }


  var appvalidator = AppValidator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set your desired background color
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // logo
                const Icon(
                  Icons.person,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 50),
                // welcome back, you've been missed!
                Text(
                  'Welcome! Let\'s get started!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                // Email textfield
                _buildInputField("Email", Icons.email, _emailcontroller),
                const SizedBox(height: 10),
                // Password textfield
                _buildInputField("Password", Icons.lock, _passwordcontroller,
                    isPassword: true),
                const SizedBox(height: 40),
                // Create button
                SizedBox(
                  height: 60.0,
                  width: 170,
                  child: ElevatedButton(
                    onPressed: () {
                      isLoader ? print("Loading") : _submitform();
                    },
                    child: isLoader
                        ? Center(child: CircularProgressIndicator())
                        : Text('Create', style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87, // Background color
                      onPrimary: Colors.white, // Text color
                      elevation: 4, // Elevation (shadow)
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            5.0), // Border radius
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, IconData suffixIcon,
      TextEditingController controller, {bool isPassword = false}) {
    return Container(
      width: 380,
      height: 60,
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white),
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
      fillColor: Colors.grey[800],
      // Set your desired background color
      hintText: label,
      suffixIcon: Icon(suffixIcon, color: Colors.white),
      filled: true,
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
}