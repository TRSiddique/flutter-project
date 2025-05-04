import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedMethod;

  final List<String> paymentOptions = [
    'Bkash',
    'Nagad',
    'Rocket',
    'Card',
    'Cash on Delivery',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose Payment Method")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ...paymentOptions.map((option) => RadioListTile(
              title: Text(option),
              value: option,
              groupValue: selectedMethod,
              onChanged: (value) {
                setState(() {
                  selectedMethod = value;
                });
              },
            )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedMethod != null
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Payment by $selectedMethod selected!")),
                      );
                    }
                  : null,
              child: const Text("Confirm Payment"),
            )
          ],
        ),
      ),
    );
  }
}
