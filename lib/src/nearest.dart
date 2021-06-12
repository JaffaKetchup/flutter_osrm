import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import 'shared.dart';

class OSRMNearest {
  /// Distance in metres away from original location
  final double distance;

  /// Nearest real location to original location
  final LatLng location;

  /// Street name (if applicable) of location
  final String name;

  OSRMNearest(this.distance, this.location, this.name);
}

Future<List<OSRMNearest>> osrmNearest(OSRMProfile profile, LatLng coord,
    [int n = 1]) async {
  // Initialise HTTP client
  final client = http.Client();

  // Make request and format to JSON
  http.Response res = await client.get(
    Uri.parse(
        'https://routing.openstreetmap.de/routed-${profile.toString().split('Profile.')[1]}/route/v1/driving/${coord.longitude.toString()},${coord.latitude.toString()}.json?number=$n'),
  );
  final data = json.decode(res.body);

  // Check report was ok, else throw an exception
  if (data["code"] != "Ok")
    return Future.error(
      OSRMError(
        'nearest',
        data["code"],
        data["message"],
      ),
    );

  // Close HTTP client
  client.close();

  // Return formatted data
  return (data["waypoints"] as List).map(
    (val) {
      return OSRMNearest(
        val["distance"],
        LatLng(
          val["location"][1],
          val["location"][0],
        ),
        val["name"],
      );
    },
  ).toList();
}
