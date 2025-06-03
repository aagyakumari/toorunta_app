import 'package:toorunta_mobile/features/map/model/vendor_model.dart';


class VendorRepository {
  // Dummy vendor data
  List<Vendor> fetchVendorsNear(double userLat, double userLng) {
    return [
      Vendor(
        id: '1',
        name: 'Sweet Treats Bakery',
        category: 'Bakery',
        description: 'Delicious homemade pastries and breads.',
        latitude: userLat + 0.001,
        longitude: userLng + 0.001,
      ),
      Vendor(
        id: '2',
        name: 'Fresh Meat Butcher',
        category: 'Butcher',
        description: 'Quality meats and cuts from local farms.',
        latitude: userLat - 0.0015,
        longitude: userLng + 0.0012,
      ),
      Vendor(
        id: '3',
        name: 'Seafood Market',
        category: 'Fishmonger',
        description: 'Fresh fish daily from the coast.',
        latitude: userLat + 0.0018,
        longitude: userLng - 0.001,
      ),
    ];
  }
}
