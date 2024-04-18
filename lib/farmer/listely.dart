import 'package:flutter/material.dart';

class listely extends StatelessWidget {
  final String cname;
  final String Address;
  final String mobile;
  final String pname;
  final String price;
  final String quantity;
  final String option;

  listely({
    required this.cname,
    required this.Address,
    required this.mobile,
    required this.pname,
    required this.price,
    required this.quantity,
    required this.option,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Information'),
     backgroundColor: Colors.deepPurpleAccent,

      ),
      body:


      Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          width: 300, // Set your desired width
          height: 250, // Set your desired height
          child: Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customer name: $cname',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Address: $Address'),
                  Text('Mobile: $mobile'),
                  Text('Product name: $pname'),
                  Text('Quantity: $quantity'),
                  Text('Price: $price'),
                  Text('Option: $option'),
                  Text('Status: Placed'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
