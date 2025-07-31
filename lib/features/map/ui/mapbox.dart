import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mb;
import 'package:toorunta_mobile/features/map/ui/map_filter_bottom_sheet.dart';
import 'package:toorunta_mobile/features/product_detail/model/product.dart';
import 'package:toorunta_mobile/features/homepage/ui/home_page.dart';

class MapPage extends StatefulWidget {
  final String? selectedProductId;
  final bool isFromBottomNav;

  const MapPage({
    Key? key,
    this.selectedProductId,
    this.isFromBottomNav = false,
  }) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {
  late mb.MapboxMap _mapboxMap;
  late mb.PointAnnotationManager _annotationManager;

  late Uint8List _userLocationIcon;
  mb.PointAnnotation? _userLocationAnnotation;


  double _lastZoom = 16;
  late mb.Point _initialCenter;
  mb.Point? _currentLocation;
  late Uint8List _productIcon;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    final defaultCenter = mb.Point(
      coordinates: mb.Position(85.3240, 27.7172), // Kathmandu
    );

    _initialCenter = widget.selectedProductId != null
        ? mb.Point(
            coordinates: mb.Position(
              Product.getById(widget.selectedProductId!).longitude.toDouble(),
              Product.getById(widget.selectedProductId!).latitude.toDouble(),
            ),
          )
        : defaultCenter;
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception('Location services are disabled.');

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<Uint8List> _loadImageFromAsset(String path) async {
    final ByteData byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
  }
void _onMapCreated(mb.MapboxMap mapboxMap) async {
  _mapboxMap = mapboxMap;
  _annotationManager = await _mapboxMap.annotations.createPointAnnotationManager();

  try {
    // Load both marker images
    _productIcon = await _loadImageFromAsset("assets/images/product_marker.png");
    _userLocationIcon = await _loadImageFromAsset("assets/images/user_location_marker.png");
  } catch (e) {
    if (kDebugMode) print("Failed to load marker images: $e");
  }

  try {
    // Get current location
    final geoPosition = await _getCurrentLocation();
    _currentLocation = mb.Point(
      coordinates: mb.Position(
        geoPosition.longitude.toDouble(),
        geoPosition.latitude.toDouble(),
      ),
    );

    // Center camera on current location if no specific product selected
    if (widget.selectedProductId == null && _currentLocation != null) {
      await _mapboxMap.flyTo(
        mb.CameraOptions(
          center: _currentLocation,
          zoom: _lastZoom,
        ),
        mb.MapAnimationOptions(duration: 1000),
      );
    }
  } catch (e) {
    if (kDebugMode) print("Location error: $e");
  }

  // Add product markers (this clears old ones)
  _addProductMarkers();

  // Now safely add the user marker (after clearing is done)
  if (_currentLocation != null) {
    _userLocationAnnotation = await _annotationManager.create(
      mb.PointAnnotationOptions(
        geometry: _currentLocation!,
        image: _userLocationIcon,
        iconSize: 0.3,
        textSize: 12.0,
        textOffset: [0, -2.5],
        textAnchor: mb.TextAnchor.TOP,
      ),
    );
  }
}



  void _addProductMarkers() async {
  await _annotationManager.deleteAll();

  List<Product> productsToShow;

  if (widget.selectedProductId != null) {
    productsToShow = [Product.getById(widget.selectedProductId!)];
  } else if (_lastZoom < 14) {
    productsToShow = Product.sampleProducts;
  } else if (_currentLocation != null) {
    productsToShow = Product.sampleProducts.where((product) {
      return _calculateDistance(
            _currentLocation!.coordinates.lat.toDouble(),
            _currentLocation!.coordinates.lng.toDouble(),
            product.latitude.toDouble(),
            product.longitude.toDouble(),
          ) < 5; // ✅ Filter within 5 km
    }).toList();
  } else {
    productsToShow = Product.sampleProducts;
  }

  for (final product in productsToShow) {
    final annotationOptions = mb.PointAnnotationOptions(
      geometry: mb.Point(
        coordinates: mb.Position(
          product.longitude.toDouble(),
          product.latitude.toDouble(),
        ),
      ),
      image: _productIcon,
      iconSize: 0.2,
      textField: product.name,
      textSize: 14.0,
      textOffset: [0, -2.5],
      textAnchor: mb.TextAnchor.TOP,
    );

    await _annotationManager.create(annotationOptions);
  }
}


  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const p = 0.0174533;
    final a = 0.5 -
        math.cos((lat2 - lat1) * p) / 2 +
        math.cos(lat1 * p) *
            math.cos(lat2 * p) *
            (1 - math.cos((lon2 - lon1) * p)) / 2;
    return 12742 * math.asin(math.sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Locations'),
        backgroundColor: const Color(0xFF2D3363),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (widget.isFromBottomNav) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Stack(
        children: [
          mb.MapWidget(
            key: const ValueKey("mapbox"),
            cameraOptions: mb.CameraOptions(
              center: _initialCenter,
              zoom: _lastZoom,
            ),
            onMapCreated: _onMapCreated,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
          ),
          Positioned(
            top: 16,
            right: 16,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return MapFilterBottomSheet(
                      onApply: (distance, priceRange) {
                        print(
                          'Apply pressed: $distance km, Rs ${priceRange.start}-${priceRange.end}',
                        );
                        // TODO: Apply filters
                      },
                    );
                  },
                );
              },
              icon: const Icon(Icons.filter_alt),
              label: const Text("Filter"),
            ),
          ),
        ],
      ),
    );
  }
}