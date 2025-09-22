import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addItem(Map<String, dynamic> item) {
    final index = _items.indexWhere((i) => i["nome"] == item["nome"]);
    if (index >= 0) {
      _items[index]["quantidade"]++;
    } else {
      _items.add({
        "nome": item["nome"],
        "quantidade": 1,
      });
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int get totalItems {
    int total = 0;
    for (var item in _items) {
      total += item["quantidade"] as int;
    }
    return total;
  }
}