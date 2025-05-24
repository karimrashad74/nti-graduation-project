class Product {
  final String image;
  final String name;
  final String description;
  final String price;
  final String rating;
  final String categoryId;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.image,
    required this.categoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      image: json['image_url'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'].toString(),
      rating: json['rating'].toString(),
      categoryId: json['category_id'].toString(),
    );
  }
}
