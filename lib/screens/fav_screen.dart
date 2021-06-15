import '../widgets/meal_item.dart';
import 'package:flutter/material.dart';
import '../models/meal.dart';

class FavScreen extends StatelessWidget {
  final List<Meal> favMeals;
  FavScreen(this.favMeals);
  @override
  Widget build(BuildContext context) {
    if (favMeals.isEmpty) {
      return Center(
        child: Text('The Favourites'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favMeals[index].id,
            title: favMeals[index].title,
            imageUrl: favMeals[index].imageUrl,
            duration: favMeals[index].duration,
            affordability: favMeals[index].affordability,
            complexity: favMeals[index].complexity,
          );
        },
        itemCount: favMeals.length,
      );
    }
  }
}
