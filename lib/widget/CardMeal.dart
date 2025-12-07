import 'package:flutter/material.dart';
import 'package:lab2_mis/model/Meal.dart';
import 'package:lab2_mis/screen/ScreenMealDetails.dart';
import 'package:lab2_mis/service/ServiceFirebase.dart';

class CardMeal extends StatelessWidget {

  const CardMeal({super.key, required this.meal, required this.serviceFirebase});
  final Meal meal;
  final ServiceFirebase serviceFirebase;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenMealDetails(meal: meal)));
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: (){
                      serviceFirebase.add(meal);
                    },
                    child: Text("Add to favorites"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
