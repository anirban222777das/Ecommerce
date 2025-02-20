import 'package:blinders/components/my_drawer_tile.dart';
import 'package:blinders/pages/setting_page.dart';
import 'package:blinders/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // Convert logout to a static method
  static void logout(BuildContext context) {
    final authService = AuthService();
    authService.signOut();
    Navigator.pop(context); // Close the drawer after logging out
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // App logo
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Icon(
              Icons.account_circle,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          // Home list title
          MyDrawerTile(
            text: "H O M E",
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),
          // Settings list title
          MyDrawerTile(
            text: "S E T T I N G S",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingPage(),
                ),
              );
            },
          ),

          const Spacer(),

          // Logout list tile
          MyDrawerTile(
            text: "L O G O U T",
            icon: Icons.logout,
            onTap: () {
              _MyDrawerState.logout(context); // Call the static logout method here
            },
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
