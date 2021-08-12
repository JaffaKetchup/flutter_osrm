import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

import 'enums.dart';
import 'public.dart';
import 'exts.dart';

/// The returned object when using the 'nearest' service
class OSRMNearest {
  /// Distance in metres away from original location
  final double distance;

  /// Nearest real location to original location
  final LatLng location;

  /// Street name (if applicable) of location
  final String name;

  /// Creates an object to be returned from the 'nearest' service
  @internal
  OSRMNearest(this.distance, this.location, this.name);
}

Future<List<OSRMNearest>> nearestInternal(
  OSRMProfile profile,
  LatLng coord, [
  int n = 1,
]) async {
  // Initialise HTTP client
  final client = http.Client();

  // Make request and format to JSON
  http.Response res = await client.get(
    Uri.parse(
        'https://routing.openstreetmap.de/routed-${profile.profile}/nearest/v1/${profile.profile}/${coord.longitude.toString()},${coord.latitude.toString()}.json?number=$n'),
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
  return (data["waypoints"] as List)
      .map(
        (val) => OSRMNearest(
          val["distance"],
          LatLng(
            val["location"][1],
            val["location"][0],
          ),
          val["name"],
        ),
      )
      .toList();
}
