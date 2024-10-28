import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:final_proj_flutter/functions/menu/menu_item_model.dart';

class MenuLoader {
  static Future<List<Menu>> loadMenus() async {
    String jsonString = await rootBundle.loadString('util/menu.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((json) => Menu.fromJson(json)).toList();
  }
}
