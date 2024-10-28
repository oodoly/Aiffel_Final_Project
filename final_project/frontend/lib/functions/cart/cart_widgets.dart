import 'package:flutter/material.dart';
import '../providers/cart_item_provider.dart';
import '../util/appcolors.dart';
import '../util/apptext.dart';
import '../models/cart_item_model.dart';

// 장바구니 표시 컨테이너
class CartContainer extends StatelessWidget {
  const CartContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.moduRed,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(20, -4),
          ),
        ],
      ),
      child: Consumer<CartItemProvider>(
        builder: (context, provider, child) {
          if (provider.cartItems.isEmpty) {
            return Center(
              child: Text(
                '장바구니가 비어 있습니다.',
                style: AppText.cartItemText,
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              itemCount: provider.cartItems.length,
              itemBuilder: (context, index) {
                return CartItemView(
                  cartItem: provider.cartItems[index],
                  index: index,
                );
              },
            );
          }
        },
      ),
    );
  }
}

// 선택된 내용 라인 구성 (장바구니 표시 컨테이너 구성요소)
class CartItemView extends StatelessWidget {
  final CartItemModel cartItem;
  final int index;

  const CartItemView({super.key, required this.cartItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.moduRed,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            cartItem.productName,
            style: AppText.cartItemText,
          ),
          Text(
            '${cartItem.price}원',
            style: AppText.cartItemText,
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                color: AppColors.lightText,
                onPressed: () {
                  Provider.of<CartItemProvider>(context, listen: false)
                      .decreaseQuantity(index);
                },
              ),
              Text(
                '${cartItem.quantity}',
                style: AppText.cartItemText,
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                color: AppColors.lightText,
                onPressed: () {
                  Provider.of<CartItemProvider>(context, listen: false)
                      .increaseQuantity(index);
                },
              ),
              Text(
                '개',
                style: AppText.cartItemText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
