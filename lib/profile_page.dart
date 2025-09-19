import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _logout(BuildContext context) async {
    try {
      await Supabase.instance.client.auth.signOut();

      Navigator.pushNamedAndRemoveUntil(
        context,
        "/login",
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage("assets/images/avatar.png"),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "chaima",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "(+)1 234 567 890",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _logout(context),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          const Divider(thickness: 1),
          Expanded(
            child: ListView(
              children: [
                _buildProfileItem(
                  context,
                  icon: Icons.person_outline,
                  title: "My Account",
                  route: "/myAccount",
                ),
                _buildProfileItem(
                  context,
                  icon: Icons.location_on_outlined,
                  title: "Address",
                  route: "/address",
                ),
                _buildProfileItem(
                  context,
                  icon: Icons.local_offer_outlined,
                  title: "Offers & Promos",
                  route: "/offers",
                ),
                _buildProfileItem(
                  context,
                  icon: Icons.favorite_border,
                  title: "Your Favorites",
                  route: "/favorites",
                ),
                _buildProfileItem(
                  context,
                  icon: Icons.history,
                  title: "Order History",
                  route: "/orderHistory",
                ),
                _buildProfileItem(
                  context,
                  icon: Icons.help_outline,
                  title: "Help Center",
                  route: "/help",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(BuildContext context,
      {required IconData icon,
      required String title,
      required String route}) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }
}
