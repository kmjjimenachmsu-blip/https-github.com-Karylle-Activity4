import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class PaymentScreen extends StatefulWidget {
  final List<Map<String, dynamic>> orders;

  const PaymentScreen({super.key, required this.orders});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  String? _selectedPaymentMethod;

  double get totalAmount {
    return widget.orders.length * 5.99;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...widget.orders.map((order) => ListTile(
                  title: Text('${order['flavor']} x${order['quantity']}'),
                  trailing: const Text('\$5.99'),
                )),
            const Divider(),
            ListTile(
              title: const Text(
                'Total Amount',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                '\$${totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedPaymentMethod,
                    decoration:
                        const InputDecoration(labelText: 'Payment Method'),
                    items: [
                      'Credit Card',
                      'Debit Card',
                      'PayPal',
                      'Cash on Delivery'
                    ]
                        .map((method) => DropdownMenuItem(
                              value: method,
                              child: Text(method),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select payment method';
                      }
                      return null;
                    },
                  ),
                  if (_selectedPaymentMethod == 'Credit Card' ||
                      _selectedPaymentMethod == 'Debit Card') ...[
                    TextFormField(
                      controller: _cardController,
                      decoration:
                          const InputDecoration(labelText: 'Card Number'),
                      validator: (value) {
                        if (value == null || value.length != 16) {
                          return 'Please enter valid card number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration:
                          const InputDecoration(labelText: 'Cardholder Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _cvvController,
                      decoration: const InputDecoration(labelText: 'CVV'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.length != 3) {
                          return 'Please enter valid CVV';
                        }
                        return null;
                      },
                    ),
                  ],
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Payment Successful!'),
                            content: const Text(
                                'Your ice cream order has been placed.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WelcomeScreen()),
                                    (route) => false,
                                  );
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text('Complete Payment'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
