import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'payment_provider.dart';
import 'payment_method_type.dart';

class PayMethods extends StatelessWidget {
  const PayMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class SelectAmountPopUp extends StatelessWidget {
  const SelectAmountPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ProcessPaymentWidget extends StatelessWidget {
  const ProcessPaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// within process payment widget, build loading signal

// Payment Method Card Factory
abstract class PaymentMethodCard extends StatelessWidget {
  factory PaymentMethodCard.create(PaymentMethodType type) {
    return BasicPaymentCard(
      type.name,
      type.iconPath,
    );
  }
}

class BasicPaymentCard extends StatelessWidget implements PaymentMethodCard {
  final String name;
  final String iconPath;

  const BasicPaymentCard(this.name, this.iconPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<PaymentProvider>(context, listen: false)
            .selectPaymentMethod(name);
      },
      child: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, width: 50, height: 50),
            const SizedBox(height: 8),
            Text(name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
