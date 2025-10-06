import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/job_provider.dart';
import '../reposotory/auth_repo.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We get the user's email and saved jobs count from providers.
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final savedJobsCount = context.watch<JobProvider>().savedJobs.length;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.indigo,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'John Doe', // Dummy Name
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              authProvider.userEmail ?? 'user@example.com', // User Email
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.grey[600]),
            ),
          ),
          const SizedBox(height: 32),
          Card(
            child: ListTile(
              leading: const Icon(Icons.bookmark, color: Colors.indigo),
              title: const Text('Total Saved Jobs'),
              trailing: Text(
                savedJobsCount.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.settings, color: Colors.indigo),
              title: Text('Settings'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.help_outline, color: Colors.indigo),
              title: Text('Help & Support'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
