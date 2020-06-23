import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  final Function updateFilters;
  final Map<String, bool> currentFilterData;
  const FiltersScreen(this.currentFilterData, this.updateFilters);
  static final routeName = 'filters';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegetarian = false;
  var _vegan = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilterData['gluten'];
    _lactoseFree = widget.currentFilterData['lactose'];
    _vegetarian = widget.currentFilterData['vegetarian'];
    _vegan = widget.currentFilterData['vegan'];
    super.initState();
  }

  Widget _buildSwitchTile(
    bool currentValue,
    String title,
    String description,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Filters",
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final Map<String, bool> filterData = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegetarian': _vegetarian,
                  'vegan': _vegan,
                };
                widget.updateFilters(filterData);
              })
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              _buildSwitchTile(
                _glutenFree,
                'Gluten-free',
                'Only include Gluten-free meals',
                (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                },
              ),
              _buildSwitchTile(
                _lactoseFree,
                'Lactose-free',
                'Only include Lactose-free meals',
                (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                },
              ),
              _buildSwitchTile(
                _vegetarian,
                'Vegetarian',
                'Only include Vegetarian meals',
                (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                },
              ),
              _buildSwitchTile(
                _vegan,
                'Vegan',
                'Only include Vegan meals',
                (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                },
              )
            ],
          ))
        ],
      ),
    );
  }
}
