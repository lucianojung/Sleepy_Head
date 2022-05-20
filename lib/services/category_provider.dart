import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleepy_head/models/category.dart';

import 'dart:convert';

import '../models/szenario.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  CategoryProvider() {
    initialState();
  }

  void initialState() {
    syncDataWithProvider();
  }

  // additional getters

  List<Szenario> getSzenariosByCategory(category) => _categories
      .firstWhere((element) => element.id == category.id)
      .szenarios
      .where((element) => element.difficulty <= category.level)
      .toList();

  Category getCategoryBySzenarioId(szenarioId) => _categories.firstWhere(
      (element) =>
          element.szenarios.firstWhere((element) => element.id == szenarioId, orElse: () => Szenario(id: -1)).id != -1,
      orElse: () => Category(id: -1));

  // CRUD Methods for local Variables

  void increaseProgress(id, {bool isSzenarioId = false}) {
    Category category =
        isSzenarioId ? getCategoryBySzenarioId(id) : _categories.firstWhere((element) => element.id == id);

    category.progress += 0.1;
    if (category.progress >= 1) {
      category.progress = 0;
      category.level++;
    }

    updateSharedPrefrences();
    notifyListeners();
  }

  void addCategory(id, categoryName, szenarios) {
    _categories.add(
      Category(id: id, categoryName: categoryName, szenarios: szenarios),
    );

    updateSharedPrefrences();
    notifyListeners();
  }

  void removeCategoryById(int categoryId) {
    _categories.removeWhere((element) => element.id == categoryId);

    updateSharedPrefrences();
    notifyListeners();
  }

  // shared preference Methods

  void updateSharedPrefrences() async {
    List<String> categoryStringList = List<String>.from(_categories.map((x) => json.encode(x.toJson())));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('categories', categoryStringList);
    notifyListeners();
  }

  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('categories');

    if (result != null) {
      _categories = List<Category>.from(result.map((x) => Category.fromJson(json.decode(x)))).toList();
    }
    for (var category in Category.categories) {
      Category correspondingCategory =
          _categories.firstWhere((element) => element.id == category.id, orElse: () => Category());
      if (correspondingCategory.id == -1) {
        addCategory(category.id, category.categoryName, category.szenarios);
        print('add Category ${category.categoryName}');
      }
    }
    _categories.sort((a, b) => b.id - a.id);
    notifyListeners();
  }
}
