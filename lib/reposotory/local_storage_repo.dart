import 'package:hive/hive.dart';


import '../models/job_model.dart';

// Repository for handling local data storage using Hive.
class LocalStorageRepository {
  late Box<Job> _savedJobsBox;

  LocalStorageRepository() {
    _savedJobsBox = Hive.box<Job>('saved_jobs');
  }

  // Saves a job to the local storage. The job's ID is used as the key.
  Future<void> saveJob(Job job) async {
    await _savedJobsBox.put(job.id, job);
  }

  // Removes a job from local storage.
  Future<void> removeJob(int jobId) async {
    await _savedJobsBox.delete(jobId);
  }

  // Retrieves all saved jobs from local storage.
  Future<List<Job>> getSavedJobs() async {
    return _savedJobsBox.values.toList();
  }
}

