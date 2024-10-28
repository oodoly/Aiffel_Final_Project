import 'dart:convert';
import 'package:http/http.dart' as http;
import '../payment/payment_method_type.dart';

class PaymentService {
  Future<List<PaymentMethodType>> fetchPaymentMethods() async {
    final response =
        await http.get(Uri.parse('https://api.example.com/payment-methods'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data
          .map((item) => PaymentMethodType.values
              .firstWhere((e) => e.name == item['name']))
          .toList();
    } else {
      throw Exception('Failed to load payment methods');
    }
  }
}
