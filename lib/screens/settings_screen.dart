import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = false;
  bool wifiEnabled = true;
  int _selectedIndex = 1; // Default selected bottom nav index (e.g., home)

  Widget _buildListTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    bool hasSwitch = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: trailing ??
          (hasSwitch ? null : const Icon(Icons.arrow_forward_ios, size: 16)),
      onTap: onTap,
    );
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
      // Add navigation logic here if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'GENERAL',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 10),

          _buildListTile(icon: Icons.person, title: 'Account', onTap: () {
            // Navigate to account settings or show dialog
          }),

          _buildListTile(
            icon: Icons.notifications,
            title: 'Notifications',
            hasSwitch: true,
            trailing: Switch.adaptive(
              value: notificationsEnabled,
              activeColor: Colors.red,
              onChanged: (val) => setState(() => notificationsEnabled = val),
            ),
          ),

          _buildListTile(
            icon: Icons.wifi,
            title: 'Wi-Fi',
            hasSwitch: true,
            trailing: Switch.adaptive(
              value: wifiEnabled,
              activeColor: Colors.green,
              onChanged: (val) => setState(() => wifiEnabled = val),
            ),
          ),

          // Uncomment or add more options here if needed:
          // _buildListTile(icon: Icons.card_giftcard, title: 'Coupons'),
          // _buildListTile(icon: Icons.logout, title: 'Logout'),
          // _buildListTile(icon: Icons.delete, title: 'Delete Account'),

          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'FEEDBACK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 10),

          _buildListTile(icon: Icons.report_problem, title: 'Report a bug', onTap: () {
            // Open bug report page/dialog
          }),

          _buildListTile(icon: Icons.send, title: 'Send feedback', onTap: () {
            // Open feedback form or email composer
          }),

          const SizedBox(height: 20),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Stats'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
        ],
      ),
    );
  }
}
