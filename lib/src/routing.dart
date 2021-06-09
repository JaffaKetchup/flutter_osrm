import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../flutter_map_routing.dart';
import 'models/routing.dart';

class FastestRoute {
  /// Distance in metres away from original location
  final double distance;

  /// Nearest real location to original location
  final LatLng location;

  FastestRoute(this.distance, this.location);
}

enum RouteGeometries {
  polyline,
  polyline6,
  geojson,
}
enum RouteOverview {
  simplified,
  full,
  none,
}

void printWrapped(String text) {
  final pattern = new RegExp('.{1,1023}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Future< /*List<FastestRoute>*/ RoutingOutput> fastestRoute(
  Profile profile,
  List<LatLng> coords, {
  bool autoSnap = true,
  int alternatives = 0,
  bool steps = false,
  bool annotations = false,
  RouteGeometries geometries = RouteGeometries.polyline,
  RouteOverview overview = RouteOverview.simplified,
}) async {
  final client = http.Client();
  String formattedCoords = "";

  for (LatLng coord in coords) {
    if (autoSnap) {
      coord = (await nearestLocation(profile, coord).catchError((e) {
        throw e;
      }))[0]
          .location;
    }
    formattedCoords = formattedCoords +
        coord.longitude.toString() +
        ',' +
        coord.latitude.toString() +
        ';';
  }
  formattedCoords = formattedCoords.substring(0, formattedCoords.length - 1);

  http.Response res = await client.get(
    Uri.parse(
        'http://router.project-osrm.org/route/v1/${profile.toString().split('Profile.')[1]}/$formattedCoords?alternatives=$alternatives&steps=$steps&annotations=$annotations&geometries=${geometries.toString().split('RouteGeometries.')[1]}&overview=${overview.toString().split('RouteOverview.')[1] == 'none' ? 'false' : overview.toString().split('RouteOverview.')[1]}'),
  );
  final data = json.decode(res.body);
  if (data["code"] != "Ok")
    return Future.error(
      OSRMError(
        Service.routing,
        data["code"],
        data["message"],
      ),
    );

  client.close();

  /*final out = (data["waypoints"] as List).map(
    (val) {
      return FastestRoute(
        val["distance"],
        LatLng(
          val["location"][0],
          val["location"][1],
        ),
      );
    },
  ).toList();
  return out;*/
  printWrapped(res.body);
  return RoutingOutput.fromJson(data);
}
