import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '/data/productsDetails.dart';

class ProductPage extends StatefulWidget {
  final String productId;

  const ProductPage({Key? key, required this.productId}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<Product> futureProduct;
  List<dynamic> proSpec = [];
  int _currentIndex = 0;
  Future<Product> fetchProductDetails(String productId) async {
    final response = await http.get(Uri.parse(
        'https://price-api.datayuge.com/api/v1/compare/detail?id=$productId&api_key=evbMMESXau7x6LnW18EhP684q0ApNPIxmWj'));

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to load product details');
    }
  }

  @override
  void initState() {
    super.initState();
    futureProduct = fetchProductDetails(widget.productId);
    fetchProductSpec(widget.productId);
  }

  void fetchProductSpec(String productId) async {
    final response = await http.get(Uri.parse(
        'https://price-api.datayuge.com/api/v1/compare/specs?id=$productId&api_key=evbMMESXau7x6LnW18EhP684q0ApNPIxmWj'));
    final body = response.body;
    final json = jsonDecode(body);
    final data = json['data'];
    setState(() {
      proSpec = data['main_specs'];
    });
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: FutureBuilder<Product>(
        future: futureProduct,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Product Image Carousel
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 300,
                    child: Stack(
                      children: [
                        PageView.builder(
                          itemCount: snapshot.data!.productImages.length,
                          controller: PageController(
                            initialPage: _currentIndex,
                            viewportFraction: 0.9,
                          ),
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  snapshot.data!.productImages[index],
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              snapshot.data!.productImages.length,
                              (index) => Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color: _currentIndex == index
                                      ? Colors.purple
                                      : Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Product Details
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          snapshot.data!.productName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              'Brand: ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              snapshot.data!.productBrand,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              'Ratings: ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              snapshot.data!.productRatings,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Specifications:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: proSpec.map((spec) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.circle, size: 8),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      spec.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // E-commerce Sites List
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data!.stores.map((store) {
                      if (store.productPrice != "") {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            tileColor: Colors.white,
                            leading: Image.network(
                              store.storeLogoUrl,
                              width: 50,
                              height: 50,
                            ),
                            title: Text(
                              store.storeName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Price: ${store.productPrice}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            onTap: () {
                              Uri storeUrl = Uri.parse(store.storeUrl);
                              _launchInBrowser(storeUrl);
                              // Open the store URL
                            },
                          ),
                        );
                      } else {
                        return const SizedBox(height: 0);
                      }
                    }).toList(),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else {
            // By default, show a loading spinner.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
