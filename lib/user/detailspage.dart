import 'dart:async';

import 'package:ecommercefarmer/user/welcomescre.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class YourDetailsPage extends StatefulWidget {
  final String pname;
  final String des;
  final String quantity;
  final String location;
  final String price;
  final String fname;
  final String address;
  final String fkey;
  final String udkey;
  final String category;
  final String image;

  YourDetailsPage({
    required this.pname,
    required this.des,
    required this.quantity,
    required this.location,
    required this.price,
    required this.fname,
    required this.address,
    required this.fkey,
    required this.udkey,
    required this.category,
    required this.image,
  });











  @override
  _DetailsContentState createState() => _DetailsContentState();
}

class _DetailsContentState extends State<YourDetailsPage> {
  late Timer _timer;
  bool showBanner = true;
  String selectedOption = 'Home Delivery';
String authh=" ";




  final customerNameController=TextEditingController();
  final addressController=TextEditingController();
  final mobileController=TextEditingController();




  Future<void> _submitDataToDatabase() async {

    if (selectedOption == 'Home Delivery') {
      DateTime currentDate = DateTime.now();
      DateTime currentDateOnly = DateTime(
          currentDate.year, currentDate.month, currentDate.day);
      print("Current Date: $currentDateOnly");
// Your input string

      String initialvalue='40';
      DatabaseReference _database = FirebaseDatabase.instance.reference();

      DatabaseEvent databaseEvent = await _database.child('Orderplaced').once();
      DataSnapshot dataSnapshot = databaseEvent.snapshot;

      await _database.child('Orderplaced').child(widget.udkey).set({
        'address': widget.address,
        'category': widget.category,
        'des': widget.des,
        'fkey': widget.fkey,
        'fname': widget.fname,
        'image': widget.image,
        'location': widget.location,
        'pname': widget.pname,
        'price': widget.price,
        'ckey': authh,
        'deliverycharge': initialvalue,
        'quantity': widget.quantity,
        'udkey': widget.udkey,
        'cname': customerNameController.text,
        'mobile': mobileController.text,
        'Address': addressController.text,
        'orderdate': currentDateOnly.toString(),
        'udkey': widget.udkey,
        'option': selectedOption,
        'status': 'placed',


      });




      customerNameController.clear();
      addressController.clear();
      mobileController.clear();


      DatabaseReference reference = FirebaseDatabase.instance.reference().child(
          'Product');

      // Using remove method
      reference.child(widget.udkey).remove().then((_) {
        print("Data deleted successfully!");
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Order placed Successfully',
            style: TextStyle(
              color: Colors.white, // Set the text color
              fontWeight: FontWeight.bold, // Set the font weight
              fontSize: 16, // Set the font size
            ),
          ),
          backgroundColor: Colors.green, // Set the background color of the SnackBar
        ),
      );



    }
    if (selectedOption == 'Pick Up') {
      DateTime currentDate = DateTime.now();
      DateTime currentDateOnly = DateTime(
          currentDate.year, currentDate.month, currentDate.day);
      print("Current Date: $currentDateOnly");
// Your input string

      String initialvalue='0';


      if (selectedOption == 'Home Delivery') {
        DatabaseReference _database = FirebaseDatabase.instance.reference();


        DatabaseEvent databaseEvent = await _database.child('Orderplaced')
            .once();
        DataSnapshot dataSnapshot = databaseEvent.snapshot;

        await _database.child('Orderplaced').child(widget.udkey).set({
          'address': widget.address,
          'category': widget.category,
          'des': widget.des,
          'fkey': widget.fkey,
          'ckey': authh,
          'fname': widget.fname,
          'image': widget.image,
          'location': widget.location,
          'deliverydate': 'delivered with in two days',

          'pname': widget.pname,
          'price': widget.price,
          'deliverycharge': initialvalue,
          'quantity': widget.quantity,
          'udkey': widget.udkey,
          'cname': customerNameController.text,
          'mobile': addressController.text,
          'Address': mobileController.text,
          'orderdate': currentDateOnly.toString(),
          'udkey': widget.udkey,
          'option': selectedOption,
          'status': 'placed',


        });


        customerNameController.clear();
        addressController.clear();
        mobileController.clear();


        DatabaseReference reference = FirebaseDatabase.instance.reference()
            .child(
            'Product');

        // Using remove method
        reference.child(widget.udkey).remove().then((_) {
          print("Data deleted successfully!");
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Order placed Successfully',
              style: TextStyle(
                color: Colors.white, // Set the text color
                fontWeight: FontWeight.bold, // Set the font weight
                fontSize: 16, // Set the font size
              ),
            ),
            backgroundColor: Colors
                .green, // Set the background color of the SnackBar
          ),
        );
      }else {

        DatabaseReference _database = FirebaseDatabase.instance.reference();


        DatabaseEvent databaseEvent = await _database.child('Orderplaced')
            .once();
        DataSnapshot dataSnapshot = databaseEvent.snapshot;

        await _database.child('Orderplaced').child(widget.udkey).set({
          'address': widget.address,
          'category': widget.category,
          'des': widget.des,
          'fkey': widget.fkey,
          'ckey': authh,
          'fname': widget.fname,
          'image': widget.image,
          'location': widget.location,
          'deliverydate': 'no',

          'pname': widget.pname,
          'price': widget.price,
          'deliverycharge': initialvalue,
          'quantity': widget.quantity,
          'udkey': widget.udkey,
          'cname': customerNameController.text,
          'mobile': addressController.text,
          'Address': mobileController.text,
          'orderdate': currentDateOnly.toString(),
          'udkey': widget.udkey,
          'option': selectedOption,
          'status': 'placed',


        });


        customerNameController.clear();
        addressController.clear();
        mobileController.clear();


        DatabaseReference reference = FirebaseDatabase.instance.reference()
            .child(
            'Product');

        // Using remove method
        reference.child(widget.udkey).remove().then((_) {
          print("Data deleted successfully!");
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Order placed Successfully',
              style: TextStyle(
                color: Colors.white, // Set the text color
                fontWeight: FontWeight.bold, // Set the font weight
                fontSize: 16, // Set the font size
              ),
            ),
            backgroundColor: Colors
                .green, // Set the background color of the SnackBar
          ),
        );
      }

    }

  }


  @override
  void initState() {
    super.initState();
    // Show the banner for 20 seconds
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    String? userId = user?.uid;

    if (userId != null) {
      setState(() {
        authh = userId;
      print(authh);
      });

      // Construct the path in the Realtime Database using the userId


      // Fetch data from the Realtime Database


    }

    _timer = Timer(Duration(seconds: 10), () {
      setState(() {
        showBanner = false;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return

      Column(
      children: [
        if (showBanner)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            child: Card(
              color: Colors.lightBlueAccent, // Customize banner color
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Home Delivery available only for below 20kms...',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

        Expanded(
          child: Container(
            // Your content here
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Choose Category',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent),
                ),
                SizedBox(height: 20),
                // Your delivery options UI
                DropdownButton<String>(
                  value: selectedOption,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedOption = newValue!;
                    });
                  },
                  items: <String>['Home Delivery', 'Pick Up'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),



                SizedBox(height: 20),

                // ... (existing code)

                TextFormField(
                  controller: customerNameController,
                  decoration: InputDecoration(labelText: 'Customer Name'),
                ),

                SizedBox(height: 20),

                // ... (existing code)

                TextFormField(
                  controller: mobileController,
                  decoration: InputDecoration(labelText: 'Mobile number'),
                ),

                SizedBox(height: 20),

                // ... (existing code)

                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                ),


                SizedBox(height: 20),

// Add a TextFormField for transportation charge
                if (selectedOption == 'Home Delivery')
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.blue), // Add a border for highlighting
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextFormField(
                      // You can customize this TextFormField based on your requirements

                      readOnly: true,
                      initialValue: 'Rs 40', // Set the transportation charge value
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold), // Customize the style of the initial value
                      decoration: InputDecoration(
                        labelText: 'Transportation Charge',
                        enabled: false,

                        labelStyle: TextStyle(color: Colors.blue), // Customize label color
                        prefixStyle: TextStyle(color: Colors.blue), // Customize prefix color
                      ),
                    ),
                  ),







                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle the selected delivery option
                    _submitDataToDatabase();
                  },
                  child: Text('Place Order'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
