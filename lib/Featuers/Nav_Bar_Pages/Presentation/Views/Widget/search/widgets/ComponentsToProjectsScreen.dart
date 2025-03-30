// ignore_for_file: file_names

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
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> _recommendedProjects = [];
  bool _isLoading = false;

  final List<String> _availableComponents = [
    "Raspberry Pi",
    "Sensors",
    "Relays",
    "WiFi Module",
    "Power Supply",
    "Cables",
    "Flight Controller",
    "GPS Module",
    "Brushless Motors",
    "ESC",
    "Battery",
    "Propellers",
    "ESP8266",
    "Temperature Sensor",
    "Humidity Sensor",
    "LCD Display",
    "Arduino",
    "Accelerometer Sensor",
    "Motor Driver",
    "Wheels",
    "Chassis",
    "RFID Module",
    "Servo Motor",
    "Keypad",
    "Soil Moisture Sensor",
    "Water Pump",
    "Relay Module",
    "Bluetooth Module",
    "Amplifier Board",
    "Rechargeable Battery",
    "Speaker",
    "PIR Sensor",
    "Camera Module",
    "Alarm Buzzer",
    "IR Sensors",
    "Pulse Sensor",
    "OLED Display",
    "RTC Module",
    "Voltage Regulator",
    "USB Module",
    "Charge Controller",
    "Two-Way Mirror",
    "Microphone",
    "Display Screen",
    "ESP32",
    "Gas Sensors",
    "GSM Module",
    "Current Sensors",
    "Face Recognition Software",
    "Traffic Light LEDs",
    "Fan",
    "Solar Panel",
    "Power Adapter",
    "AI Software",
    "Speed Sensor",
    "Inductive Charging Module",
    "Wireless Controller",
    "Motion Sensor",
    "Remote Control",
    "Stepper Motors",
    "Heated Bed",
    "Extruder",
    "Power Management Board",
    "Flame Sensor",
    "Heart Rate Sensor",
    "E-Ink Display Module",
    "Smoke Sensor",
    "Laser Module",
    "LDR Sensor",
    "Inductive Coil",
    "Power Management Circuit",
    "7-Segment Display",
    "Multiple Sensors",
    "LED Strip",
    "LED Display",
    "DC Motor"
  ];
  final List<String> _selectedComponents = [];

  void _logApiCall(String message) {
    debugPrint("[API LOG]: $message");
  }

  Future<void> _fetchRecommendedProjects() async {
    if (_selectedComponents.isEmpty) return;

    setState(() => _isLoading = true);
    _logApiCall("Fetching projects for components: $_selectedComponents");

    final projects = await _apiService.searchByComponents(
      components: _selectedComponents,
    );

    setState(() {
      _recommendedProjects = projects;
      _isLoading = false;
      _logApiCall("Received \${projects.length} projects");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8.0,
                  children: _availableComponents.map((component) {
                    final isSelected = _selectedComponents.contains(component);
                    return FilterChip(
                      label: Text(component),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedComponents.add(component);
                          } else {
                            _selectedComponents.remove(component);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchRecommendedProjects,
              child: const Text("Find Projects"),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _recommendedProjects.isEmpty
                      ? const Center(
                          child: Text(
                            "No projects found. Try different components.",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
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
                                  "Similarity Score: ${project["match_score"] ?? 0}",
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
