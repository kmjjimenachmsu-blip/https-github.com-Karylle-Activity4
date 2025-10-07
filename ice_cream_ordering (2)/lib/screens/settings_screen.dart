import 'package:flutter/material.dart';

// ACTIVITY 3: Settings Screen for BottomNavigationBar
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.notifications, color: Colors.pink),
                  title: Text('Push Notifications'),
                  trailing: Switch(value: true, onChanged: null),
                ),
                const ListTile(
                  leading: Icon(Icons.email, color: Colors.pink),
                  title: Text('Email Updates'),
                  trailing: Switch(value: false, onChanged: null),
                ),
                ListTile(
                  leading: const Icon(Icons.palette, color: Colors.pink),
                  title: const Text('Theme'),
                  trailing: DropdownButton<String>(
                    value: 'Pink',
                    items: ['Pink', 'Blue', 'Green']
                        .map((color) => DropdownMenuItem(
                              value: color,
                              child: Text(color),
                            ))
                        .toList(),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
