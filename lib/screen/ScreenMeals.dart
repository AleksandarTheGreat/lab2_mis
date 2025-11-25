import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lab2_mis/model/FoodCategory.dart';
import 'package:lab2_mis/screen/ScreenMealDetails.dart';
import 'package:lab2_mis/service/ServiceAPI.dart';

class ScreenMeals extends StatefulWidget {

  const ScreenMeals({super.key, required this.foodCategory});
  final FoodCategory foodCategory;

  @override
  State<ScreenMeals> createState() => _ScreenMealsState(foodCategory: foodCategory);
}

class _ScreenMealsState extends State<ScreenMeals> {

  _ScreenMealsState({required this.foodCategory});
  final FoodCategory foodCategory;
  final ServiceAPI serviceAPI = GetIt.instance<ServiceAPI>();

  @override
  void initState() {
    super.initState();
    serviceAPI.listAllMeals(foodCategory);
  }


  @override
  void dispose() {
    super.dispose();
    serviceAPI.valueNotifierMeals.value = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meals for ${foodCategory.name}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: serviceAPI.valueNotifierMeals,
          builder: (context, meals, child) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3/4, // width/height ratio
              ),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return Card(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenMealDetails(meal: meal)));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0,),
                          child: Image.network(meal.thumbUrl, height: 150),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0,),
                          child: Text(meal.name, style: TextStyle(fontSize: 16), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        ),
      ),
    );
  }

}
