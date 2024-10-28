import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../services/cart_service.dart';

class CartItemProvider extends ChangeNotifier {
  final CartService _cartService = CartService();

  List<CartItemModel> cartItems = [];

  Future<void> loadItemsFromApi() async {
    try {
      cartItems = await _cartService.fetchCartItems();
      notifyListeners();
    } catch (e) {
      print('Error loading cart items: $e');
    }
  }

  Future<void> increaseQuantity(int index) async {
    cartItems[index].quantity++;
    notifyListeners();
    await _updateCartItem(index);
  }

  Future<void> decreaseQuantity(int index) async {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      notifyListeners();
      await _updateCartItem(index);
    }
  }

  Future<void> toggleSelection(int index) async {
    cartItems[index].isSelected = !cartItems[index].isSelected;
    notifyListeners();

    try {
      await _updateCartItem(index);
    } catch (e) {
      print('선택 정보를 서버로 전송하지 못함: $e');
    }
  }

  Future<void> _updateCartItem(int index) async {
    try {
      await _cartService.updateCartItem(cartItems[index]);
    } catch (e) {
      print('Error updating cart item: $e');
    }
  }
}
