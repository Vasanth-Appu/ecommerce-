import 'package:ecommercefarmer/farmer/innerlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(userlist());
}

class userlist extends StatelessWidget {
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


class da{
  final String email;
  final String mobile;
  final String username;
  final String ukey;









  da(this.email, this.mobile,this.username,this.ukey

      );



}






class _MyHomePageState extends State<MyHomePageee> {

  String authh=" ";

  final DatabaseReference _databaseReference =

  FirebaseDatabase.instance.reference().child('User');
  List<da> dataList = [];

  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    String? userId = user?.uid;
    authh=userId!;
    print(authh);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,

        title: Text('Chat List'),


      ),
      body: _buildListViewWithDivider(),

    );
  }
  Widget _buildListViewWithDivider() {
    return StreamBuilder(
      stream: _databaseReference

          .onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data?.snapshot.value != null) {
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
                String cname = data[itemId]['username']?.toString() ?? '';
                String date = data[itemId]['ukey']?.toString() ?? '';
                String caddress = data[itemId]['email']?.toString() ?? '';
                String cmobile = data[itemId]['mobile']?.toString() ?? '';


                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(cname),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'assets/images/hh.png',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Add your button logic here
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  innerlist(
                                    username: cname,
                                    ukey: date,
                                    email: caddress,
                                    mobile: cmobile,







                                    // Pass other fields as needed



                                  ),
                            ),
                           );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        child: Text(
                          'View',
                          style: TextStyle(color: CupertinoColors.white),
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}