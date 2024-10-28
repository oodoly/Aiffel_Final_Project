import 'package:flutter/material.dart';
import '../providers/cart_item_provider.dart';
import '../util/apptext.dart';
import '../providers/menu_provider.dart';
import '../models/cart_item_model.dart';
import '../services/cart_service.dart';

class TopMenuScroll extends StatelessWidget {
  const TopMenuScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            TopMenuButton(label: '추천 메뉴'),
            TopMenuButton(label: '행사 메뉴'),
            TopMenuButton(label: '버거 세트'),
            TopMenuButton(label: '버거'),
            TopMenuButton(label: '사이드'),
            TopMenuButton(label: '음료'),
            TopMenuButton(label: '디저트'),
          ],
        ),
      ),
    );
  }
}

class TopMenuButton extends StatelessWidget {
  final String label;

  const TopMenuButton({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: AppText.menuText,
        ),
      ),
    );
  }
}

class ResponsiveMenu extends StatelessWidget {
  const ResponsiveMenu({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    final menuProvider = Provider.of<MenuProvider>(context);

    return Column(
      children: [
        const SizedBox(
          height: 70,
          child: TopMenuScroll(),
        ),
        Expanded(
          child: Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            child: OrientationBuilder(
              builder: (context, orientation) {
                return GridView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: menuProvider.menus.length,
                  itemBuilder: (context, index) {
                    return MenuItemCard(menu: menuProvider.menus[index]);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MenuItemCard extends StatefulWidget {
  final CartItemModel cartItem;

  const MenuItemCard({super.key, required this.cartItem});

  @override
  State<MenuItemCard> createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {
  bool isSelected = false;
  final CartService _cartService = CartService();

  void _onCardTap() async {
    setState(() {
      isSelected = !isSelected;
    });

    try {
      await _cartService.updateCartItemSelection(widget.cartItem.id);
    } catch (e) {
      print('Failed to send selection: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onCardTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(4, 4),
                  ),
                ]
              : [],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: constraints.maxWidth * 0.4,
                  child: Image.network(
                    'https://via.placeholder.com/150',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cartItem.productName,
                        style: AppText.productName,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.cartItem.description,
                        style: AppText.productDescription,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '단품: ${widget.cartItem.price}원',
                            style: AppText.productPrice,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '세트: ${widget.cartItem.setPrice}원',
                            style: AppText.productPrice,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
