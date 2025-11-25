import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lab2_mis/model/Category.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: Expanded(
        child: ValueListenableBuilder(
          valueListenable: serviceAPI.valueNotifierFoodCategories,
          builder: (context, list, child) {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final category = list[index];
                return ListTile(
                  leading: Image.network(category.thumbUrl),
                  title: Text(category.name, style: TextStyle(fontSize: 18.0,),),
                  subtitle: Text(category.description, style: TextStyle(fontSize: 14.0, overflow: TextOverflow.ellipsis),),
                  onTap: (){
                    print("Nothing for now");
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
