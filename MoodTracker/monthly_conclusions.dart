import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonthlyConclusions extends StatelessWidget {
  final Map<String, String> moodEntries;

  const MonthlyConclusions({super.key, required this.moodEntries});

  @override
  Widget build(BuildContext context) {
    // Summarize the moods
    final Map<String, int> moodSummary = {};
    moodEntries.values.forEach((mood) {
      moodSummary[mood] = (moodSummary[mood] ?? 0) + 1;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Monthly Conclusions',
          style: GoogleFonts.patrickHand(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 28, 65, 101),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: moodSummary.length,
        itemBuilder: (context, index) {
          String mood = moodSummary.keys.elementAt(index);
          int count = moodSummary[mood]!;
          return ListTile(
            title: Text(
              mood,
              style: GoogleFonts.patrickHand(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              '$count times',
              style: GoogleFonts.patrickHand(
                fontSize: 20,
              ),
            ),
          );
        },
      ),
    );
  }
}
