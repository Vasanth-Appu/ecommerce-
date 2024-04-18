import 'package:ecommercefarmer/user/homesecond.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'homeuser.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
  ));
  runApp(homeinitial());
}

class homeinitial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homeuser(),
      debugShowCheckedModeBanner: false,
    );
  }
}