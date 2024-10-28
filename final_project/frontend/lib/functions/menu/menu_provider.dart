import 'package:flutter/material.dart';
import '../models/menu_item_model.dart';
import '../services/menu_service.dart';

class MenuProvider with ChangeNotifier {
  List<Menu> _menus = [];
  final MenuService _menuService = MenuService();

  List<Menu> get menus => _menus;

  Future<void> loadMenus() async {
    _menus = await _menuService.fetchMenus();
    notifyListeners(); // 상태 변경 알림
  }
}
