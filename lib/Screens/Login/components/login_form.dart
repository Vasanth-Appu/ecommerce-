import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../../services/auth_services.dart';
import '../../Signup/signup_screen.dart';



void main() {
  runApp(new MaterialApp(
    home: new  LoginForm(),



  ));




}
class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailcontroller=TextEditingController();
  String email = "", password = "", name = "", pic = "", username = "", id = "";


  final _passcontroller=TextEditingController();




  var authservice=AuthService();
void _submitform() async {
  var data = {

    "email": _emailcontroller.text,
    "password": _passcontroller.text,

  };



  await authservice.login(data, context);







}








  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller:_emailcontroller,
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
              controller:_passcontroller,
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
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {

              _submitform();




            },
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
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
