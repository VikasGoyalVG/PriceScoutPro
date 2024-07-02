// ignore_for_file: file_names

class Product {
  final String productName;
  final String productModel;
  final String productBrand;
  final String productId;
  final String productRatings;
  final String productMrp;
  final String productCategory;
  final String productSubCategory;
  final bool isAvailable;
  final List<String> availableColors;
  final List<String> productImages;
  final bool isComparable;
  final bool specAvailable;
  final bool reviewAvailable;
  final List<Store> stores;

  Product({
    required this.productName,
    required this.productModel,
    required this.productBrand,
    required this.productId,
    required this.productRatings,
    required this.productMrp,
    required this.productCategory,
    required this.productSubCategory,
    required this.isAvailable,
    required this.availableColors,
    required this.productImages,
    required this.isComparable,
    required this.specAvailable,
    required this.reviewAvailable,
    required this.stores,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productName: json['product_name'],
      productModel: json['product_model'],
      productBrand: json['product_brand'],
      productId: json['product_id'],
      productRatings: json['product_ratings'],
      productMrp: json['product_mrp'],
      productCategory: json['product_category'],
      productSubCategory: json['product_sub_category'],
      isAvailable: json['is_available'],
      availableColors: List<String>.from(json['available_colors']),
      productImages: List<String>.from(json['product_images']),
      isComparable: json['is_comparable'],
      specAvailable: json['spec_available'],
      reviewAvailable: json['review_available'],
      stores: (json['stores'] as List)
          .map((store) => Store.fromJson(store))
          .toList(),
    );
  }
}

class Store {
  final String storeName;
  final String storeLogoUrl;
  final String storeUrl;
  final String productPrice;
  final String productMrp;
  final String productOffer;
  final String productColor;
  final String productDelivery;
  final String productDeliveryCost;
  final String isEmi;
  final String isCod;
  final String returnTime;

  Store({
    required this.storeName,
    required this.storeLogoUrl,
    required this.storeUrl,
    required this.productPrice,
    required this.productMrp,
    required this.productOffer,
    required this.productColor,
    required this.productDelivery,
    required this.productDeliveryCost,
    required this.isEmi,
    required this.isCod,
    required this.returnTime,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    if (json[json.keys.first] is! List<dynamic>) {
      return Store(
        storeName: json.keys.first,
        storeLogoUrl: json[json.keys.first]['product_store_logo'],
        storeUrl: json[json.keys.first]['product_store_url'],
        productPrice: json[json.keys.first]['product_price'],
        productMrp: json[json.keys.first]['product_mrp'],
        productOffer: json[json.keys.first]['product_offer'],
        productColor: json[json.keys.first]['product_color'],
        productDelivery: json[json.keys.first]['product_delivery'],
        productDeliveryCost: json[json.keys.first]['product_delivery_cost'],
        isEmi: json[json.keys.first]['is_emi'],
        isCod: json[json.keys.first]['is_cod'],
        returnTime: json[json.keys.first]['return_time'],
      );
    } else {
      return Store(
        storeName: json.keys.first,
        storeLogoUrl: "",
        storeUrl: "",
        productPrice: "",
        productMrp: "",
        productOffer: "",
        productColor: "",
        productDelivery: "",
        productDeliveryCost: "",
        isEmi: "",
        isCod: "",
        returnTime: "",
      );
    }
  }
}