import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

enum GeocodedAddressInfo { we }

Future<List<String>> reverseGeocode(
    List<LatLng> locations /*, List<GeocodedAddressInfo> returnInfo*/) async {
  // Initialise HTTP client
  final client = http.Client();

  // Prepare return list
  List<String> output = [];

  for (LatLng coord in locations) {
    // Make request and format to JSON
    http.Response res = await client.get(
      Uri.parse(
          'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${coord.latitude}&lon=${coord.longitude}'),
    );
    final data = json.decode(res.body);

    print(data);

    // Format and add to return list
    output.add(
      [
        data["addresstype"] == 'building'
            ? ((data["address"]["house_number"] == null
                    ? ''
                    : data["address"]["house_number"].toString()) +
                ' ' +
                data["address"]["road"])
            : data["address"]["road"],
        ((data["address"]["village"] == null && data["address"]["town"] == null)
            ? data["suburb"]
            : (data["address"]["village"] == null
                ? data["address"]["town"]
                : data["address"]["village"])),
        data["address"]["postcode"],
        data["address"]["country_code"].toUpperCase(),
      ].join(', '),
    );
  }

  // Close HTTP client
  client.close();

  // Return appropriate data
  return output;
}
