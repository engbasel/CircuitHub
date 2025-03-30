// import 'package:dio/dio.dart';

// class ApiService {
//   final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: "http://192.168.1.15:7777", // Use your PC's local IP
//       connectTimeout: const Duration(seconds: 30),
//       receiveTimeout: const Duration(seconds: 30),
//     ),
//   );

//   Future<Map<String, dynamic>> searchProject({
//     String? projectDescription,
//     List<String>? requiredComponents,
//   }) async {
//     try {
//       // Request body
//       Map<String, dynamic> requestBody = {};
//       if (projectDescription != null && projectDescription.isNotEmpty) {
//         requestBody["project_description"] = projectDescription;
//       }
//       if (requiredComponents != null && requiredComponents.isNotEmpty) {
//         requestBody["required_components"] = requiredComponents;
//       }

//       // Send POST request
//       Response response = await _dio.post(
//         "/search_project",
//         data: requestBody,
//       );

//       // Return response data
//       return response.data;
//     } on DioException catch (e) {
//       // Handle Dio errors
//       print("❌ Dio Error: ${e.message}");
//       return {"error": "Failed to connect to the server"};
//     } catch (e) {
//       // Handle general errors
//       print("❌ Unexpected Error: $e");
//       return {"error": "Something went wrong"};
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

  Future<Map<String, dynamic>> searchProject({
    required String projectDescription,
  }) async {
    try {
      // Request body following new header format
      Map<String, dynamic> requestBody = {
        "project_description": projectDescription,
      };

      // Send POST request
      Response response = await _dio.post(
        "/search_project",
        data: requestBody,
      );

      // Process response & format output
      if (response.statusCode == 200) {
        return {
          "status": "success",
          "data": response.data,
        };
      } else {
        return {
          "status": "error",
          "message": "Unexpected response code: ${response.statusCode}",
        };
      }
    } on DioException catch (e) {
      print("❌ Dio Error: ${e.message}");
      return {
        "status": "error",
        "message": "Failed to connect to the server",
      };
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return {
        "status": "error",
        "message": "Something went wrong",
      };
    }
  }
}
