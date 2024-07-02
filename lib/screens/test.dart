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

  late Future<List<productsdata.Product>>
      futureProducts; // Use the prefix for Product class

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts(widget.product).then((data) => data
        .map((item) => productsdata.Product.fromJson(item))
        .toList()); // Use the prefix for Product class
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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    snapshot.data![index].imageUrl,
                  ),
                  title: Text(snapshot.data![index].title),
                  subtitle: Text('${snapshot.data![index].price}Rs.'),
                  trailing: snapshot.data![index].isAvailable
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.error, color: Colors.red),
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