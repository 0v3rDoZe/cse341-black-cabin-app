import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Softer gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF3E0), // very light orange
              Color(0xFFFFFFFF), // white
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Back button at top-left
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.orange),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              // Expanded center content
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Multiple food icons row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("🍔", style: TextStyle(fontSize: 50)),
                            SizedBox(width: 12),
                            Text("🥦", style: TextStyle(fontSize: 50)),
                            SizedBox(width: 12),
                            Text("🐟", style: TextStyle(fontSize: 50)),
                            SizedBox(width: 12),
                            Text("🍕", style: TextStyle(fontSize: 50)),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Title
                        const Text(
                          "Welcome to BLACKCABIN USM",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Subtitle
                        const Text(
                          "Your favorite meals delivered fast.\nLog in or sign up to continue.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.brown,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Login button (orange)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 8,
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Sign Up button (green)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 8,
                            ),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Decorative tagline
                        const Text(
                          "🍕 Fresh taste • 🥗 Anytime • 🍣 Anywhere",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.orange,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
