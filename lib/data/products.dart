class Product {
  final String title;
  final String imageUrl;
  final String productId;
  final int price;
  final bool isAvailable;

  Product({
    required this.title,
    required this.imageUrl,
    required this.productId,
    required this.price,
    required this.isAvailable,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['product_title'],
      imageUrl: json['product_image'],
      productId: json['product_id'],
      price: json['product_lowest_price'],
      isAvailable: json['is_available'],
    );
  }
}
