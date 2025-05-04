import 'package:flutter/material.dart';
import 'product_list.dart';
import 'cart_page.dart';
import 'wishlist_page.dart';
import 'order_history_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: 'logo',
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/3081/3081559.png',
                  height: 100,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'ShopSpot',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const Text('Your Gadget Destination'),
              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductListPage()));
                },
                icon: const Icon(Icons.shopping_bag),
                label: const Text('Browse Products'),
              ),
              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage()));
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('View Cart'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage()));
                },
                child: const Text("Go to Cart"),
              ),
              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const WishlistPage()));
                },
                child: const Text("Go to Wishlist"),
              ),
              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderHistoryPage()));
                },
                child: const Text("Order History"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
