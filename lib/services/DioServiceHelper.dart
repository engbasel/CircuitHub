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

  Future<List<Map<String, dynamic>>> searchByComponents({
    required List<String> components,
  }) async {
    try {
      Response response = await _dio.post(
        "/search_project",
        data: {"required_components": components},
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(
            response.data["matching_projects"] ?? []);
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
