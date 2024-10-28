import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:final_proj_flutter/models/menu_item_model.dart';
import 'config.dart';

class MenuService {
  Future<List<Menu>> fetchMenus() async {
    final response = await http.get(Uri.parse('$Config.baseurl'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Menu.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load menu data');
    }
  }
}
