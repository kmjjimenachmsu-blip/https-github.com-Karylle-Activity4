import 'package:flutter/material.dart';
import 'payment_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _specialInstructionsController =
      TextEditingController();

  String? _selectedFlavor;
  bool _withSprinkles = false;
  bool _withWhipCream = true;
  String? _selectedContainer;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final List<Map<String, dynamic>> _orders = [];

  // List of ice cream flavors
  final List<String> _iceCreamFlavors = [
    'Vanilla',
    'Chocolate',
    'Strawberry',
    'Mint Chocolate Chip',
    'Cookies and Cream',
    'Rocky Road',
    'Butter Pecan',
    'Coffee',
    'Pistachio',
    'Neapolitan',
    'Cookie Dough',
    'Chocolate Chip',
    'Rainbow Sherbet',
    'Mango',
    'Pistachio Almond',
    'Salted Caramel',
    'Cotton Candy',
    'Bubble Gum',
    'French Vanilla',
    'Butter Pecan Crunch'
  ];

  Future<void> _selectDate() async {
    try {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1),
      );
      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedDate = picked;
        });
      }
    } catch (e) {
      print('Date picker error: $e');
      // Fallback: Show a dialog with date input
      _showDateInputDialog();
    }
  }

  // Fallback method if date picker fails
  void _showDateInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Date'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter pickup date:'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  final now = DateTime.now();
                  setState(() {
                    _selectedDate = now;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Today'),
              ),
              ElevatedButton(
                onPressed: () {
                  final tomorrow = DateTime.now().add(const Duration(days: 1));
                  setState(() {
                    _selectedDate = tomorrow;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Tomorrow'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectTime() async {
    try {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (picked != null) {
        setState(() {
          _selectedTime = picked;
        });
      }
    } catch (e) {
      print('Time picker error: $e');
      // Fallback: Set current time
      setState(() {
        _selectedTime = TimeOfDay.now();
      });
    }
  }

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _orders.add({
          'flavor': _selectedFlavor,
          'quantity': _quantityController.text,
          'container': _selectedContainer,
          'sprinkles': _withSprinkles,
          'whipCream': _withWhipCream,
          'instructions': _specialInstructionsController.text,
          'date': _selectedDate?.toString() ?? 'Not set',
          'time': _selectedTime?.format(context) ?? 'Not set',
        });
      });

      // Clear form
      _selectedFlavor = null;
      _quantityController.clear();
      _specialInstructionsController.clear();
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text('Ice Cream Order'),
        backgroundColor: Colors.pink[400],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header
            const SizedBox(height: 20),
            Text(
              'Create Your Order',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pink[600],
              ),
            ),
            const SizedBox(height: 30),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Ice Cream Flavor Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedFlavor,
                    decoration: InputDecoration(
                      labelText: 'Ice Cream Flavor',
                      labelStyle: TextStyle(color: Colors.pink[600]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.pink[400]!),
                      ),
                    ),
                    items: _iceCreamFlavors
                        .map((flavor) => DropdownMenuItem(
                              value: flavor,
                              child: Text(flavor),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedFlavor = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a flavor';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _quantityController,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      labelStyle: TextStyle(color: Colors.pink[600]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.pink[400]!),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter quantity';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Container Type Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedContainer,
                    decoration: InputDecoration(
                      labelText: 'Container Type',
                      labelStyle: TextStyle(color: Colors.pink[600]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.pink[400]!),
                      ),
                    ),
                    items: ['Cup', 'Cone', 'Waffle Bowl', 'Box']
                        .map((container) => DropdownMenuItem(
                              value: container,
                              child: Text(container),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedContainer = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select container';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Add-ons Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add-ons:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[600],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Sprinkles option
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.pink[200]!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: const Text('With Sprinkles'),
                          trailing: Checkbox(
                            value: _withSprinkles,
                            onChanged: (value) {
                              setState(() {
                                _withSprinkles = value!;
                              });
                            },
                            activeColor: Colors.pink[400],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Whip Cream option
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.pink[200]!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: const Text('With Whip Cream'),
                          trailing: Switch(
                            value: _withWhipCream,
                            onChanged: (value) {
                              setState(() {
                                _withWhipCream = value;
                              });
                            },
                            activeColor: Colors.pink[400],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Pickup Time Section
                  Text(
                    'Pickup Time:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[600],
                    ),
                  ),
                  const SizedBox(height: 10),

                  Column(
                    children: [
                      // Date Picker Button
                      ElevatedButton(
                        onPressed: _selectDate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[300],
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(_selectedDate == null
                            ? 'Pick Date'
                            : 'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
                      ),
                      const SizedBox(height: 10),

                      // Time Picker Button
                      ElevatedButton(
                        onPressed: _selectTime,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[300],
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(_selectedTime == null
                            ? 'Pick Time'
                            : 'Time: ${_selectedTime!.format(context)}'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Special Instructions
                  TextFormField(
                    controller: _specialInstructionsController,
                    decoration: InputDecoration(
                      labelText: 'Special Instructions',
                      labelStyle: TextStyle(color: Colors.pink[600]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.pink[400]!),
                      ),
                    ),
                    maxLines: 3,
                  ),

                  const SizedBox(height: 30),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitOrder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[400],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Add to Order',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Orders List
            if (_orders.isNotEmpty) ...[
              Text(
                'Your Orders:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[600],
                ),
              ),
              const SizedBox(height: 10),
              ..._orders.map((order) => Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    elevation: 3,
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        '${order['flavor']} x${order['quantity']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Container: ${order['container']}'),
                          Text(
                              'Sprinkles: ${order['sprinkles'] ? 'Yes' : 'No'}'),
                          Text(
                              'Whip Cream: ${order['whipCream'] ? 'Yes' : 'No'}'),
                          Text(
                              'Instructions: ${order['instructions'].isEmpty ? 'None' : order['instructions']}'),
                          Text('Pickup: ${order['date']} at ${order['time']}'),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(orders: _orders),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[500],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Proceed to Payment',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
