import 'package:flutter/material.dart';
import '../widgets/llm_response.dart';
import '../widgets/cart_widgets.dart';
import '../widgets/buttons.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            child: const Expanded(
              child: LLMresponse(
                  text: '맥크리스피 스리라차 마요 세트가 추가되었습니다. 이대로 결제하시거나 더 주문하시겠습니까?'),
            ),
          ),
        ),
        const Expanded(
          flex: 8,
          child: Stack(children: [
            CartContainer(),
            Positioned(
              left: 0,
              bottom: 0,
              child: ButtonBox(),
            )
          ]),
        ),
      ],
    ));
  }
}
