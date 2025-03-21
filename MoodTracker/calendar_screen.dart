import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarScreen extends StatelessWidget {
  final Map<String, String> moodEntries;

  const CalendarScreen({super.key, required this.moodEntries});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calendar',
          style: GoogleFonts.patrickHand(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 28, 65, 101),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: moodEntries.length,
        itemBuilder: (context, index) {
          String date = moodEntries.keys.elementAt(index);
          String mood = moodEntries[date]!;
          return ListTile(
            title: Text(
              date,
              style: GoogleFonts.patrickHand(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              mood,
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
