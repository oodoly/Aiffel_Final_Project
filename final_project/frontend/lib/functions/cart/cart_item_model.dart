class CartItemModel {
  int id;
  String productName;
  String description;
  int price;
  int setPrice;
  int quantity;

  CartItemModel({
    required this.id,
    required this.productName,
    required this.description,
    required this.price,
    required this.setPrice,
    this.quantity = 1,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      productName: json['productName'],
      description: json['description'],
      price: json['price'],
      setPrice: json['setPrice'],
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'description': description,
      'price': price,
      'setPrice': setPrice,
      'quantity': quantity,
    };
  }
}
