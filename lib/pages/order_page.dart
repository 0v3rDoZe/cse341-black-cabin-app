import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
      case 'pending verification':
      case 'placed':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("📦 Your Orders"),
        backgroundColor: const Color(0xFF90CAF9),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final orderDocs = snapshot.data?.docs ?? [];
          if (orderDocs.isEmpty) {
            return const Center(
              child: Text("No orders found", style: TextStyle(fontSize: 18)),
            );
          }

          return ListView.builder(
            itemCount: orderDocs.length,
            itemBuilder: (context, index) {
              final orderDoc = orderDocs[index];
              final data = orderDoc.data() as Map<String, dynamic>;
              String status = data['status'] ?? "placed";
              List items = data['items'] ?? [];
              int currentRating = data['rating'] ?? 0; // Get existing rating

              double total = 0.0;
              if (data['total'] != null) {
                total = (data['total'] as num).toDouble();
              } else {
                for (var item in items) {
                  total += (item['price'] ?? 0.0) * (item['qty'] ?? 1);
                }
              }

              return Card(
                margin: const EdgeInsets.all(12),
                child: ExpansionTile(
                  leading: const Icon(Icons.receipt_long),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order #${orderDocs.length - index} - \$${total.toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      _statusChip(status),
                    ],
                  ),
                  children: [
                    const Divider(),
                    ...items
                        .map(
                          (item) => ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[200],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/${item['name']}.jpg',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.fastfood,
                                        color: Colors.grey,
                                      ),
                                ),
                              ),
                            ),
                            title: Text(
                              "${item['name'] ?? 'Item'} (x${item['qty'] ?? 1})",
                            ),
                            trailing: Text(
                              "\$${(item['price'] ?? 0.0).toStringAsFixed(2)}",
                            ),
                          ),
                        )
                        .toList(),

                    if (status.toLowerCase() == 'completed') ...[
                      const Divider(),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "How was your meal?",
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                      // Pass orderId and current rating to the star row
                      _buildRatingRow(context, orderDoc.id, currentRating),
                      const SizedBox(height: 10),
                    ] else ...[
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            "Waiting for Admin verification...",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _statusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
    );
  }

  Widget _buildRatingRow(
    BuildContext context,
    String orderId,
    int currentRating,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => IconButton(
          // Show filled star if index is less than currentRating
          icon: Icon(
            index < currentRating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 30,
          ),
          onPressed: () async {
            // Update rating in Firestore
            await FirebaseFirestore.instance
                .collection('orders')
                .doc(orderId)
                .update({'rating': index + 1});

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Rated ${index + 1} stars!")),
              );
            }
          },
        ),
      ),
    );
  }
}
