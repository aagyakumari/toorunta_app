import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class UserTrackingScreen extends StatefulWidget {
  const UserTrackingScreen({super.key});

  @override
  State<UserTrackingScreen> createState() => _UserTrackingScreenState();
}

class _UserTrackingScreenState extends State<UserTrackingScreen> {
  Map<String, dynamic> userData = {};
  String? error;

  @override
  void initState() {
    super.initState();
    trackUser();
  }

  Future<void> trackUser() async {
    try {
      // 1. Requesting location permission
      var status = await Permission.location.request();
      if (!status.isGranted) {
        setState(() => error = "Location permission not granted.");
        return;
      }

      // 2. Getting device location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // 3. Fetching IP geolocation data
      http.Response ipRes;
      try {
        ipRes = await http.get(Uri.parse('http://ip-api.com/json/'));
        print("IP API raw response: ${ipRes.body}");
      } catch (ipErr) {
        print("IP API fetch error: $ipErr");
        setState(() => error = "IP API fetch error: $ipErr");
        return;
      }

      if (ipRes.statusCode != 200) {
        print("IP API error: Status ${ipRes.statusCode}, Body: ${ipRes.body}");
        setState(() => error =
            "IP API failed with status: ${ipRes.statusCode}\nBody: ${ipRes.body}");
        return;
      }

      final ipData = jsonDecode(ipRes.body);

      // 4. Getting device info
      final deviceInfoPlugin = DeviceInfoPlugin();
      AndroidDeviceInfo deviceInfo = await deviceInfoPlugin.androidInfo;

      // 5. Combining data
      Map<String, dynamic> data = {
        "ipaddress": ipData["query"], // IP address
        "country": ipData["country"], // Country name
        "region_name": ipData["regionName"], // Full region name
        "geozip": ipData["zip"], // Postal code (empty string if unavailable)
        "town/city": ipData["city"], // City
        "isp": ipData["isp"], // ISP name
        "_device_type": "Mobile",
        "_device_brand": deviceInfo.brand,
        "_device_name": deviceInfo.model,
        "_device_osFamily": "Android",
        "_device_osName": deviceInfo.version.release,
        "_device_deviceType": deviceInfo.device,
        "_device_browserName": "N/A (Flutter App)",
        "gps_lat": position.latitude,
        "gps_long": position.longitude,
      };

      setState(() {
        userData = data;
      });

      print("Final User Info:\n${jsonEncode(data)}");
    } catch (e, stack) {
      print("Unexpected error: $e");
      print("Stack trace:\n$stack");
      setState(() => error = "Unexpected error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Tracking Info')),
      body: error != null
          ? Center(child: Text("Error: $error"))
          : userData.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: userData.entries
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text("${e.key}: ${e.value}"),
                          ))
                      .toList(),
                ),
    );
  }
}
