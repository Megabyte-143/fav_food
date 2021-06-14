import '../widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  FiltersScreen(this.saveFilters);
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegan = false;
  var _vegetarian = false;
  var _lactoseFree = false;

  Function updateValue(bool _filter) {
    return (newValue) {
      setState(
        () {
          _filter = newValue;
        },
      );
    };
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    var currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      value: currentValue,
      onChanged: (_) => updateValue,
      title: Text(title),
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  "Gluten Free",
                  "Only INclude Gluten Free",
                  _glutenFree,
                  updateValue(_glutenFree),
                ),
                _buildSwitchListTile(
                  "Lactose Free",
                  "Only INclude Lactose Free",
                  _lactoseFree,
                  updateValue(_lactoseFree),
                ),
                _buildSwitchListTile(
                  "Vegetarian",
                  "Only INclude Vegetarian",
                  _vegetarian,
                  updateValue(_vegetarian),
                ),
                _buildSwitchListTile(
                  "Vegan",
                  "Only INclude Vegan",
                  _vegan,
                  updateValue(_vegan),
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text("Your Filters"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final selectedFilters = {
                "gluten": _glutenFree,
                "lactose": _lactoseFree,
                "vegetarian": _vegetarian,
                "vegan": _vegan,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
