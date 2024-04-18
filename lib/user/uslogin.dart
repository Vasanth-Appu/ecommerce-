import 'package:flutter/material.dart';
import 'package:ecommercefarmer/user/usreg.dart';
import '../services/auth_services.dart';

class CustomerLoginScreen extends StatelessWidget {
  final _emailcontroller = TextEditingController();
  final _passcontroller = TextEditingController();
  final AuthService authservice = AuthService();

  void _submitform(BuildContext context) async {
    var data = {
      "email": _emailcontroller.text,
      "password": _passcontroller.text,
    };

    await authservice.login(data, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailcontroller,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passcontroller,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submitform(context); // Pass context to _submitform
                },
                child: Text('Login'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Navigate to registration screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomerRegistrationScreen()),
                  );
                },
                child: Text('Create an account'),
              ),
              // TextButton(
              //   onPressed: () {
              //     // Implement forgot password functionality
              //   },
              //   child: Text('Forgot password?'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
