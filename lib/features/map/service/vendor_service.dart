import 'package:toorunta_mobile/features/map/model/vendor_model.dart';
import 'package:toorunta_mobile/features/map/repo/vendor_repo.dart';


class VendorService {
  final VendorRepository _repository = VendorRepository();

  List<Vendor> getNearbyVendors(double lat, double lng) {
    return _repository.fetchVendorsNear(lat, lng);
  }
}
