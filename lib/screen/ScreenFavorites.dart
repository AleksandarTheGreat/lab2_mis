import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lab2_mis/model/Meal.dart';
import 'package:lab2_mis/screen/ScreenMealDetails.dart';
import 'package:lab2_mis/service/ServiceFirebase.dart';

class ScreenFavorites extends StatefulWidget {

  const ScreenFavorites({super.key});

  @override
  State<ScreenFavorites> createState() => _ScreenFavoritesState();
}

class _ScreenFavoritesState extends State<ScreenFavorites> {
  final ServiceFirebase serviceFirebase = GetIt.instance<ServiceFirebase>();

  @override
  void initState() {
    super.initState();
    serviceFirebase.loadAllMeals();
  }

  @override
  void dispose() {
    super.dispose();
    serviceFirebase.valueNotifierFavorites.value = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: Expanded(
        child: ValueListenableBuilder(
          valueListenable: serviceFirebase.valueNotifierFavorites,
          builder: (context, list, child) {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final meal = list[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(16.0),
                      child: Image.network(meal.thumbUrl),
                    ),
                    trailing: IconButton(
                      onPressed: (){
                        showDeleteDialog(meal);
                      },
                      icon: Icon(Icons.remove_circle_outline, color: Colors.red,),
                    ),
                    title: Text(meal.name, style: TextStyle(fontSize: 18.0, overflow: TextOverflow.ellipsis,),),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenMealDetails(meal: meal)));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> showDeleteDialog(Meal meal) async {
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("'${meal.name}' will be deleted. Are you sure?"),
        actions: [
          TextButton(
            onPressed: (){Navigator.pop(context, true);},
            child: Text("Yes, I am"),
          ),
          TextButton(
            onPressed: (){Navigator.pop(context, false);},
            child: Text("Cancel"),)
        ],
      ),
    );

    if (result == true) {
      serviceFirebase.delete(meal);
    }
  }
}
