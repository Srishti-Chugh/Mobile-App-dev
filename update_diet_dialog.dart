import 'package:flutter/material.dart';

class UpdateDietDialog extends StatefulWidget {
  final Function(int, int, int) onUpdate;

  UpdateDietDialog({required this.onUpdate});

  @override
  _UpdateDietDialogState createState() => _UpdateDietDialogState();
}

class _UpdateDietDialogState extends State<UpdateDietDialog> {
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _activityLevelController = TextEditingController();
  final _goalController = TextEditingController();

  String? _selectedActivityLevel;
  String? _selectedGoal;

  final List<String> _activityLevels = ['Sedentary', 'Moderate', 'Active'];
  final List<String> _goals = ['Weight Loss', 'Maintenance', 'Muscle Gain'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Diet Plan'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Height (cm)'),
            ),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Weight (kg)'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedActivityLevel,
              hint: Text('Select Activity Level'),
              items: _activityLevels.map((activity) {
                return DropdownMenuItem(
                  value: activity,
                  child: Text(activity),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedActivityLevel = value;
                });
              },
              decoration: InputDecoration(labelText: 'Activity Level'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedGoal,
              hint: Text('Select Goal'),
              items: _goals.map((goal) {
                return DropdownMenuItem(
                  value: goal,
                  child: Text(goal),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGoal = value;
                });
              },
              decoration: InputDecoration(labelText: 'Goal'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            int carbs = _calculateCarbs();
            int proteins = _calculateProteins();
            int fats = _calculateFats();
            widget.onUpdate(carbs, proteins, fats);
            Navigator.pop(context); // Close the dialog after updating
          },
          child: Text('Update'),
        ),
      ],
    );
  }

  int _calculateCarbs() {
    // Example calculation based on user inputs and goal
    return 200; // Replace with actual calculation logic
  }

  int _calculateProteins() {
    // Example calculation based on user inputs and goal
    return 150; // Replace with actual calculation logic
  }

  int _calculateFats() {
    // Example calculation based on user inputs and goal
    return 70; // Replace with actual calculation logic
  }
}
