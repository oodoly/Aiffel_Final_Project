import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'payment/payment_method_type.dart';
import 'payment/payment_provider.dart';
import 'payment/payment_widgets.dart';
import 'widgets/buttons.dart';
import 'widgets/llm_response.dart';

void main() {
  runApp(const ModuApp());
}

class ModuApp extends StatelessWidget {
  const ModuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiProvider(
          providers: const [
            // ChangeNotifierProvider(create: (context) => CartItemProvider()),
          ],
          child: const MaterialApp(
            title: 'Modu App',
            debugShowCheckedModeBanner: false,
            home: SafeArea(
              child: PaymentPage(),
            ),
          ),
        );
      },
    );
  }
}

// 진입 페이지 (미완성)
class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

// 결제 페이지, 추가 구현
// PaymentPage Expanded 장바구니 + ButtonSet
class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

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
            PaymentContainer(),
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

class PaymentContainer extends StatelessWidget {
  const PaymentContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("결제 방법을 선택해주세요")),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "결제 금액: 10500원",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black87),
              ),
            ),
            Expanded(
              child: Consumer<PaymentProvider>(
                builder: (context, provider, child) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    // itemCount: PaymentMethodType.values.length,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return PaymentMethodCard.create(
                          PaymentMethodType.values[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 이상 화면들
// 이하 위젯들

// 메뉴 카드
// 페이먼트 카드
//

