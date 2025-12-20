import 'package:flutter/material.dart';
import 'bank_details_page.dart'; // 1. Change this import from bank_payment.dart to bank_details_page.dart

class PaymentMethodSheet extends StatelessWidget {
  final Function(String) onMethodSelected;

  const PaymentMethodSheet({super.key, required this.onMethodSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select Payment Method",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Option 1: Bank Transfer
          ListTile(
            leading: const Icon(Icons.account_balance, color: Colors.blue),
            title: const Text("Bank Transfer"),
            subtitle: const Text("Pay via Online Banking / QR"),
            onTap: () {
              Navigator.pop(context); // Close the sheet

              // Send choice back to CartPage to save to Firebase
              onMethodSelected("Bank Transfer");

              // 2. Change navigation to BankDetailsPage (Step 1)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BankDetailsPage(),
                ),
              );
            },
          ),

          const Divider(),

          // Option 2: Cash
          ListTile(
            leading: const Icon(Icons.payments, color: Colors.green),
            title: const Text("Cash on Delivery"),
            subtitle: const Text("Pay when you receive your order"),
            onTap: () {
              Navigator.pop(context); // Close the sheet

              // Send choice back to CartPage to save to Firebase
              onMethodSelected("Cash");
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
