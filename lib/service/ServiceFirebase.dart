import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lab2_mis/model/Meal.dart';

class ServiceFirebase {

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final ValueNotifier<List<Meal>> valueNotifierFavorites = ValueNotifier([]);
  final String COLLECTION_NAME = "Favorites";

  Future<void> loadAllMeals() async {
    List<Meal> list = [];

    _firebaseFirestore
        .collection(COLLECTION_NAME)
        .get()
        .then((querySnapshot){
          for (var doc in querySnapshot.docs){
            String id = doc['id'];
            String name = doc['name'];
            String thumbUrl = doc['thumbUrl'];

            Meal meal = Meal(id: id, name: name, thumbUrl: thumbUrl);
            list.add(meal);
          }

          valueNotifierFavorites.value = list;
          print(list);
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future<void> add(Meal meal) async {
    Map<String, dynamic> map = {
      "id": meal.id,
      "name": meal.name,
      "thumbUrl": meal.thumbUrl,
    };

    _firebaseFirestore
      .collection(COLLECTION_NAME)
      .doc(meal.id)
      .set(map)
      .then((value){
        print("Successfully added meal to favorites");
    })
    .catchError((error) {
      print(error.toString());
    });
  }

  Future<void> delete(Meal meal) async {
    _firebaseFirestore
        .collection(COLLECTION_NAME)
        .doc(meal.id)
        .delete()
        .then((value) {
          valueNotifierFavorites.value = valueNotifierFavorites.value.where((x) => x.id != meal.id).toList();
          print("Successfully removed meal from favorites");
    }).catchError((error) {
      print(error.toString());
    });
  }

}