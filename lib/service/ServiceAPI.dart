import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lab2_mis/model/Category.dart';

class ServiceAPI {

  final ValueNotifier<List<FoodCategory>> valueNotifierFoodCategories = ValueNotifier([]);

  ServiceAPI();

  Future<void> listAllCategories() async {
    final res = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"));
    if (res.statusCode == 200){
      final data = jsonDecode(res.body);
      final List categories = data['categories'];

      List<FoodCategory> list = [];

      for (var item in categories){
        String id = item['idCategory'];
        String name = item['strCategory'];
        String description = item['strCategoryDescription'];
        String thumbUrl = item['strCategoryThumb'];

        FoodCategory category = FoodCategory(id: id, name: name, description: description, thumbUrl: thumbUrl);
        list.add(category);
      }

      valueNotifierFoodCategories.value = list;
    }
  }

}