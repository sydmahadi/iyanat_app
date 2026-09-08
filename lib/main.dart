import 'package:flutter/material.dart';

import 'entry_screen.dart';
import 'info_screen.dart';
import 'note_screen.dart';
import 'calculator_screen.dart';
import 'calendar_screen.dart';

void main() {
  runApp(const IyanatApp());
}

class IyanatApp extends StatelessWidget {
  const IyanatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ইয়ানত',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF164A35),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const Color darkGreen = Color(0xFF164A35);
  static const Color green = Color(0xFF246B4A);
  static const Color gold = Color(0xFFC9A45C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EA),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),

            // Logo
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: darkGreen,
                border: Border.all(
                  color: gold,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: darkGreen.withOpacity(0.2),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: gold,
                size: 35,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'ইয়ানত',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'প্রয়োজনীয় সবকিছু এক জায়গায়',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF66756D),
              ),
            ),

            const SizedBox(height: 20),

            // Menu
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(20),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.08,
                children: [
                  menuCard(
                    context,
                    'এন্ট্রি করুন',
                    'নতুন তথ্য যোগ করুন',
                    Icons.edit_note_rounded,
                    const EntryScreen(),
                  ),

                  menuCard(
                    context,
                    'তথ্য দেখুন',
                    'প্রয়োজনীয় তথ্য',
                    Icons.auto_stories_rounded,
                    const InfoScreen(),
                  ),

                  menuCard(
                    context,
                    'নোট করুন',
                    'আপনার নোট',
                    Icons.sticky_note_2_rounded,
                    const NoteScreen(),
                  ),

                  menuCard(
                    context,
                    'ক্যালকুলেটর',
                    'সহজ হিসাব করুন',
                    Icons.calculate_rounded,
                    const CalculatorScreen(),
                  ),

                  menuCard(
                    context,
                    'ক্যালেন্ডার',
                    'তারিখ দেখুন',
                    Icons.calendar_month_rounded,
                    const CalendarScreen(),
                  ),
                ],
              ),
            ),

            Container(
              width: 55,
              height: 1,
              color: gold,
            ),

            const SizedBox(height: 8),

            const Text(
              'Developed by Talpatar Sepai',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              'm.talpatarsepai@gmail.com',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF7A877F),
              ),
            ),

            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  Widget menuCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Widget screen,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => screen,
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: gold.withOpacity(0.25),
            ),
            boxShadow: [
              BoxShadow(
                color: darkGreen.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: darkGreen.withOpacity(0.08),
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: green,
                ),
              ),

              const SizedBox(height: 11),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF183329),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF7A877F),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
