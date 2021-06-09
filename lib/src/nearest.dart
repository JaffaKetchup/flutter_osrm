import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import 'shared.dart';

class NearestLocation {
  /// Distance in metres away from original location
  final double distance;

  /// Nearest real location to original location
  final LatLng location;

  /// Street name (if applicable) of location
  final String name;

  NearestLocation(this.distance, this.location, this.name);
}

Future<List<NearestLocation>> nearestLocation(Profile profile, LatLng coord,
    [int n = 1]) async {
  final client = http.Client();

  http.Response res = await client.get(
    Uri.parse(
        'http://router.project-osrm.org/nearest/v1/${profile.toString().split('Profile.')[1]}/${coord.longitude.toString()},${coord.latitude.toString()}.json?number=$n'),
  );
  final data = json.decode(res.body);
  if (data["code"] != "Ok")
    return Future.error(
      OSRMError(
        Service.nearest,
        data["code"],
        data["message"],
      ),
    );

  client.close();

  final out = (data["waypoints"] as List).map(
    (val) {
      return NearestLocation(
        val["distance"],
        LatLng(
          val["location"][1],
          val["location"][0],
        ),
        val["name"],
      );
    },
  ).toList();
  return out;
}
