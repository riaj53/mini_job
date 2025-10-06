import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common_widget/job_card.dart';
import '../provider/job_provider.dart';
import 'job_details.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<JobProvider>(
        builder: (context, jobProvider, child) {
          if (jobProvider.isLoading && jobProvider.jobs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (jobProvider.jobs.isEmpty) {
            return const Center(child: Text('No jobs found.'));
          }
          return RefreshIndicator(
            onRefresh: () => jobProvider.fetchJobs(),
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: jobProvider.jobs.length,
              itemBuilder: (context, index) {
                final job = jobProvider.jobs[index];
                return JobCard(
                  job: job,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobDetailScreen(job: job),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
