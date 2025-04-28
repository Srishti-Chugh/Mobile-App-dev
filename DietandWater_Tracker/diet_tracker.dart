import 'package:flutter/material.dart';
import 'update_diet_dialog.dart';
import 'food_selection_page.dart';

class DietTrackerPage extends StatefulWidget {
  @override
  _DietTrackerPageState createState() => _DietTrackerPageState();
}

class _DietTrackerPageState extends State<DietTrackerPage> {
  int carbs = 0;
  int proteins = 0;
  int fats = 0;

  int carbsConsumed = 0;
  int proteinsConsumed = 0;
  int fatsConsumed = 0;

  // To store selected food items for each meal
  List<Map<String, dynamic>> breakfastItems = [];
  List<Map<String, dynamic>> lunchItems = [];
  List<Map<String, dynamic>> dinnerItems = [];

  void updateDiet(int newCarbs, int newProteins, int newFats) {
    setState(() {
      carbs = newCarbs;
      proteins = newProteins;
      fats = newFats;

      // Recalculate consumed nutrients
      carbsConsumed = _calculateTotalNutrients(breakfastItems, 'carbs') +
          _calculateTotalNutrients(lunchItems, 'carbs') +
          _calculateTotalNutrients(dinnerItems, 'carbs');

      proteinsConsumed = _calculateTotalNutrients(breakfastItems, 'proteins') +
          _calculateTotalNutrients(lunchItems, 'proteins') +
          _calculateTotalNutrients(dinnerItems, 'proteins');

      fatsConsumed = _calculateTotalNutrients(breakfastItems, 'fats') +
          _calculateTotalNutrients(lunchItems, 'fats') +
          _calculateTotalNutrients(dinnerItems, 'fats');
    });
  }

  int _calculateTotalNutrients(
      List<Map<String, dynamic>> items, String nutrient) {
    return items.fold(
        0,
        (sum, item) =>
            sum + (item[nutrient] as int) * (item['quantity'] as int));
  }

  void addFood(String mealType, String foodName, int carbs, int proteins,
      int fats, int quantity) {
    final selectedItem = {
      'name': foodName,
      'carbs': carbs,
      'proteins': proteins,
      'fats': fats,
      'quantity': quantity,
    };

    setState(() {
      switch (mealType) {
        case 'Breakfast':
          breakfastItems.add(selectedItem);
          break;
        case 'Lunch':
          lunchItems.add(selectedItem);
          break;
        case 'Dinner':
          dinnerItems.add(selectedItem);
          break;
      }

      // Recalculate consumed nutrients after adding new food
      carbsConsumed = _calculateTotalNutrients(breakfastItems, 'carbs') +
          _calculateTotalNutrients(lunchItems, 'carbs') +
          _calculateTotalNutrients(dinnerItems, 'carbs');

      proteinsConsumed = _calculateTotalNutrients(breakfastItems, 'proteins') +
          _calculateTotalNutrients(lunchItems, 'proteins') +
          _calculateTotalNutrients(dinnerItems, 'proteins');

      fatsConsumed = _calculateTotalNutrients(breakfastItems, 'fats') +
          _calculateTotalNutrients(lunchItems, 'fats') +
          _calculateTotalNutrients(dinnerItems, 'fats');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet Tracker'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Rectangles at the top
                Row(
                  children: [
                    Expanded(
                      child: StatRectangle(
                        title: "Carbs",
                        value: "$carbsConsumed / $carbs g",
                        color: Colors.blueAccent,
                        progress: (carbs == 0) ? 0 : (carbsConsumed / carbs),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: StatRectangle(
                        title: "Protein",
                        value: "$proteinsConsumed / $proteins g",
                        color: Colors.orangeAccent,
                        progress:
                            (proteins == 0) ? 0 : (proteinsConsumed / proteins),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: StatRectangle(
                        title: "Fat",
                        value: "$fatsConsumed / $fats g",
                        color: Colors.greenAccent,
                        progress: (fats == 0) ? 0 : (fatsConsumed / fats),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: StatRectangle(
                        title: "Fiber",
                        value: "15 to go",
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: StatRectangle(
                        title: "Water",
                        value: "66 to go",
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Section divided into left and right parts
                Row(
                  children: [
                    // Left side with text and button
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to the Diet Tracker!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Here you can keep track of your daily nutrient intake and manage your diet effectively.',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return UpdateDietDialog(
                                    onUpdate: (newCarbs, newProteins, newFats) {
                                      updateDiet(
                                          newCarbs, newProteins, newFats);
                                    },
                                  );
                                },
                              );
                            },
                            child: Text('Update Diet Plan'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),

                    // Right side with image
                    Expanded(
                      child: Image.asset(
                        'assets/diet_tracker_image.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Buttons for selecting meals in a single row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodSelectionPage(
                              mealType: 'Breakfast',
                              onAddFood:
                                  (foodName, carbs, proteins, fats, quantity) {
                                addFood('Breakfast', foodName, carbs, proteins,
                                    fats, quantity);
                              },
                            ),
                          ),
                        );
                      },
                      child: Text('Select Breakfast'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodSelectionPage(
                              mealType: 'Lunch',
                              onAddFood:
                                  (foodName, carbs, proteins, fats, quantity) {
                                addFood('Lunch', foodName, carbs, proteins,
                                    fats, quantity);
                              },
                            ),
                          ),
                        );
                      },
                      child: Text('Select Lunch'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodSelectionPage(
                              mealType: 'Dinner',
                              onAddFood:
                                  (foodName, carbs, proteins, fats, quantity) {
                                addFood('Dinner', foodName, carbs, proteins,
                                    fats, quantity);
                              },
                            ),
                          ),
                        );
                      },
                      child: Text('Select Dinner'),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Sections for displaying selected food items for each meal
                MealSection(
                  title: 'Breakfast',
                  foodItems: breakfastItems,
                ),
                MealSection(
                  title: 'Lunch',
                  foodItems: lunchItems,
                ),
                MealSection(
                  title: 'Dinner',
                  foodItems: dinnerItems,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatRectangle extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final double progress;

  const StatRectangle({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
    this.progress = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withOpacity(0.3),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class MealSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> foodItems;

  const MealSection({
    Key? key,
    required this.title,
    required this.foodItems,
  }) : super(key: key);

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
        foodItems.isEmpty
            ? Text(
                'No items selected.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              )
            : Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1),
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
                              child: Text('Nutrients'))),
                      Center(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Quantity'))),
                    ],
                  ),
                  ...foodItems.map(
                    (item) => TableRow(
                      children: [
                        Center(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item['name']))),
                        Center(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '${item['carbs']}g carbs, ${item['proteins']}g proteins, ${item['fats']}g fats'))),
                        Center(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${item['quantity']}x'))),
                      ],
                    ),
                  ),
                ],
              ),
        SizedBox(height: 20),
      ],
    );
  }
}
