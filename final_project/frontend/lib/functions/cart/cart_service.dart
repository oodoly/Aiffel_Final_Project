import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:final_proj_flutter/models/cart_item_model.dart';
import 'package:final_proj_flutter/services/config.dart';

class CartService {
  Future<List<CartItemModel>> fetchCartItems() async {
    try {
      final response =
          await http.get(Uri.parse('${Config.baseUrl}/cart-items'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => CartItemModel.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load cart items. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching cart items: $e');
    }
  }

  Future<void> updateCartItem(CartItemModel cartItem) async {
    try {
      final response = await http.put(
        Uri.parse('${Config.baseUrl}/cart/${cartItem.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'productName': cartItem.productName,
          'price': cartItem.price,
          'setPrice': cartItem.setPrice,
          'quantity': cartItem.quantity,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to update cart item. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating cart item: $e');
    }
  }
}

class MockCartService {
  Future<void> updateCartItemSelection(int cartItemId) async {
    // 여기서 실제 API 호출 대신 임시 로그를 출력합니다.
    await Future.delayed(const Duration(milliseconds: 300));
    print('Mock: Cart item with ID $cartItemId updated.');
  }
}
