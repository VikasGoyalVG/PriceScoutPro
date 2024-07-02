// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryButton({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.purple),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}