import 'package:flutter/material.dart';
import 'product.dart';
import 'product_list.dart'; // To access orderHistory

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order History")),
      body: ListView.builder(
        itemCount: orderHistory.length,
        itemBuilder: (context, index) {
          final item = orderHistory[index];
          return ListTile(
            leading: Image.network(item.image, width: 50),
            title: Text(item.title),
            subtitle: Text("Paid: \$${item.price}"),
          );
        },
      ),
    );
  }
}
