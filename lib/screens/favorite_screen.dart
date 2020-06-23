import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favMeals;
  const FavoriteScreen(this.favMeals);

  @override
  Widget build(BuildContext context) {
    if (favMeals.isEmpty) {
      return Center(
        child: Text("You have no favorites yet - start adding some!"),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favMeals[index].id,
            affordability: favMeals[index].affordability,
            complexity: favMeals[index].complexity,
            duration: favMeals[index].duration,
            imageUrl: favMeals[index].imageUrl,
            title: favMeals[index].title,
          );
        },
        itemCount: favMeals.length,
      );
    }
  }
}
