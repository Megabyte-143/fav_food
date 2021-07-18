import 'package:flutter/material.dart';

import '../dummy_data.dart';

import '../models/meal.dart';

import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegetarian": false,
    "vegan": false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  void _setFliters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters["gluten"] == false && !meal.isGlutenFree) {
          return false;
        }
        if (_filters["lactose"] == false && !meal.isLactoseFree) {
          return false;
        }
        if (_filters["vegan"] == false && !meal.isVegan) {
          return false;
        }
        if (_filters["vegetarian"] == false && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFav(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFav(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme(
          primaryVariant: Colors.pink,
          secondaryVariant: Colors.amber,
          surface: Color.fromRGBO(280, 254, 290, 1),
          background: Colors.black,
          secondary: Colors.amberAccent,
          brightness: Brightness.light,
          error: Colors.red.shade400,
          onBackground: Colors.black45,
          onError: Colors.red.shade100,
          onPrimary: Colors.pink.shade50,
          onSecondary: Colors.amber.shade50,
          onSurface: Color.fromRGBO(255, 254, 229, 1),
          primary: Colors.pink,
        ),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 50, 51, 1),
              ),
              headline6: const TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CatergoryMealsScreen.routeName: (ctx) =>
            CatergoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFav, _isFav),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFliters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      },
      onUnknownRoute: (settings) {
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
