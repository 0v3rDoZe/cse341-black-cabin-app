import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  Future<void> _completeOrder(String orderId) async {
    await FirebaseFirestore.instance.collection('orders').doc(orderId).update({
      'status': 'completed',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          final orders = snapshot.data!.docs;
          if (orders.isEmpty)
            return const Center(child: Text("No orders found in database"));

          double totalSales = orders.fold(0.0, (sum, doc) {
            var data = doc.data() as Map<String, dynamic>;
            return sum + (data['total'] ?? 0.0);
          });

          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.redAccent.withOpacity(0.1),
                child: Column(
                  children: [
                    const Text(
                      "TOTAL SALES REVENUE",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "\$${totalSales.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    var orderDoc = orders[index];
                    var data = orderDoc.data() as Map<String, dynamic>;
                    String status = data['status'] ?? 'placed';
                    bool isPending = status != 'completed';
                    int rating = data['rating'] ?? 0; // Retrieve the rating

                    return Card(
                      margin: const EdgeInsets.all(8),
                      shape: isPending
                          ? RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.orange,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            )
                          : null,
                      child: ListTile(
                        leading: Icon(
                          isPending ? Icons.hourglass_top : Icons.check_circle,
                          color: isPending ? Colors.orange : Colors.green,
                        ),
                        title: Text(
                          "Order #${orders.length - index} - \$${(data['total'] ?? 0.0).toStringAsFixed(2)}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Status: ${status.toUpperCase()}"),
                            if (rating > 0)
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Row(
                                  children: List.generate(
                                    5,
                                    (starIndex) => Icon(
                                      starIndex < rating
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amber,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        trailing: isPending
                            ? ElevatedButton(
                                onPressed: () => _completeOrder(orderDoc.id),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                ),
                                child: const Text(
                                  "Verify",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : const Icon(Icons.done_all, color: Colors.green),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
