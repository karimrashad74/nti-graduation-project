class Category {
  final String name;
  final String iconPath;

  Category({required this.name, required this.iconPath});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      iconPath: json['iconPath'],
    );
  }
}
