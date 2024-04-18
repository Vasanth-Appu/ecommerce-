import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'listely.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(orders());
}

class orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase ListView Builder',
      home: MyHomePageee(),
    );
  }
}

class MyHomePageee extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class da {
  final String cname;
  final String mobile;
  final String address;
  final String pname;
  final String quantity;
  final String orderdate;


  da(
      this.cname,
      this.mobile,
      this.address,
      this.pname,
      this.quantity,
      this.orderdate,

      );
}

class _MyHomePageState extends State<MyHomePageee> {
  String authh = " ";

  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.reference().child('Orderplaced');
  List<da> dataList = [];

  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    String? userId = user?.uid;
    authh = userId!;
    print(authh);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Placed Orders'),
      ),
      body: _buildListViewWithDivider(),
    );
  }

  Widget _buildListViewWithDivider() {
    return StreamBuilder(
      stream: _databaseReference

          .orderByChild('status')
          .equalTo('placed')
          .onValue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
          return Center(
            child: Text(
              'No requests',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          );
        } else {
          Map<String, dynamic> data =
          Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map);

          List<String> itemIds = data.keys.toList();

          return ListView.builder(
            itemCount: itemIds.length * 2 - 1, // Add dividers
            itemBuilder: (context, index) {
              if (index.isOdd) {
                // Divider
                return Divider();
              } else {
                // Item
                int itemIndex = index ~/ 2;
                String itemId = itemIds[itemIndex];
                String cname = data[itemId]['cname']?.toString() ?? '';
                String date = data[itemId]['orderdate']?.toString() ?? '';
                String mobile = data[itemId]['mobile']?.toString() ?? '';
                String Address = data[itemId]['Address']?.toString() ?? '';
                String price = data[itemId]['price']?.toString() ?? '';
                String option = data[itemId]['option']?.toString() ?? '';
                String pname = data[itemId]['pname']?.toString() ?? '';
                String quantity = data[itemId]['quantity']?.toString() ?? '';
                List<String> dateParts = date.split(' ');
                // Assuming orderDate is in the format 'YYYY-MM-DD HH:MM:SS'
                String formattedDate = dateParts[0]; // Displaying

                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(cname),
                      onTap: () {
                        // Add your onTap logic here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => listely(
                              cname: cname,
                              Address: Address,
                              mobile: mobile,
                              pname: pname,
                              price: price,
                              quantity: quantity,
                              option: option,
                              // Pass other fields as needed
                            ),
                          ),
                        );
                      },
                      subtitle: Text(formattedDate),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }}