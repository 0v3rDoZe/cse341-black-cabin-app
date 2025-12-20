import 'package:flutter/material.dart';
import 'bank_payment.dart'; // This is your Step 2 (Upload screen)

class BankDetailsPage extends StatelessWidget {
  const BankDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Step 1: Payment Info"),
        backgroundColor: const Color(0xFF90CAF9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              "Please transfer the total amount to:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Bank Account Info Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: const Column(
                children: [
                  Text(
                    "MAYBANK",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "1234-5678-9012",
                    style: TextStyle(fontSize: 22, letterSpacing: 1.2),
                  ),
                  Text("BLACK CABIN ENTERPRISE"),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Text("OR Scan to Pay:"),
            const SizedBox(height: 10),

            // QR Code Placeholder
            // If you have a QR image, use Image.asset('assets/images/qr.png')
            const Icon(Icons.qr_code_2, size: 200, color: Colors.black87),

            const Spacer(),

            // Button to move to the Upload Receipt screen
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BankPaymentPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF90CAF9),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("I HAVE PAID (NEXT STEP)"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
