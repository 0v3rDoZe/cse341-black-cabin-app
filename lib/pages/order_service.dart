import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final _db = FirebaseFirestore.instance;

  /// Create a new order document in Firestore
  Future<String> createOrder({
    required String userId,
    required List<Map<String, dynamic>> items,
    required double subtotal,
    required double tax,
    required double total,
  }) async {
    final docRef = await _db.collection('orders').add({
      'userId': userId,
      'items': items,
      'subtotal': subtotal,
      'tax': tax,
      'total': total,
      'status': 'placed',
      'createdAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  /// Stream all orders for a given user
  Stream<List<Map<String, dynamic>>> watchUserOrders(String userId) {
    return _db
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs.map((d) => {'id': d.id, ...d.data()}).toList(),
        );
  }
}
