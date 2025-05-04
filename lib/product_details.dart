import 'package:flutter/material.dart';
import 'product.dart';
import 'payment_page.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network(product.image, height: 150),
            const SizedBox(height: 10),
            Text(product.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("\$${product.price}", style: const TextStyle(fontSize: 18, color: Colors.green)),
            const SizedBox(height: 10),
            Text(product.description),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentPage()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("Buy Now"),
            ),
          ],
        ),
      ),
    );
  }
}
