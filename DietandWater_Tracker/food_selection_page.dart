import 'package:flutter/material.dart';

class FoodSelectionPage extends StatefulWidget {
  final String mealType;
  final Function(String, int, int, int, int) onAddFood;

  FoodSelectionPage({required this.mealType, required this.onAddFood});

  @override
  _FoodSelectionPageState createState() => _FoodSelectionPageState();
}

class _FoodSelectionPageState extends State<FoodSelectionPage> {
  Map<String, bool> selectedFoods = {};
  Map<String, int> selectedQuantities = {};

  final List<Map<String, dynamic>> foodItems = [
    {'name': 'Apple', 'carbs': 20, 'proteins': 1, 'fats': 0, 'amount': '150g'},
    {
      'name': 'Chicken Breast',
      'carbs': 0,
      'proteins': 30,
      'fats': 5,
      'amount': '100g'
    },
    {'name': 'Rice', 'carbs': 40, 'proteins': 4, 'fats': 1, 'amount': '200g'},
    {
      'name': 'Broccoli',
      'carbs': 10,
      'proteins': 3,
      'fats': 0,
      'amount': '100g'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Food for ${widget.mealType}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Nutrient Tables
            NutrientTable(
              title: "Carbohydrates",
              nutrient: "carbs",
              foodItems: foodItems,
              selectedFoods: selectedFoods,
              selectedQuantities: selectedQuantities,
              onCheckboxChanged: (foodName, isSelected) {
                setState(() {
                  selectedFoods[foodName] = isSelected;
                });
              },
              onQuantityChanged: (foodName, quantity) {
                setState(() {
                  selectedQuantities[foodName] = quantity;
                });
              },
            ),
            SizedBox(height: 20),
            NutrientTable(
              title: "Proteins",
              nutrient: "proteins",
              foodItems: foodItems,
              selectedFoods: selectedFoods,
              selectedQuantities: selectedQuantities,
              onCheckboxChanged: (foodName, isSelected) {
                setState(() {
                  selectedFoods[foodName] = isSelected;
                });
              },
              onQuantityChanged: (foodName, quantity) {
                setState(() {
                  selectedQuantities[foodName] = quantity;
                });
              },
            ),
            SizedBox(height: 20),
            NutrientTable(
              title: "Fats",
              nutrient: "fats",
              foodItems: foodItems,
              selectedFoods: selectedFoods,
              selectedQuantities: selectedQuantities,
              onCheckboxChanged: (foodName, isSelected) {
                setState(() {
                  selectedFoods[foodName] = isSelected;
                });
              },
              onQuantityChanged: (foodName, quantity) {
                setState(() {
                  selectedQuantities[foodName] = quantity;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Pass selected items back to the DietTrackerPage
                selectedFoods.forEach((foodName, isSelected) {
                  if (isSelected) {
                    final food = foodItems
                        .firstWhere((item) => item['name'] == foodName);
                    int quantity = selectedQuantities[foodName] ?? 1;
                    widget.onAddFood(
                      foodName,
                      food['carbs'] * quantity,
                      food['proteins'] * quantity,
                      food['fats'] * quantity,
                      quantity,
                    );
                  }
                });
                Navigator.pop(context);
              },
              child: Text('Add Items'),
            ),
          ],
        ),
      ),
    );
  }
}

class NutrientTable extends StatelessWidget {
  final String title;
  final String nutrient;
  final List<Map<String, dynamic>> foodItems;
  final Map<String, bool> selectedFoods;
  final Map<String, int> selectedQuantities;
  final void Function(String, bool) onCheckboxChanged;
  final void Function(String, int) onQuantityChanged;

  NutrientTable({
    required this.title,
    required this.nutrient,
    required this.foodItems,
    required this.selectedFoods,
    required this.selectedQuantities,
    required this.onCheckboxChanged,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Table(
          border: TableBorder.all(),
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[200]),
              children: [
                Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Food Item'))),
                Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Amount'))),
                Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Nutrient/Qty'))),
                Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Select'))),
              ],
            ),
            ...foodItems.map((item) {
              bool isSelected = selectedFoods[item['name']] ?? false;
              int quantity = selectedQuantities[item['name']] ?? 1;
              return TableRow(
                children: [
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item['name']))),
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item['amount']))),
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${item[nutrient]}/${item['amount']}'))),
                  Center(
                    child: Checkbox(
                      value: isSelected,
                      onChanged: (bool? newValue) {
                        onCheckboxChanged(item['name'], newValue ?? false);
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ],
    );
  }
}
