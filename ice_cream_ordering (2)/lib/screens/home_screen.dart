import 'package:flutter/material.dart';
import 'order_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

// ACTIVITY 10: Home screen with Drawer and Bottom Tabs
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // ACTIVITY 3 & 5: BottomNavigationBar with icons
  final List<Widget> _tabs = [
    const HomeTab(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ACTIVITY 2 & 6: Drawer menu
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Ice Cream Home'),
        backgroundColor: Colors.pink[400],
        foregroundColor: Colors.white,
      ),
      body: _tabs[_currentIndex],
      // ACTIVITY 3 & 5: BottomNavigationBar with icons
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.pink[400],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.pink[100],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// ACTIVITY 2 & 6: Drawer menu
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.pink[400],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.icecream, size: 48, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  'Ice Cream App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Sweet Navigation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.pink),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              // Already on home, just close drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.pink),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              // ACTIVITY 7: Named route navigation
              Navigator.pushNamed(context, '/about');
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail, color: Colors.pink),
            title: const Text('Contact'),
            onTap: () {
              Navigator.pop(context);
              // ACTIVITY 7: Named route navigation
              Navigator.pushNamed(context, '/contact');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart, color: Colors.pink),
            title: const Text('Order Ice Cream'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.grey),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}

// Home Tab with TabBar (Activity 4 & 9)
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ACTIVITY 4 & 9: TabBar inside AppBar
        Container(
          color: Colors.pink[400],
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.pink[100],
            indicatorColor: Colors.white,
            tabs: const [
              Tab(icon: Icon(Icons.chat), text: 'Chats'),
              Tab(icon: Icon(Icons.update), text: 'Status'),
              Tab(icon: Icon(Icons.phone), text: 'Calls'),
            ],
          ),
        ),
        // ACTIVITY 4: TabBarView
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              ChatsTab(),
              StatusTab(),
              CallsTab(),
            ],
          ),
        ),
      ],
    );
  }
}

// Tab content for Chats
class ChatsTab extends StatelessWidget {
  const ChatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.pink,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text('Ice Cream Lover'),
          subtitle: Text('Can I get extra sprinkles?'),
          trailing: Text('2 min ago'),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.purple,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text('Sweet Tooth'),
          subtitle: Text('My order is ready?'),
          trailing: Text('5 min ago'),
        ),
      ],
    );
  }
}

// Tab content for Status
class StatusTab extends StatelessWidget {
  const StatusTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.update, size: 64, color: Colors.pink),
          SizedBox(height: 20),
          Text(
            'Order Status',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('No recent orders'),
        ],
      ),
    );
  }
}

// Tab content for Calls
class CallsTab extends StatelessWidget {
  const CallsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.call_made, color: Colors.green),
          title: Text('Ice Cream Shop'),
          subtitle: Text('Yesterday, 2:30 PM'),
          trailing: Icon(Icons.phone, color: Colors.pink),
        ),
        ListTile(
          leading: Icon(Icons.call_received, color: Colors.red),
          title: Text('Delivery Service'),
          subtitle: Text('Yesterday, 11:15 AM'),
          trailing: Icon(Icons.phone, color: Colors.pink),
        ),
      ],
    );
  }
}
