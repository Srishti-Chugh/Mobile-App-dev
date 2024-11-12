import 'package:flutter/material.dart';

class WaterTrackerPage extends StatefulWidget {
  @override
  _WaterTrackerPageState createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
  int dailyGoal = 0;
  int waterConsumed = 0;

  void addWater(int amount) {
    setState(() {
      waterConsumed += amount;
      if (waterConsumed > dailyGoal) waterConsumed = dailyGoal;
    });
  }

  void openUpdateGoalDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return UpdateGoalDialog(
          onUpdate: (age, height, weight) {
            setState(() {
              dailyGoal = (weight * 35).toInt(); // Simplified formula
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '“Drinking water is like washing out your insides. The water will cleanse the system, fill you with energy, and light up your brain.”',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: openUpdateGoalDialog,
                child: Text('Update Daily Goal'),
              ),
              SizedBox(height: 20),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 200, // Increased size of the drop
                    height: 300, // Increased height of the drop
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: ClipOval(
                      child: FractionallySizedBox(
                        heightFactor: waterConsumed /
                            (dailyGoal == 0
                                ? 1
                                : dailyGoal), // Avoid division by 0
                        alignment: Alignment.bottomCenter,
                        child: Container(color: Colors.blue),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Text(
                      '$waterConsumed ml / $dailyGoal ml',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/teacup.png'),
                        iconSize: 30, // Reduced size of the images
                        onPressed: () => addWater(150), // Teacup
                      ),
                      Text('150 ml'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/glass.png'),
                        iconSize: 30, // Reduced size of the images
                        onPressed: () => addWater(250), // Glass
                      ),
                      Text('250 ml'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/bottle.png'),
                        iconSize: 30, // Reduced size of the images
                        onPressed: () => addWater(500), // Bottle
                      ),
                      Text('500 ml'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/jug.png'),
                        iconSize: 30, // Reduced size of the images
                        onPressed: () => addWater(1000), // Jug
                      ),
                      Text('1000 ml'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpdateGoalDialog extends StatefulWidget {
  final Function(int, int, int) onUpdate;

  UpdateGoalDialog({required this.onUpdate});

  @override
  _UpdateGoalDialogState createState() => _UpdateGoalDialogState();
}

class _UpdateGoalDialogState extends State<UpdateGoalDialog> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Update Goal'),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Height (cm)'),
            ),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Weight (kg)'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            int age = int.parse(ageController.text);
            int height = int.parse(heightController.text);
            int weight = int.parse(weightController.text);

            widget.onUpdate(age, height, weight);
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}
