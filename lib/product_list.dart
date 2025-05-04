import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product.dart';
import 'product_details.dart';
import 'package:fluttertoast/fluttertoast.dart';

List<Product> cartItems = [];
List<Product> wishlistItems = [];
List<Product> orderHistory = [];

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  String selectedCategory = 'All';
  String searchText = '';
  List<String> categories = ['All'];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    const url = 'https://fakestoreapi.com/products';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      allProducts = data.map((item) => Product.fromJson(item)).toList();

      categories.addAll(allProducts.map((e) => e.category).toSet().toList());

      applyFilters();
    }
  }

  void applyFilters() {
    setState(() {
      List<Product> tempList = selectedCategory == 'All'
          ? allProducts
          : allProducts.where((p) => p.category == selectedCategory).toList();

      if (searchText.isNotEmpty) {
        tempList = tempList
            .where((p) =>
                p.title.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      }

      filteredProducts = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Products")),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search products...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                searchText = value;
                applyFilters();
              },
            ),
          ),
          const SizedBox(height: 10),

          // 🔘 Category Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: categories.map((cat) {
                final isSelected = selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: Colors.teal,
                    onSelected: (_) {
                      selectedCategory = cat;
                      applyFilters();
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),

          // 🛍 Product Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: filteredProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns per row
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Card(
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Hero(
                          tag: product.id,
                          child: Image.network(product.image, fit: BoxFit.contain),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text("\$${product.price}", style: const TextStyle(color: Colors.green)),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              cartItems.add(product);
                              Fluttertoast.showToast(msg: "Added to Cart!");
                            },
                            icon: const Icon(Icons.shopping_cart),
                          ),
                          IconButton(
                            onPressed: () {
                              wishlistItems.add(product);
                              Fluttertoast.showToast(msg: "Added to Wishlist!");
                            },
                            icon: const Icon(Icons.favorite_border),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailsPage(product: product),
                                ),
                              );
                            },
                            icon: const Icon(Icons.info_outline),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
