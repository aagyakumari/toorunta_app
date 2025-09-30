// import 'dart:math';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:baato_maps/baato_maps.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:toorunta_mobile/features/map/ui/map_filter_bottom_sheet.dart';
// import 'package:toorunta_mobile/features/product_detail/model/product.dart';
// import 'package:toorunta_mobile/features/homepage/ui/home_page.dart';

// class MapPage extends StatefulWidget {
//   final String? selectedProductId;
//   final bool isFromBottomNav;

//   const MapPage({
//     Key? key,
//     this.selectedProductId,
//     this.isFromBottomNav = false,
//   }) : super(key: key);

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {
//   late BaatoMapController _mapController;
//   BaatoCoordinate? _currentLocation;
//   double _lastZoom = 16;

//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<Position> _getCurrentLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) throw Exception('Location services are disabled.');

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         throw Exception('Location permission denied.');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       throw Exception('Location permissions are permanently denied.');
//     }

//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }

//   void _onMapCreated(BaatoMapController controller) async {
//     _mapController = controller;
//     await Future.delayed(const Duration(milliseconds: 500));

//     try {
//       final position = await _getCurrentLocation();
//       _currentLocation = BaatoCoordinate(
//         latitude: position.latitude,
//         longitude: position.longitude,
//       );

//       if (widget.selectedProductId == null) {
//         await _mapController.cameraManager
//             ?.moveTo(_currentLocation!, zoom: _lastZoom);
//       }
//     } catch (e) {
//       if (kDebugMode) print("Location error: $e");
//     }

//     _addProductMarkers();
//   }

//   void _addProductMarkers() {
//     _mapController.markerManager.clearMarkers();
//     final zoom = _mapController.cameraManager?.getCameraPosition()?.zoom ?? 16;
//     _lastZoom = zoom;

//     List<Product> productsToShow;

//     if (widget.selectedProductId != null) {
//       productsToShow = [Product.getById(widget.selectedProductId!)];
//     } else if (zoom < 14) {
//       productsToShow = Product.sampleProducts;
//     } else if (_currentLocation != null) {
//       productsToShow = Product.sampleProducts.where((product) {
//         return _calculateDistance(
//               _currentLocation!.latitude,
//               _currentLocation!.longitude,
//               product.latitude,
//               product.longitude,
//             ) < 5;
//       }).toList();
//     } else {
//       productsToShow = Product.sampleProducts;
//     }

//     for (final product in productsToShow) {
//       _mapController.markerManager.addMarker(
//         BaatoSymbolOption(
//           geometry: BaatoCoordinate(
//             latitude: product.latitude,
//             longitude: product.longitude,
//           ),
//           iconImage: "home-symbolic",
//           iconSize: 1.5,
//           textField: product.name,
//         ),
//       );
//     }
//   }

//   double _calculateDistance(
//       double lat1, double lon1, double lat2, double lon2) {
//     const p = 0.0174533;
//     final a = 0.5 -
//         cos((lat2 - lat1) * p) / 2 +
//         cos(lat1 * p) *
//             cos(lat2 * p) *
//             (1 - cos((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }

//   Widget _buildMap(BaatoCoordinate center) {
//     return BaatoMap(
//       initialPosition: center,
//       initialZoom: _lastZoom,
//       style: BaatoMapStyle.breeze,
//       myLocationEnabled: true,
//       onMapCreated: _onMapCreated,
//       gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
//         Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context); // For AutomaticKeepAliveClientMixin

//     final defaultCenter = BaatoCoordinate(latitude: 27.7172, longitude: 85.3240);
//     final center = widget.selectedProductId != null
//         ? BaatoCoordinate(
//             latitude: Product.getById(widget.selectedProductId!).latitude,
//             longitude: Product.getById(widget.selectedProductId!).longitude,
//           )
//         : defaultCenter;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product Locations'),
//         backgroundColor: const Color(0xFF2D3363),
//         foregroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             if (widget.isFromBottomNav) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const HomePage()),
//               );
//             } else {
//               Navigator.pop(context);
//             }
//           },
//         ),
//       ),
//       body: Stack(
//         children: [
//           _buildMap(center),
//           Positioned(
//             top: 16,
//             right: 16,
//             child: ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.black,
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               ),
//              onPressed: () {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (context) {
//       return MapFilterBottomSheet(
//         onApply: (distance, priceRange) {
//           // TODO: use the selected filter values to update the map
//           print('Apply pressed: $distance km, Rs ${priceRange.start}-${priceRange.end}');
//           // you could also call _addProductMarkers() again with new logic if needed
//         },
//       );
//     },
//   );
// },
//               icon: const Icon(Icons.filter_alt),
//               label: const Text("Filter"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// }