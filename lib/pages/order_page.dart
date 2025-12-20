import 'package:flutter/material.dart';
import 'cart.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  // Helper function to get status color based on simple feedback rules
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green; // Finished order feedback
      case 'pending verification':
      case 'placed':
        return Colors.orange; // Waiting for admin action
      default:
        return Colors.blue;
    }
  }

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

                // Logic: Default status is 'Placed'.
                // In a real app, this value comes from your Order object/Firebase.
                String status = "Completed";

                return Card(
                  margin: const EdgeInsets.all(12),
                  child: ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order #${index + 1} - \$${order.total.toStringAsFixed(2)}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // Status Chip for simple visual feedback
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(status),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            status.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text("Placed on ${order.date.toLocal()}"),
                    children: [
                      const Divider(),
                      ...order.items.map((item) {
                        return ListTile(
                          leading: Image.asset(item.image, width: 40),
                          title: Text(item.name),
                          trailing: Text(
                            "\$${item.price.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                        );
                      }).toList(),

                      // --- RATING FEEDBACK SECTION ---
                      if (status.toLowerCase() == 'completed') ...[
                        const Divider(),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "How was your meal?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (starIndex) {
                              int ratingNumber = starIndex + 1;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: const Icon(
                                        Icons.star_border,
                                        color: Colors.amber,
                                        size: 32,
                                      ),
                                      onPressed: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "You gave a $ratingNumber-star rating!",
                                            ),
                                            duration: const Duration(
                                              seconds: 1,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "$ratingNumber",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
    );
  }
}
