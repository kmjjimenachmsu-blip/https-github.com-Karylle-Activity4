import 'package:flutter/material.dart';

// ACTIVITY 3: Profile Screen for BottomNavigationBar
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.pink,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          SizedBox(height: 20),
          Text(
            'Ice Cream Lover',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Member since 2024',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.star, color: Colors.pink),
            title: Text('Favorite Flavor: Chocolate'),
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag, color: Colors.pink),
            title: Text('Total Orders: 15'),
          ),
        ],
      ),
    );
  }
}
