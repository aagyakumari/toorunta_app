import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> getPostalCodeFromBaato(double lat, double lon) async {
  final apiKey = 'bpk.wsEpuG9KOXb-ysyCJg3xs-yNpyppNGDlIjs9irMoSW0g';
  final url =
      'https://api.baato.io/api/v1/reverse?lat=$lat&lon=$lon&key=$apiKey';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      print("🔍 Full Baato response: $body");

      final List<dynamic> dataList = body['data'];

      if (dataList.isNotEmpty) {
        final placeData = dataList[0];

        // Example: Try extracting district or ward instead of geozip
        final address = placeData['address']; // full address string
        final name = placeData['name'];       // name of the place
        final type = placeData['type'];       // type like "hostel"

        print("🏠 Address: $address");
        print("🏷️ Place name: $name");
        print("📦 Type: $type");

        // If there's no 'geozip', return a fallback
        return address; // or return "$address ($type)" for clarity
      } else {
        return "No address found";
      }
    } else {
      print('❌ HTTP error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('❌ Error getting postal code: $e');
    return null;
  }
}
