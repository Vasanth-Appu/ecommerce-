



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'imageurlview.dart';
import 'listproduct.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(homeuser());
}

class Product {
  final String fname;
  final String des;
  final String price;
  final String image;
  final String fkey;
  final String udkey;
  final String pname;
  final String quantity;
  final String location;
  final String address;
  final String category;
  final String gmap;

  Product({
    this.fname = '',
    this.des = '',
    this.price = '',
    this.image = '',
    this.fkey = '',
    this.udkey = '',
    this.pname = '',
    this.quantity = '',
    this.location = '',
    this.address = '',
    this.category = '',
    this.gmap = '',
  });

  @override
  String toString() {
    return 'Product{fname: $fname, des: $des, price: $price, image: $image, gmap:$gmap}';
  }
}

class homeuser extends StatelessWidget {
  const homeuser({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  late List<Product> productList;

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Stream<List<Product>> productsStream;

  @override
  void initState() {
    super.initState();
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    String? userId = user?.uid;
    print('Email from widget: $userId');

    productsStream = fetchProductsRealtime();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: productsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          )
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Product> productList = snapshot.data!;

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        // FaIcon(FontAwesomeIcons.search),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.73,
                        ),
                        itemCount: productList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Navigate to details page or perform action on item click

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageView(
                                    imageUrl: productList[index].image,
                                  ),
                                ),
                              );

                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.maxFinite,


                                    decoration: BoxDecoration(
                                      color: Colors.white60,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.network(
                                              productList[index].image,
                                              height: 150,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
                                                print('Error loading image: $error');
                                                return Center(
                                                  child: Text('Error loading image'),
                                                );
                                              },
                                            ),
                                          ),











                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  productList[index].fname,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '\Rs${productList[index].price}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  '${productList[index].category}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                ElevatedButton(
                                  onPressed: () {
                                    // Perform the desired action when the button is pressed
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Item(
                                          selectedProduct: productList[index],
                                        ),
                                      ),
                                    );




                                    print('Button Pressed');
                                  },
                                  child: Text('View Detail'),
                                ),




                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Stream<List<Product>> fetchProductsRealtime() {
    DatabaseReference productsRef = FirebaseDatabase.instance.reference().child('Product');

    return productsRef.onValue.asyncMap((event) async {
      List<Product> products = [];

      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? productMap = event.snapshot.value as Map?;
        if (productMap != null) {
          List<Future<Product>> futures = [];

          productMap.forEach((key, value) {
            String udkey = value['udkey'];
            Future<Product> productFuture = getProductDetails(value, udkey);
            futures.add(productFuture);
          });

          products = await Future.wait(futures);
        }
      }

      return products;
    });
  }

  Future<Product> getProductDetails(Map<dynamic, dynamic> value, String udkey) async {
    String imageUrl = await getDownloadUrl('product_images/$udkey.jpg');
    return Product(
      fname: value['fname'] ?? '',
      des: value['des'] ?? '',
      price: value['price'] ?? '',
      image: imageUrl,
      pname: value['pname'] ?? '',
      quantity: value['quantity'] ?? '',
      fkey: value['fkey'] ?? '',
      udkey: value['udkey'] ?? '',
      location: value['location'] ?? '',
      category: value['category'] ?? '',
      address: value['address'] ?? '',
      gmap: value['gmap'] ?? '',







    );
  }

  Future<String> getDownloadUrl(String path) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(path);
    return await ref.getDownloadURL();
  }
}
