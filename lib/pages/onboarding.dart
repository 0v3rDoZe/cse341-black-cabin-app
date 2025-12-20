import 'package:flutter/material.dart';
import 'welcome.dart'; // <-- import WelcomePage instead of login

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        // Vibrant gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFE082), // soft yellow
              Color(0xFFFFCC80), // orange pastel
              Color(0xFFFFAB91), // peach
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // App title
                Text(
                  'BLACKCABIN',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 30),

                // Hero image card
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepOrange.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.0),
                      child: Image.asset(
                        'images/food.png', // make sure this asset exists
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Headline
                Text(
                  'Delicious Food, Delivered Fast',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),

                const SizedBox(height: 12),

                // Subtext
                Text(
                  "Discover the best meals around you\nand order with just a tap!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey[900]),
                ),

                const SizedBox(height: 30),

                // Get Started button
                SizedBox(
                  width: width * 0.7,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomePage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.fastfood, color: Colors.white),
                    label: const Text('Get Started'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 12,
                      shadowColor: Colors.deepOrangeAccent.withOpacity(0.6),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Tagline
                Text(
                  'Fresh taste, anytime, anywhere',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 20),

                // Page indicator dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(true),
                    _buildDot(false),
                    _buildDot(false),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper for page indicator dots
  Widget _buildDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: 10,
      width: isActive ? 24 : 10,
      decoration: BoxDecoration(
        color: isActive
            ? Colors.deepOrange
            : Colors.deepOrange.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
