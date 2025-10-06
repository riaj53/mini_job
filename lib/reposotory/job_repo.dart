import 'package:http/http.dart' as http;
import '../models/job_model.dart';
class JobRepository {
  final String _baseUrl = "https://dummyjson.com/products";
  Future<List<Job>> fetchJobs() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        return jobFromJson(response.body);
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      throw Exception('Failed to load jobs: $e');
    }
  }
}
