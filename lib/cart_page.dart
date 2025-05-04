import 'package:flutter/material.dart';
import 'product.dart';
import 'product_list.dart'; // To access cartItems

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double total = cartItems.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.network(item.image, width: 50),
                  title: Text(item.title),
                  subtitle: Text("\$${item.price}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      cartItems.removeAt(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Removed from cart")),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text("Total: \$${total.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18)),
                ElevatedButton(
                  onPressed: () {
                    orderHistory.addAll(cartItems);
                    cartItems.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Order Placed!")),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text("Place Order"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
