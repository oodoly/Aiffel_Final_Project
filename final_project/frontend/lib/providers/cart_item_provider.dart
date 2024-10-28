import 'package:flutter/material.dart';

class CartItemProvider extends ChangeNotifier {
  List<CartItemModel> cartItems = [];

  void loadItemsFromJson(String jsonString) {
    final List<dynamic> jsonData = json.decode(jsonString);
    cartItems = jsonData.map((json) => CartItemModel.fromJson(json)).toList();
    notifyListeners();

  // .read
  void changeProdName({
    required String newProdName,
  }) async {
    prodName = newProdName;
    notifyListeners();
  }
}
