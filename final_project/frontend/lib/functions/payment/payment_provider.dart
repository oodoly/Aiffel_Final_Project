import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  String? selectedPaymentMethod;

  void selectPaymentMethod(String method) {
    selectedPaymentMethod = method;
    notifyListeners();
  }
}
