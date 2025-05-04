import 'package:flutter/material.dart';
import 'product.dart';
import 'product_list.dart'; // To access wishlistItems

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist")),
      body: ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          final item = wishlistItems[index];
          return ListTile(
            leading: Image.network(item.image, width: 50),
            title: Text(item.title),
            subtitle: Text("\$${item.price}"),
          );
        },
      ),
    );
  }
}
