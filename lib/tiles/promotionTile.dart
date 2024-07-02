// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../screens/search.dart';

class PromotionTile extends StatefulWidget {
  final List<Map<String, dynamic>> promotions;

  const PromotionTile({Key? key, required this.promotions}) : super(key: key);

  @override
  _PromotionTileState createState() => _PromotionTileState();
}

class _PromotionTileState extends State<PromotionTile> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: widget.promotions.length,
            controller: PageController(
              initialPage: _currentIndex,
              viewportFraction: 1,
            ),
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final promotion = widget.promotions[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ProductListScreen(
                        product: promotion['search'],
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(promotion['image']),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            promotion['discount'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Text(
                          promotion['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
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
                widget.promotions.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? Colors.purple : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
