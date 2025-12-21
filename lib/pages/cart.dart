class CartItem {
  final String name;
  final double price;
  final String image;

  CartItem({required this.name, required this.price, required this.image});
}

class Order {
  final List<CartItem> items;
  final double total;
  final DateTime date;
  final String? status;
  Order({
    required this.items,
    required this.total,
    required this.date,
    this.status,
  });
}

class CartManager {
  static final List<CartItem> _items = [];
  static final List<Order> _orders = [];

  static List<CartItem> get items => List.unmodifiable(_items);
  static List<Order> get orders => List.unmodifiable(_orders);

  static void addItem(CartItem item) {
    _items.add(item);
  }

  static void removeItem(CartItem item) {
    _items.remove(item);
  }

  static void removeAt(int index) {
    _items.removeAt(index);
  }

  static void clear() {
    _items.clear();
  }

  static double get total => _items.fold(0.0, (sum, item) => sum + item.price);

  // Save current cart as an order
  static void checkout() {
    if (_items.isNotEmpty) {
      _orders.add(
        Order(
          items: List.from(_items),
          total: total,
          date: DateTime.now(),
          status: "Pending",
        ),
      );
      clear();
    }
  }
}
