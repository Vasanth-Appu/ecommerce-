import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chatpagee.dart';
import 'detailspage.dart';
import 'homeuser.dart';

class Item extends StatefulWidget {
  final Product selectedProduct;

  const Item({Key? key, required this.selectedProduct}) : super(key: key);

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.9,
                    decoration: BoxDecoration(
                      color: Color(0xffbccaca),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Center(
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 75,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 75,
                                      backgroundColor:
                                      Color(0xffbccaca).withOpacity(0.5),
                                    ),
                                  ),
                                  Image.network(
                                    widget.selectedProduct.image,
                                    height: 200,
                                  )
                                ],
                              ),
                            ),
                          ),
                          flex: 6,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Color(0xff9db1b1),
                            child: Padding(
                              padding: const EdgeInsets.all(22.0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/shopping-bag-outline.png',
                                    color: Colors.white,
                                    height: 35,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 30,
                      left: 10,
                      child: Icon(Icons.arrow_back_ios,
                        color: Colors.white,))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.selectedProduct.pname,
                      style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 23),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: Row(children: [
                        CircleAvatar(
                          backgroundColor: Colors.black54,
                          radius: 5,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          widget.selectedProduct.des,
                          style: TextStyle(
                              color: Colors.black54, fontSize: 16),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: Row(children: [
                        CircleAvatar(
                          backgroundColor: Colors.black54,
                          radius: 5,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          widget.selectedProduct.quantity,
                          style: TextStyle(
                              color: Colors.black54, fontSize: 16),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: Row(children: [
                        CircleAvatar(
                          backgroundColor: Colors.black54,
                          radius: 5,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          widget.selectedProduct.location,
                          style: TextStyle(
                              color: Colors.black54, fontSize: 16),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black54,
                      radius: 5,
                    ),
                    SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        // Handle tap action here, e.g., open a URL or navigate to a new screen
                        _launchMap();

                        print('Link tapped!');
                      },
                      child: Text(
                        'Click here',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Rs ${widget.selectedProduct.price.toString()}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Add your logic for the Buy button here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => YourDetailsPage(
                              pname: widget.selectedProduct.pname,
                              quantity: widget.selectedProduct.quantity,
                              price: widget.selectedProduct.price,
                              location: widget.selectedProduct.location,
                              address: widget.selectedProduct.address,
                              category: (widget.selectedProduct.category),
                              des: widget.selectedProduct.des,
                              fkey: widget.selectedProduct.fkey,
                              udkey: widget.selectedProduct.udkey,
                              fname: widget.selectedProduct.fname,
                              image: widget.selectedProduct.image,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(40)),
                          color: Color(0xffce1a06),
                        ),
                        child: Text(
                          'Buy',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 27,
                          ),
                        ),
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      // Handle the onPressed event for the chat button
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatView(
                            pname: widget.selectedProduct.pname,
                            quantity: widget.selectedProduct.quantity,
                            price: widget.selectedProduct.price,
                            location: widget.selectedProduct.location,
                            address: widget.selectedProduct.address,
                            category: (widget.selectedProduct.category),
                            des: widget.selectedProduct.des,
                            fkey: widget.selectedProduct.fkey,
                            udkey: widget.selectedProduct.udkey,
                            fname: widget.selectedProduct.fname,
                            image: widget.selectedProduct.image,
                          ),
                        ),
                      );
                    },
                    child: Icon(Icons.chat),
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchMap() async {
    final mapAddress = widget.selectedProduct.gmap;
    final url = 'https://www.google.com/maps/search/?api=1&query=$mapAddress';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
