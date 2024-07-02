import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '/data/products.dart' as productsdata;
import 'product.dart' as product;

class ProductListScreen extends StatefulWidget {
  final String product;
  const ProductListScreen({Key? key, required this.product}) : super(key: key);
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  Future<List<dynamic>> fetchProducts(String product) async {
    final response = await http.get(Uri.parse(
        'https://price-api.datayuge.com/api/v1/compare/search?product=$product&api_key=evbMMESXau7x6LnW18EhP684q0ApNPIxmWj'));

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load products');
    }
  }

  late Future<List<productsdata.Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts(widget.product).then((data) =>
        data.map((item) => productsdata.Product.fromJson(item)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Search Results'),
      ),
      body: FutureBuilder<List<productsdata.Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => product.ProductPage(
                          // Use the prefix for ProductPage class
                          productId: snapshot.data![index].productId,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Image.network(
                          snapshot.data![index].imageUrl,
                          width: double.infinity,
                          height: 180,
                          //fit: BoxFit.cover,
                          //color: Colors.white,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          snapshot.data![index].title.length <= 25
                              ? snapshot.data![index].title
                              : snapshot.data![index].title.substring(0, 12),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('${snapshot.data![index].price} Rs.'),
                            Icon(
                              snapshot.data![index].isAvailable
                                  ? Icons.check_circle
                                  : Icons.error,
                              color: snapshot.data![index].isAvailable
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
