import 'package:flutter/material.dart';
import 'widgets.dart'; // import your shared widgets file

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PersonalInfoPage(),
    );
  }
}

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomePage();
  }
}

/// ---------------- WELCOME PAGE ----------------
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoScaffold(
      step: 0,
      child: Column(
        children: [
          const Spacer(),
          const SizedBox(height: 20),
          const Text(
            'Welcome to STRIV!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Text(
              'Before we begin, please provide some basic personal information to help us ensure accurate health monitoring.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
          ),
          const Spacer(),
          PrimaryButton(
            label: 'OK, Let’s Start ➔',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NamePage()),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------- NAME PAGE ----------------
class NamePage extends StatelessWidget {
  const NamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoScaffold(
      step: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What is your Name?',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Entering your name helps us personalize your health insights. You can skip this step if you’d prefer not to share it.',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          const InputField(hint: 'Name'),
          const SizedBox(height: 15),
          const InputField(hint: 'Surname'),
          const Spacer(),
          PrimaryButton(
            label: 'Continue ➔',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const GenderPage()));
            },
          ),
        ],
      ),
    );
  }
}

/// ---------------- GENDER PAGE ----------------
class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  String selectedGender = '';

  @override
  Widget build(BuildContext context) {
    return InfoScaffold(
      step: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What is your Gender?',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Selecting your gender allows us to tailor health insights more accurately. You may skip this if you prefer not to share.',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildGenderChip('Male'),
              const SizedBox(width: 10),
              _buildGenderChip('Female'),
            ],
          ),
          const Spacer(),
          PrimaryButton(
            label: 'Continue ➔',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WeightPage())),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderChip(String gender) {
    return Expanded(
      child: ChoiceChip(
        label: Text(gender, style: const TextStyle(color: Colors.white)),
        selected: selectedGender == gender,
        selectedColor: Colors.blue,
        onSelected: (_) => setState(() => selectedGender = gender),
        backgroundColor: const Color(0xFF1B2238),
      ),
    );
  }
}

/// ---------------- WEIGHT PAGE ----------------
class WeightPage extends StatelessWidget {
  const WeightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoScaffold(
      step: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What is your Weight?',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'This helps us calculate accurate metrics like BMI. You may skip this step if you prefer not to share.',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          const InputField(hint: 'Weight (kg)'),
          const Spacer(),
          PrimaryButton(
            label: 'Continue ➔',
            onPressed: () {
              // Navigate to next page
            },
          ),
        ],
      ),
    );
  }
}

/// ---------------- SHARED INFO SCAFFOLD ----------------
class InfoScaffold extends StatelessWidget {
  final int step;
  final Widget child;
  const InfoScaffold({super.key, required this.step, required this.child});

  @override
  Widget build(BuildContext context) {
    final totalSteps = 5; // Adjust if you add more steps
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F2C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  AppBackButton(onPressed: () => Navigator.pop(context)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: LinearProgressIndicator(
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                        backgroundColor: Colors.white10,
                        value: (step + 1) / totalSteps,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
