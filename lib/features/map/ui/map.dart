import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toorunta_mobile/features/map/model/vendor_model.dart';
import 'package:toorunta_mobile/features/map/service/vendor_service.dart';


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? _currentLocation;
  List<Vendor> _vendors = [];
  final VendorService _vendorService = VendorService();

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    await Permission.location.request();
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _vendors = _vendorService.getNearbyVendors(position.latitude, position.longitude);
    });
  }

  void _showVendorDetails(Vendor vendor) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(vendor.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(vendor.category, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 8),
            Text(vendor.description),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Toorunta Map')),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: _currentLocation,
                zoom: 15,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.toorunta',
                ),
                MarkerLayer(
                  markers: [
                    // User location marker
                    Marker(
                      width: 40,
                      height: 40,
                      point: _currentLocation!,
                      child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                    ),
                    // Vendor markers
                    ..._vendors.map(
                      (vendor) => Marker(
                        width: 40,
                        height: 40,
                        point: LatLng(vendor.latitude, vendor.longitude),
                        child: GestureDetector(
                          onTap: () => _showVendorDetails(vendor),
                          child: Icon(Icons.store_mall_directory, color: Colors.blue, size: 36),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
