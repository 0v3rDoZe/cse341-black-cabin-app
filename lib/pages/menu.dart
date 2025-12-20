import 'package:flutter/material.dart';
import 'cart.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 20 food items
    final List<Map<String, dynamic>> foods = [
      {
        "name": "Nasi Goreng Kampung",
        "price": 8.0,
        "image": "images/nasi_goreng.png",
      },
      {
        "name": "Nasi Goreng Pattaya",
        "price": 9.0,
        "image": "images/nasi_goreng_pattaya.png",
      },
      {
        "name": "Mee Goreng Mamak",
        "price": 7.5,
        "image": "images/mee_goreng.png",
      },
      {
        "name": "Mee Goreng Basah",
        "price": 8.0,
        "image": "images/mee_goreng_basah.png",
      },
      {
        "name": "Chicken Chop",
        "price": 15.0,
        "image": "images/chickenchop.png",
      },
      {
        "name": "Spaghetti Carbonara",
        "price": 14.0,
        "image": "images/cabonara.png",
      },
      {
        "name": "Spaghetti Bolognese",
        "price": 14.0,
        "image": "images/bolognese.png",
      },
      {"name": "Mac & Cheese", "price": 12.0, "image": "images/mac_cheese.png"},
      {
        "name": "Fish and Chips",
        "price": 16.0,
        "image": "images/fish_chips.png",
      },
      {
        "name": "Grilled Lamb Chop",
        "price": 22.0,
        "image": "images/lamb_chop.png",
      },
      {
        "name": "Fried Chicken",
        "price": 10.0,
        "image": "images/fried_chicken.png",
      },
      {
        "name": "Chicken Curry",
        "price": 12.0,
        "image": "images/chicken_curry.png",
      },
      {"name": "Beef Rendang", "price": 18.0, "image": "images/rendang.png"},
      {"name": "Satay Ayam/Daging", "price": 12.0, "image": "images/satay.png"},
      {
        "name": "Roti Canai dengan Kari",
        "price": 5.0,
        "image": "images/roti_canai.png",
      },
      {"name": "Laksa Penang", "price": 9.0, "image": "images/laksa.png"},
      {"name": "Tomyam Seafood", "price": 14.0, "image": "images/tomyam.png"},
      {"name": "Sushi Roll", "price": 20.0, "image": "images/sushi.png"},
      {"name": "Pizza Margherita", "price": 15.0, "image": "images/pizza.png"},
      {"name": "Cheese Burger", "price": 13.0, "image": "images/burger.png"},
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "😋 Choose Your Favorite Dish",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF90CAF9),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFFFFFFF),
            ], // soft blue gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3 / 4,
          ),
          itemCount: foods.length,
          itemBuilder: (context, index) {
            final food = foods[index];
            return Card(
              elevation: 8,
              shadowColor: Colors.lightBlue.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: Image.asset(
                        food["image"],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Text(
                      food["name"],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Text(
                    "\$${food["price"].toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      backgroundColor: Color.fromARGB(
                        255,
                        243,
                        244,
                        245,
                      ), // price in soft blue
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 120,
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add selected food to cart
                        CartManager.addItem(
                          CartItem(
                            name: food["name"],
                            price: food["price"],
                            image: food["image"],
                          ),
                        );

                        // Show confirmation
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${food["name"]} added to cart"),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF90CAF9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: const Text("Add"),
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
