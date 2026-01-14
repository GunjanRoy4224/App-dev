import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
Widget build(BuildContext context) {
  final user = context.watch<AuthProvider>().user;

  if (user == null) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  return Scaffold(
    appBar: AppBar(title: const Text("Profile")),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _item("Name", user.fullName),
          _item("Roll Number", user.rollNumber),
          _item("ESEA ID", user.eseaId),
          _item("Department", user.department),
          _item("Year", user.displayYear),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              context.read<AuthProvider>().logout();
            },
            child: const Text("Logout"),
          )
        ],
      ),
    ),
  );
}

  Widget _item(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        "$label: $value",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
