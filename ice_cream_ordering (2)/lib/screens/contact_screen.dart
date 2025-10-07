import 'package:flutter/material.dart';

// ACTIVITY 7: Contact Screen for named routes
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: Colors.pink[400],
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get in Touch',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.pink),
              title: Text('123 Sweet Street'),
              subtitle: Text('Ice Cream City, IC 12345'),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.pink),
              title: Text('(555) 123-ICECREAM'),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.pink),
              title: Text('hello@icecreamparadise.com'),
            ),
            ListTile(
              leading: Icon(Icons.access_time, color: Colors.pink),
              title: Text('Open Daily'),
              subtitle: Text('10:00 AM - 10:00 PM'),
            ),
          ],
        ),
      ),
    );
  }
}
