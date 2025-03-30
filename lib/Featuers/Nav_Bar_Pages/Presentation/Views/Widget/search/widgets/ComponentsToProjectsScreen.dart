import 'package:flutter/material.dart';
import 'package:store/services/DioServiceHelper.dart';

class ComponentsToProjectsScreen extends StatefulWidget {
  const ComponentsToProjectsScreen({super.key});

  @override
  State<ComponentsToProjectsScreen> createState() =>
      _ComponentsToProjectsScreenState();
}

class _ComponentsToProjectsScreenState
    extends State<ComponentsToProjectsScreen> {
  final TextEditingController _componentsController = TextEditingController();
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> _recommendedProjects = [];
  bool _isLoading = false;

  void _logApiCall(String message) {
    debugPrint("[API LOG]: $message");
  }

  Future<void> _fetchRecommendedProjects() async {
    final userInput = _componentsController.text.trim();
    if (userInput.isEmpty) return;

    setState(() => _isLoading = true);
    _logApiCall("Fetching projects for components: $userInput");

    final projects = await _apiService.searchByComponents(
      components: userInput.split(',').map((e) => e.trim()).toList(),
    );

    setState(() {
      _recommendedProjects = projects;
      _isLoading = false;
      _logApiCall("Received ${projects.length} projects");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _componentsController,
              decoration: InputDecoration(
                labelText: "Enter Components",
                hintText: "e.g., Arduino, Relay Module",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.blue),
                  onPressed: _fetchRecommendedProjects,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: _recommendedProjects.isEmpty
                        ? const Center(
                            child: Text(
                              "No projects found. Try different components.",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _recommendedProjects.length,
                            itemBuilder: (context, index) {
                              final project = _recommendedProjects[index];
                              final requiredComponents =
                                  project["required_components"];
                              final componentsText = requiredComponents is List
                                  ? requiredComponents.join(", ")
                                  : requiredComponents.toString();
                              return Card(
                                elevation: 3,
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(12),
                                  title: Text(
                                    project["project_description"] ??
                                        "Unknown Project",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    "Match Score: ${project["match_score"]}%",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.blueGrey),
                                  ),
                                  trailing: SizedBox(
                                    width: 150,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("Required Components:"),
                                        Text(
                                          componentsText,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
