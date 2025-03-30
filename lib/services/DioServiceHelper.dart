// import 'dart:developer';

// import 'package:dio/dio.dart';

// class ApiService {
//   final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: "http://192.168.1.15:7777", // Use your PC's local IP
//       connectTimeout: const Duration(seconds: 30),
//       receiveTimeout: const Duration(seconds: 30),
//       headers: {
//         "Content-Type": "application/json", // Ensure JSON format
//         "Accept": "application/json",
//       },
//     ),
//   );

//   Future<void> searchProject({
//     required String projectDescription,
//   }) async {
//     try {
//       // Request body
//       Map<String, dynamic> requestBody = {
//         "project_description": projectDescription,
//       };

//       log("\n--------------------------------------");
//       log("🔎 Sending Request to API...");
//       log("📌 Project Description: $projectDescription");
//       log("--------------------------------------\n");

//       // Send POST request
//       Response response = await _dio.post(
//         "/search_project",
//         data: requestBody,
//       );

//       if (response.statusCode == 200) {
//         // Format and log response data
//         log("✅ API Response Received Successfully!");
//         log("--------------------------------------");
//         log("📌 Status: Success");
//         log("--------------------------------------\n");

//         List<dynamic> projects = response.data["similar_projects"] ?? [];
//         if (projects.isEmpty) {
//           log("⚠️ No similar projects found.");
//         } else {
//           log("🔹 Similar Projects Found:");
//           for (var project in projects) {
//             log("--------------------------------------");
//             log("🛠️  Project: ${project['project_description']}");
//             log("🔩 Components: ${project['required_components']}");
//             log("📊 Similarity Score: ${project['similarity_score']}%");
//           }
//         }
//       } else {
//         log("❌ API Error: Unexpected response code ${response.statusCode}");
//       }
//     } on DioException catch (e) {
//       log("\n❌ Dio Error: ${e.message}");
//       log("--------------------------------------");
//       log("🚨 Failed to connect to the server.");
//       log("--------------------------------------\n");
//     } catch (e) {
//       log("\n❌ Unexpected Error: $e");
//       log("--------------------------------------");
//       log("🚨 Something went wrong.");
//       log("--------------------------------------\n");
//     }
//   }
// }
import 'dart:developer';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.1.15:7777", // Use your PC's local IP
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ),
  );

  Future<List<Map<String, dynamic>>> searchProject({
    required String projectDescription,
  }) async {
    try {
      Response response = await _dio.post(
        "/search_project",
        data: {"project_description": projectDescription},
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(
            response.data["similar_projects"] ?? []);
      } else {
        log("API Error: Unexpected response code ${response.statusCode}");
        return [];
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.message}");
      return [];
    } catch (e) {
      log("Unexpected Error: $e");
      return [];
    }
  }
}
