// // import 'package:dio/dio.dart';

// // class ApiService {
// //   final Dio _dio = Dio(
// //     BaseOptions(
// //       baseUrl: "http://192.168.1.15:7777", // Use your PC's local IP
// //       connectTimeout: const Duration(seconds: 30),
// //       receiveTimeout: const Duration(seconds: 30),
// //     ),
// //   );

// //   Future<Map<String, dynamic>> searchProject({
// //     String? projectDescription,
// //     List<String>? requiredComponents,
// //   }) async {
// //     try {
// //       // Request body
// //       Map<String, dynamic> requestBody = {};
// //       if (projectDescription != null && projectDescription.isNotEmpty) {
// //         requestBody["project_description"] = projectDescription;
// //       }
// //       if (requiredComponents != null && requiredComponents.isNotEmpty) {
// //         requestBody["required_components"] = requiredComponents;
// //       }

// //       // Send POST request
// //       Response response = await _dio.post(
// //         "/search_project",
// //         data: requestBody,
// //       );

// //       // Return response data
// //       return response.data;
// //     } on DioException catch (e) {
// //       // Handle Dio errors
// //       print("❌ Dio Error: ${e.message}");
// //       return {"error": "Failed to connect to the server"};
// //     } catch (e) {
// //       // Handle general errors
// //       print("❌ Unexpected Error: $e");
// //       return {"error": "Something went wrong"};
// //     }
// //   }
// // }
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

//   Future<Map<String, dynamic>> searchProject({
//     required String projectDescription,
//   }) async {
//     try {
//       // Request body following new header format
//       Map<String, dynamic> requestBody = {
//         "project_description": projectDescription,
//       };

//       // Send POST request
//       Response response = await _dio.post(
//         "/search_project",
//         data: requestBody,
//       );

//       // Process response & format output
//       if (response.statusCode == 200) {
//         return {
//           "status": "success",
//           "data": response.data,
//         };
//       } else {
//         return {
//           "status": "error",
//           "message": "Unexpected response code: ${response.statusCode}",
//         };
//       }
//     } on DioException catch (e) {
//       print("❌ Dio Error: ${e.message}");
//       return {
//         "status": "error",
//         "message": "Failed to connect to the server",
//       };
//     } catch (e) {
//       print("❌ Unexpected Error: $e");
//       return {
//         "status": "error",
//         "message": "Something went wrong",
//       };
//     }
//   }
// }

import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.1.15:7777", // Use your PC's local IP
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json", // Ensure JSON format
        "Accept": "application/json",
      },
    ),
  );

  Future<void> searchProject({
    required String projectDescription,
  }) async {
    try {
      // Request body
      Map<String, dynamic> requestBody = {
        "project_description": projectDescription,
      };

      print("\n--------------------------------------");
      print("🔎 Sending Request to API...");
      print("📌 Project Description: $projectDescription");
      print("--------------------------------------\n");

      // Send POST request
      Response response = await _dio.post(
        "/search_project",
        data: requestBody,
      );

      if (response.statusCode == 200) {
        // Format and print response data
        print("✅ API Response Received Successfully!");
        print("--------------------------------------");
        print("📌 Status: Success");
        print("--------------------------------------\n");

        List<dynamic> projects = response.data["similar_projects"] ?? [];
        if (projects.isEmpty) {
          print("⚠️ No similar projects found.");
        } else {
          print("🔹 Similar Projects Found:");
          for (var project in projects) {
            print("--------------------------------------");
            print("🛠️  Project: ${project['project_description']}");
            print("🔩 Components: ${project['required_components']}");
            print("📊 Similarity Score: ${project['similarity_score']}%");
          }
        }
      } else {
        print("❌ API Error: Unexpected response code ${response.statusCode}");
      }
    } on DioException catch (e) {
      print("\n❌ Dio Error: ${e.message}");
      print("--------------------------------------");
      print("🚨 Failed to connect to the server.");
      print("--------------------------------------\n");
    } catch (e) {
      print("\n❌ Unexpected Error: $e");
      print("--------------------------------------");
      print("🚨 Something went wrong.");
      print("--------------------------------------\n");
    }
  }
}
