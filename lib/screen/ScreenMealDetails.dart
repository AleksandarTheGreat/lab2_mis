import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lab2_mis/model/Meal.dart';
import 'package:lab2_mis/model/MealRecipe.dart';
import 'package:lab2_mis/service/ServiceAPI.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenMealDetails extends StatefulWidget {

  const ScreenMealDetails({super.key, required this.meal});
  final Meal? meal;

  @override
  State<ScreenMealDetails> createState() => _ScreenMealDetailsState(meal: meal);
}

class _ScreenMealDetailsState extends State<ScreenMealDetails> {

  _ScreenMealDetailsState({required this.meal});
  final ServiceAPI serviceAPI = GetIt.instance<ServiceAPI>();
  final Meal? meal;

  @override
  void initState() {
    super.initState();
    if (meal != null){
      serviceAPI.loadDetails(meal!);
    } else {
      serviceAPI.loadRandomRecipeDetails();
    }
  }

  @override
  void dispose() {
    super.dispose();
    serviceAPI.valueNotifierMealRecipe.value = MealRecipe.emptyInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: ValueListenableBuilder(
        valueListenable: serviceAPI.valueNotifierMealRecipe,
        builder: (context, mealRecipe, child) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  mealRecipe.thumbUrl.isEmpty
                      ? SizedBox.shrink()   // shows nothing
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      mealRecipe.thumbUrl,
                      height: 150,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 24.0,),
                  Text(mealRecipe.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),),
                  SizedBox(height: 12,),
                  Text(mealRecipe.instructions, style: TextStyle(fontSize: 14,),),
                  SizedBox(height: 24,),
                  Text("Ingredients:", style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 8,),
                  ...mealRecipe.ingredients.map((ingredient) => Column(
                    children: [
                      Text(ingredient),
                      SizedBox(height: 8.0,),
                    ],
                  )).toList(),
                  SizedBox(height: 24.0,),
                  InkWell(
                    onTap: () async {
                      if (await canLaunchUrl(Uri.parse(mealRecipe.youtubeUrl))){
                        await launchUrl(Uri.parse(mealRecipe.youtubeUrl), mode: LaunchMode.externalApplication);
                      }
                    },
                    child: Text(mealRecipe.youtubeUrl, style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

}
