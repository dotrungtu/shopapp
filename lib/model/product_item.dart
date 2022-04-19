class ProductItem {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  double price;
  int quantity;
  bool? isFavorite;

  ProductItem({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.price = 0,
    this.isFavorite,
    this.quantity = 0,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'],
      name: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      quantity: json['quantity'],
      isFavorite: json['isFavorite'],
    );
  }

  ProductItem copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    double? price,
    int? quantity,
    bool? isFavorite,
  }) {
    return ProductItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
