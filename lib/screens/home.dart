import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/buttons/brandButton.dart';
import '/tiles/productTile.dart';
import '/tiles/promotionTile.dart';
import 'search.dart';

class PricescoutProScreen extends StatefulWidget {
  const PricescoutProScreen({Key? key}) : super(key: key);

  @override
  _PricescoutProScreenState createState() => _PricescoutProScreenState();
}

class _PricescoutProScreenState extends State<PricescoutProScreen> {
  final List<String> popularBrands = [
    'Apple',
    'Samsung',
    'Google',
    'Lenovo',
    'Razer',
    'Dell',
    'Realme',
    'Logitech',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pricescout Pro'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search for Products, Brands and More',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                onSubmitted: (value) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ProductListScreen(
                        product: value,
                      ),
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Popular Brands',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  )),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularBrands.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return BrandButton(brandName: popularBrands[index]);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              height: 150,
              child: PromotionTile(
                promotions: [
                  {
                    'discount': 'upto 10% off',
                    'title': 'on Laptops!',
                    'image': 'assets/images/laptop.jpg',
                    'search': 'laptop',
                  },
                  {
                    'discount': 'upto 30% off',
                    'title': 'on mouse!',
                    'image': 'assets/images/mouse.jpeg',
                    'search': 'mouse',
                  },
                  {
                    'discount': 'upto 25% off',
                    'title': 'on speaker!',
                    'image': 'assets/images/speaker.jpg',
                    'search': 'speaker',
                  },
                ],
              ),
            ),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              children: const [
                ProductTile(
                  title: 'Camera',
                  image: 'assets/images/camera.png',
                  search: 'camera',
                ),
                ProductTile(
                  title: 'Washing Machine',
                  image: 'assets/images/wm.png',
                  search: 'washing machine',
                ),
                ProductTile(
                  title: 'Earbuds',
                  image: 'assets/images/earbuds.jpeg',
                  search: 'earbuds',
                ),
                ProductTile(
                  title: 'Keyboard',
                  image: 'assets/images/keyboard.jpeg',
                  search: 'keyboard',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
