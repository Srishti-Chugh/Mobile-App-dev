import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calendar_screen.dart';
import 'monthly_conclusions.dart';

class MoodTracker extends StatefulWidget {
  const MoodTracker({super.key});

  @override
  State<MoodTracker> createState() => _MoodTrackerState();
}

class _MoodTrackerState extends State<MoodTracker> {
  String selectedMood = "";
  final Map<String, String> moodEntries = {};

  void _saveMood(String mood) {
    setState(() {
      selectedMood = mood;
      String today = DateTime.now().toIso8601String().split('T').first;
      moodEntries[today] = mood;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> moods = [
      {'emoji': '😠', 'label': 'Depressed'},
      {'emoji': '😟', 'label': 'Sad'},
      {'emoji': '😐', 'label': 'Meh'},
      {'emoji': '😊', 'label': 'Happy'},
      {'emoji': '😁', 'label': 'Excited'},
      {'emoji': '😄', 'label': 'Elated'},
      {'emoji': '😍', 'label': 'Over the Moon'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 28, 65, 101),
        elevation: 0,
        title: Text(
          "MoOd TrAckeR",
          style: GoogleFonts.patrickHand(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CalendarScreen(moodEntries: moodEntries),
                ),
              );
            },
            color: Colors.white,
          ),
          IconButton(
            icon: const Icon(Icons.insights),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MonthlyConclusions(moodEntries: moodEntries),
                ),
              );
            },
            color: Colors.white,
          ),
        ],
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/appBG5.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'How are you feeling today?',
                      style: GoogleFonts.patrickHand(
                        color: const Color.fromARGB(255, 28, 65, 101),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: moods.map((mood) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            _saveMood(mood['label']);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 28, 65, 101),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                mood['emoji'],
                                style: const TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                mood['label'],
                                style: GoogleFonts.patrickHand(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      selectedMood.isEmpty
                          ? 'No mood selected'
                          : 'Selected mood: $selectedMood',
                      style: GoogleFonts.patrickHand(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
