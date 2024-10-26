import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true; // Initial notification setting
  String _selectedTheme = 'Light'; // Initial theme
  String _appVersion = '1.0.0'; // App version
  String _profilePictureUrl = ''; // Placeholder for profile picture URL

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load saved settings from SharedPreferences
  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      _selectedTheme = prefs.getString('selectedTheme') ?? 'Light';
      _profilePictureUrl = prefs.getString('profilePictureUrl') ?? '';
    });
  }

  // Save settings to SharedPreferences
  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', _notificationsEnabled);
    await prefs.setString('selectedTheme', _selectedTheme);
    await prefs.setString('profilePictureUrl', _profilePictureUrl);
  }

  // Method to update profile picture
  void _updateProfilePicture() {
    // Logic to update profile picture (e.g., using an image picker)
    // After updating, save the new URL
    setState(() {
      _profilePictureUrl = 'new_picture_url'; // Placeholder
    });
    _saveSettings();
  }

  // Method to toggle theme
  void _toggleTheme() {
    setState(() {
      _selectedTheme = _selectedTheme == 'Light' ? 'Dark' : 'Light';
      // Update the app theme here
    });
    _saveSettings();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Theme changed to $_selectedTheme')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Settings Header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Settings",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          // Profile Picture Section
          _buildCard(
            context,
            icon: Icons.account_circle,
            title: "Profile Picture",
            subtitle: _profilePictureUrl.isNotEmpty
                ? "Change your profile picture"
                : "Add a profile picture",
            onTap: () {
              _updateProfilePicture(); // Call to update the profile picture
            },
            trailing: _profilePictureUrl.isNotEmpty
                ? CircleAvatar(
                    backgroundImage: NetworkImage(_profilePictureUrl),
                    radius: 20,
                  )
                : Icon(Icons.add_a_photo),
          ),
          // Account Section
          _buildCard(
            context,
            icon: Icons.account_circle,
            title: "Account",
            subtitle: "Manage your account settings",
            onTap: () {
              // Add navigation to account settings
            },
          ),
          // Notifications Section
          _buildSwitchTile(
            context,
            title: "Enable Notifications",
            subtitle: "Receive notifications about updates",
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
              _saveSettings(); // Save the setting
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        'Notifications ${value ? 'enabled' : 'disabled'}')),
              );
            },
          ),
          // Appearance Section
          _buildCard(
            context,
            icon: Icons.palette,
            title: "Appearance",
            subtitle: "Choose your app theme",
            trailing: DropdownButton<String>(
              value: _selectedTheme,
              items: <String>['Light', 'Dark'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _toggleTheme(); // Toggle theme method
                }
              },
            ),
          ),
          // Privacy Section
          _buildCard(
            context,
            icon: Icons.privacy_tip,
            title: "Privacy Policy",
            subtitle: "Read our privacy policy",
            onTap: () {
              // Add navigation to privacy policy
            },
          ),
          // Help Section
          _buildCard(
            context,
            icon: Icons.help_outline,
            title: "Help & Support",
            subtitle: "Get help and support",
            onTap: () {
              // Add navigation to help & support
            },
          ),
          // App Version Section
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              "App Version: $_appVersion",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Function()? onTap,
    Widget? trailing,
  }) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, size: 40),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: trailing ?? Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      elevation: 4,
      child: SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
