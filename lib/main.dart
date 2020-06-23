import 'package:flutter/material.dart';

import './models/meal.dart';
import './dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filterData = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false
  };
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  _updateFilters(Map<String, bool> updatedFilters) {
    setState(() {
      filterData = updatedFilters;
      availableMeals = DUMMY_MEALS.where((meal) {
        if (filterData['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (filterData['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (filterData['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (filterData['vegan'] && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  _toggelFavoriteMeal(String mealId) {
    final mealIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (mealIndex >= 0) {
      setState(() {
        favoriteMeals.removeAt(mealIndex);
      });
    } else {
      setState(() {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  _isFavorite(mealId) {
    return favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.w500,
              ),
              headline5: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.w500,
              ),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', //default '/'
      routes: {
        '/': (ctx) => TabsScreen(favoriteMeals),
        CategoryMealsScreen.routName: (ctx) =>
            CategoryMealsScreen(availableMeals),
        MealDetailsScreen.routName: (ctx) =>
            MealDetailsScreen(_toggelFavoriteMeal, _isFavorite),
        FiltersScreen.routeName: (ctx) =>
            FiltersScreen(filterData, _updateFilters),
      },
    );
  }
}
