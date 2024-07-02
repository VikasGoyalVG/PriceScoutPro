// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../screens/search.dart';

class ProductTile extends StatefulWidget {
  final String title;
  final String image;
  final String search;

  const ProductTile({Key? key, required this.title, required this.image, required this.search}) : super(key: key);

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool isFavorite = false; // Example state variable

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProductListScreen(
              product: widget.search,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(9.0),
         decoration: BoxDecoration(
        //border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),

      ),
        child: Card(
          elevation: 30,
          shadowColor: Colors.black,         
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
