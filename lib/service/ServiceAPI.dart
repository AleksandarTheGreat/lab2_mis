import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lab2_mis/model/FoodCategory.dart';
import 'package:lab2_mis/model/Meal.dart';
import 'package:lab2_mis/model/MealRecipe.dart';

class ServiceAPI {

  final ValueNotifier<List<FoodCategory>> valueNotifierFoodCategories = ValueNotifier([]);
  final ValueNotifier<List<Meal>> valueNotifierMeals = ValueNotifier([]);
  final ValueNotifier<MealRecipe> valueNotifierMealRecipe = ValueNotifier(MealRecipe.emptyInstance());

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

  Future<void> listAllMeals(FoodCategory foodCategory) async {
    final res = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?c=${foodCategory.name}"));
    if (res.statusCode == 200){
      final data = jsonDecode(res.body);
      final List items = data['meals'];

      List<Meal> meals = [];

      for (var item in items){
        String id = item['idMeal'];
        String name = item['strMeal'];
        String thumbUrl = item['strMealThumb'];

        Meal meal = Meal(id: id, name: name, thumbUrl: thumbUrl);
        meals.add(meal);
      }

      valueNotifierMeals.value = meals;
    }
  }

  Future<void> loadDetails(Meal meal) async {
    final res = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=${meal.id}"));
    if (res.statusCode == 200){
      final data = jsonDecode(res.body);
      final list = data['meals'];

      final object = list[0];

      String id = object['idMeal'] ?? "";
      String name = object['strMeal'] ?? "";
      String instructions = object['strInstructions'] ?? "";
      String thumbUrl = object['strMealThumb'] ?? "";
      String youtubeUrl = object['strYoutube'] ?? "";

      List<String> ingredients = [];

      for (int i=1;i<=20;i++){
        String key = "strIngredient$i";
        String ingredient = object[key];

        if (ingredient.isNotEmpty) {
          ingredients.add(ingredient);
        }
      }

      MealRecipe mealRecipe = MealRecipe(id: id, name: name, instructions: instructions, ingredients: ingredients, thumbUrl: thumbUrl, youtubeUrl: youtubeUrl);
      valueNotifierMealRecipe.value = mealRecipe;
    }
  }

  Future<void> loadRandomRecipeDetails() async {
    final res = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/random.php"));
    if (res.statusCode == 200){
      final data = jsonDecode(res.body);
      final list = data['meals'];

      final object = list[0];

      String id = object['idMeal'] ?? "";
      String name = object['strMeal'] ?? "";
      String instructions = object['strInstructions'] ?? "";
      String thumbUrl = object['strMealThumb'] ?? "";
      String youtubeUrl = object['strYoutube'] ?? "";

      List<String> ingredients = [];

      for (int i=1;i<=20;i++){
        String key = "strIngredient$i";
        String ingredient = object[key];

        if (ingredient.isNotEmpty) {
          ingredients.add(ingredient);
        }
      }

      MealRecipe mealRecipe = MealRecipe(id: id, name: name, instructions: instructions, ingredients: ingredients, thumbUrl: thumbUrl, youtubeUrl: youtubeUrl);
      valueNotifierMealRecipe.value = mealRecipe;
    }
  }

}