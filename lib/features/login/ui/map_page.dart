// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';

// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   LatLng? _currentLocation;

//   @override
//   void initState() {
//     super.initState();
//     _fetchLocation();
//   }

//   Future<void> _fetchLocation() async {
//     await Permission.location.request();
//     final position = await Geolocator.getCurrentPosition();
//     setState(() {
//       _currentLocation = LatLng(position.latitude, position.longitude);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('OpenStreetMap')),
//       body: _currentLocation == null
//           ? Center(child: CircularProgressIndicator())
//           : FlutterMap(
//               options: MapOptions(
//                 center: _currentLocation,
//                 zoom: 15.0,
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate:
//                       "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                   subdomains: ['a', 'b', 'c'],
//                   userAgentPackageName: 'com.example.toorunta',
//                 ),
//                 MarkerLayer(
//                   markers: [
//                     Marker(
//                       width: 60.0,
//                       height: 60.0,
//                       point: _currentLocation!,
//                       child:
//                           Icon(Icons.location_pin, color: Colors.red, size: 40),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//     );
//   }
// }
