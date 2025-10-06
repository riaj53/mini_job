import 'dart:convert';
import 'package:hive/hive.dart';

part 'job_model.g.dart';
List<Job> jobFromJson(String str) =>
    List<Job>.from(json.decode(str)['products'].map((x) => Job.fromJson(x)));
@HiveType(typeId: 0)
class Job extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double salary;

  @HiveField(4)
  final String companyName;

  @HiveField(5)
  final String location;

  @HiveField(6)
  final String thumbnail;

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.salary,
    required this.companyName,
    required this.location,
    required this.thumbnail,
  });
  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    salary: (json["price"] as num).toDouble(),
    companyName: json["brand"] ?? "Unknown Company",
    location: json["category"] ?? "Remote",
    thumbnail: json["thumbnail"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "price": salary,
    "brand": companyName,
    "category": location,
    "thumbnail": thumbnail,
  };
}

