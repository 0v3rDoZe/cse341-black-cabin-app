import 'package:flutter/material.dart';
import 'cart.dart';
import 'order_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
                onPressed: () async {
                  if (items.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Cart is empty")),
                    );
                  } else {
                    final orders = OrderService();

                    // Convert cart items to Firestore-friendly maps
                    final orderItems = items
                        .map(
                          (item) => {
                            'id': item
                                .name, // CartItem has no id; use name as fallback
                            'name': item.name,
                            'qty': 1, // quantity not tracked yet; default to 1
                            'price': item.price,
                          },
                        )
                        .toList();

                    final subtotal = CartManager.total;
                    final tax = subtotal * 0.06; // example 6% tax
                    final total = subtotal + tax;

                    try {
                      final orderId = await orders.createOrder(
                        userId:
                            "test-user", // replace with Firebase Auth UID later
                        items: orderItems,
                        subtotal: subtotal,
                        tax: tax,
                        total: total,
                      );

                      setState(() {
                        CartManager.checkout(); // clear cart
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("✅ Order placed: $orderId")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("❌ Failed to place order: $e")),
                      );
                    }
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
