// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../screens/search.dart';

class BrandButton extends StatelessWidget {
  final String brandName;

  const BrandButton({Key? key, required this.brandName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProductListScreen(
              product: brandName,
            ),
          ),
        );
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.purple),
        ),
        child: Center(
          child: Text(
            brandName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
