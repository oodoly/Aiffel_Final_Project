import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:final_proj_flutter/models/cart_item_model.dart';

class CartService {
  Future<List<CartItemModel>> fetchCartItems() async {
    final response =
        await http.get(Uri.parse('/api/cart-items'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => CartItemModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cart items');
    }
  }
}
