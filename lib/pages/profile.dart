import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = "Aveenath"; // default name
  final String _email = "aveenath@gmail.com"; // default email

  @override
  void initState() {
    super.initState();
    _loadName(); // load saved name when page starts
  }

  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString("profile_name") ?? "Aveenath";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("👤 Profile"),
        backgroundColor: const Color(0xFF90CAF9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("images/profile.png"),
            ),
            const SizedBox(height: 16),

            // Dynamic name
            Text(
              _name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Dynamic email
            Text(
              _email,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Edit Profile
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text("Edit Profile"),
              onTap: () async {
                final newName = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfilePage(),
                  ),
                );
                if (newName != null && newName is String) {
                  setState(() {
                    _name = newName;
                  });
                }
              },
            ),

            // Settings
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.green),
              title: const Text("Settings"),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Settings tapped")),
                );
              },
            ),

            // Logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Onboarding()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
