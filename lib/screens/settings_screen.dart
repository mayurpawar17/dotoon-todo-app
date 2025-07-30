import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = false;
  bool wifiEnabled = true;

  Widget _buildListTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'GENERAL',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          _buildListTile(icon: Icons.person, title: 'Account'),
          _buildListTile(
            icon: Icons.notifications,
            title: 'Notifications',
            trailing: Switch(
              value: notificationsEnabled,
              activeColor: Colors.red,
              onChanged: (val) => setState(() => notificationsEnabled = val),
            ),
          ),
          _buildListTile(
            icon: Icons.wifi,
            title: 'Wifi',
            trailing: Switch(
              value: wifiEnabled,
              activeColor: Colors.green,
              onChanged: (val) => setState(() => wifiEnabled = val),
            ),
          ),
          // _buildListTile(icon: Icons.card_giftcard, title: 'Coupons'),
          // _buildListTile(icon: Icons.logout, title: 'Logout'),
          // _buildListTile(icon: Icons.delete, title: 'Delete Account'),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'FEEDBACK',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          _buildListTile(icon: Icons.report_problem, title: 'Report a bug'),
          _buildListTile(icon: Icons.send, title: 'Send feedback'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
        ],
      ),
    );
  }
}
