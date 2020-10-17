class Product {
  final int id;
  final int sellerId;
  final String name;
  final String category;
  final String description;
  final double price;
  final double discount;

  Product(
    this.id,
    this.sellerId,
    this.name,
    this.category,
    this.description,
    this.price,
    this.discount,
  );

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['id'],
      json['sellerId'],
      json['name'],
      json['category'],
      json['description'],
      json['price'],
      json['discount'],
    );
  }
}