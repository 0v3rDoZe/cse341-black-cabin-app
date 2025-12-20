import 'package:flutter/material.dart';
import 'cart.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = CartManager.orders;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("📦 Your Orders"),
        backgroundColor: const Color(0xFF90CAF9),
      ),
      body: orders.isEmpty
          ? const Center(
              child: Text(
                "No orders yet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.all(12),
                  child: ExpansionTile(
                    title: Text(
                      "Order #${index + 1} - \$${order.total.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Placed on ${order.date.toLocal()}"),
                    children: order.items.map((item) {
                      return ListTile(
                        leading: Image.asset(item.image, width: 40),
                        title: Text(item.name),
                        trailing: Text(
                          "\$${item.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.deepOrange,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
    );
  }
}
