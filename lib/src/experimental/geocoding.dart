import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

@experimental
enum ReverseGeocodeOutputType { all, reduced }

@experimental
Future<List<String>> reverseGeocodeInternal(List<LatLng> locations,
    [ReverseGeocodeOutputType outputType =
        ReverseGeocodeOutputType.reduced]) async {
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

    // Format and add to return list
    if (outputType == ReverseGeocodeOutputType.reduced)
      output.add(
        [
          data["addresstype"] == 'building'
              ? ((data["address"]["house_number"] == null
                      ? ''
                      : data["address"]["house_number"].toString()) +
                  ' ' +
                  data["address"]["road"])
              : data["address"]["road"],
          ((data["address"]["village"] == null &&
                  data["address"]["town"] == null)
              ? data["suburb"]
              : (data["address"]["village"] == null
                  ? data["address"]["town"]
                  : data["address"]["village"])),
          data["address"]["postcode"],
          data["address"]["country_code"].toUpperCase(),
        ].join(', '),
      );
    else
      output.add(data);
  }

  // Close HTTP client
  client.close();

  // Return appropriate data
  return output;
}
