import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:lab2_mis/model/FoodCategory.dart';
import 'package:lab2_mis/screen/ScreenFavorites.dart';
import 'package:lab2_mis/screen/ScreenMealDetails.dart';
import 'package:lab2_mis/screen/ScreenMeals.dart';
import 'package:lab2_mis/service/ServiceAPI.dart';

class ScreenCategories extends StatefulWidget {
  const ScreenCategories({super.key});

  @override
  State<ScreenCategories> createState() => _ScreenCategoriesState();
}

class _ScreenCategoriesState extends State<ScreenCategories> {

  final ServiceAPI serviceAPI = GetIt.instance<ServiceAPI>();

  @override
  void initState() {
    super.initState();
    serviceAPI.listAllCategories();
  }


  @override
  void dispose() {
    super.dispose();
    serviceAPI.valueNotifierFoodCategories.value = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Categories"),
            TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenFavorites()));
              },
              child: Text("Favorites"),
            ),
            TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenMealDetails(meal: null)));
              }, 
              child: Text("Random Recipe"),
            ),
          ],
        ),
      ),
      body: Expanded(
        child: ValueListenableBuilder(
          valueListenable: serviceAPI.valueNotifierFoodCategories,
          builder: (context, list, child) {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final foodCategory = list[index];
                return ListTile(
                  leading: Image.network(foodCategory.thumbUrl),
                  title: Text(foodCategory.name, style: TextStyle(fontSize: 18.0, overflow: TextOverflow.ellipsis,),),
                  subtitle: Text(foodCategory.description, style: TextStyle(fontSize: 14.0, overflow: TextOverflow.ellipsis,),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenMeals(foodCategory: foodCategory)));
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
