
import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../reposotory/job_repo.dart';
import '../reposotory/local_storage_repo.dart';
class JobProvider with ChangeNotifier {
  final JobRepository _jobRepository = JobRepository();
  final LocalStorageRepository _localStorageRepository =
  LocalStorageRepository();

  List<Job> _jobs = [];
  List<Job> _savedJobs = [];
  bool _isLoading = true;
  String? _error;

  List<Job> get jobs => _jobs;
  List<Job> get savedJobs => _savedJobs;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Future<void> fetchJobs() async {
    try {
      _jobs = await _jobRepository.fetchJobs();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> fetchSavedJobs() async {
    _savedJobs = await _localStorageRepository.getSavedJobs();
    notifyListeners();
  }
  Future<void> saveJob(Job job) async {
    await _localStorageRepository.saveJob(job);
    _savedJobs.add(job);
    notifyListeners();
  }
  Future<void> removeJob(int jobId) async {
    await _localStorageRepository.removeJob(jobId);
    _savedJobs.removeWhere((job) => job.id == jobId);
    notifyListeners();
  }
  bool isJobSaved(int jobId) {
    return _savedJobs.any((job) => job.id == jobId);
  }
  Future<void> applyForJob(int jobId) async {
    debugPrint('Applied for job with ID: $jobId');
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

