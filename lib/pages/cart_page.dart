import 'package:flutter/material.dart';
import 'cart.dart';
import 'order_service.dart';
import 'payment_method_sheet.dart'; // Ensure this is imported

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Logic to process order after payment method is chosen
  Future<void> _processOrder(String method) async {
    final items = CartManager.items;
    final orders = OrderService();

    final orderItems = items
        .map(
          (item) => {
            'id': item.name,
            'name': item.name,
            'qty': 1,
            'price': item.price,
          },
        )
        .toList();

    final subtotal = CartManager.total;
    final tax = subtotal * 0.06;
    final total = subtotal + tax;

    try {
      final orderId = await orders.createOrder(
        userId: "test-user",
        items: orderItems,
        subtotal: subtotal,
        tax: tax,
        total: total,
        paymentMethod: method, // Added based on your Service update
      );

      setState(() {
        CartManager.checkout();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Order ($method) placed: $orderId")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ Failed to place order: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = CartManager.items;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("🛒 Your Cart"),
        backgroundColor: const Color(0xFF90CAF9),
      ),
      body: items.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: Image.asset(item.image, width: 50),
                    title: Text(item.name),
                    subtitle: Text("\$${item.price.toStringAsFixed(2)}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          CartManager.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${item.name} removed")),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Total: \$${CartManager.total.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (items.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Cart is empty")),
                    );
                  } else {
                    // Trigger the payment sheet instead of direct checkout
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => PaymentMethodSheet(
                        onMethodSelected: (String chosenMethod) {
                          _processOrder(chosenMethod);
                        },
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF90CAF9),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("Checkout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
