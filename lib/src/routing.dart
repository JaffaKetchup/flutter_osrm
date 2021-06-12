import 'dart:convert' show json;

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import 'shared.dart';
import 'geocoding.dart' as geocoding;

class OSRMRoute {
  /// Total distance of route (m)
  final num totalDistance;

  /// Total duration of route
  final Duration totalDuration;

  /// List of all nodes on route
  final List<LatLng> nodesLocations;

  /// Optional list of address' of waypoints
  final List<String>? waypointAddresses;

  OSRMRoute(this.totalDistance, this.totalDuration, this.nodesLocations,
      [this.waypointAddresses]);
}

enum OSRMRouteGeometries {
  polyline,
  polyline6,
  geojson,
}
enum OSRMRouteOverview {
  simplified,
  full,
  none,
}
enum OSRMRouteAnnotation {
  all,
  none,
  nodes,
  distance,
  duration,
  datasources,
  weight,
  speed,
}

/// Use the Route API, and return a route that can be easily processed and drawn. Also optionally reverse geocode waypoints using Nominatim
Future<OSRMRoute> osrmRoute(OSRMProfile profile, List<LatLng> waypoints,
    [bool reverseGeocode = false]) async {
  // Make appropriate API request through fullData function
  final List<dynamic> apiResponse = await osrmRoute_(
    profile,
    waypoints,
    overview: OSRMRouteOverview.full,
  );

  // Convert the polyline to a list of LatLng nodes
  final List<LatLng> nodes = PolylinePoints()
      .decodePolyline(apiResponse[0]["routes"][0]["geometry"])
      .map((point) => LatLng(point.latitude, point.longitude))
      .toList();

  // If reverseGeocode has been specified, perform reverse geocoding through Nominatim
  List<String>? outGeocode;
  if (reverseGeocode) outGeocode = await geocoding.reverseGeocode(waypoints);

  // Return formatted data
  return OSRMRoute(
    apiResponse[0]["routes"][0]["distance"],
    Duration(
      seconds: double.parse(apiResponse[0]["routes"][0]["duration"].toString())
          .round(),
    ),
    nodes,
    outGeocode,
  );
}

/// Use the Route API, and return the raw JSON body
// ignore: non_constant_identifier_names
Future<List<Map<String, dynamic>>> osrmRoute_(
  OSRMProfile profile,
  List<LatLng> coords, {
  int alternatives = 0,
  bool steps = false,
  OSRMRouteGeometries geometries = OSRMRouteGeometries.polyline,
  OSRMRouteOverview overview = OSRMRouteOverview.simplified,
  List<OSRMRouteAnnotation> annotations = const [OSRMRouteAnnotation.none],
}) async {
  // Initialise HTTP client
  final client = http.Client();

  // Format coordinates
  String formattedCoords = "";
  for (LatLng coord in coords) {
    formattedCoords +=
        coord.longitude.toString() + ',' + coord.latitude.toString() + ';';
  }
  formattedCoords = formattedCoords.substring(0, formattedCoords.length - 1);

  // Format annotations parameter
  String formattedAnnotations = "";
  if (annotations.contains(OSRMRouteAnnotation.all))
    formattedAnnotations = "true";
  else if (annotations.contains(OSRMRouteAnnotation.none))
    formattedAnnotations = "false";
  else {
    for (OSRMRouteAnnotation item in annotations) {
      formattedAnnotations +=
          item.toString().split('RouteAnnotation.')[1] + ',';
    }
    formattedAnnotations =
        formattedAnnotations.substring(0, formattedAnnotations.length - 1);
  }

  // Make request and format to JSON
  http.Response res = await client.get(
    Uri.parse(
        'https://routing.openstreetmap.de/routed-${profile.toString().split('Profile.')[1]}/route/v1/driving/$formattedCoords?alternatives=$alternatives&steps=$steps&annotations=$formattedAnnotations&geometries=${geometries.toString().split('RouteGeometries.')[1]}&overview=${overview.toString().split('RouteOverview.')[1] == 'none' ? 'false' : overview.toString().split('RouteOverview.')[1]}'),
  );
  final data = json.decode(res.body);

  // Check report was ok, else throw an exception
  if (data["code"] != "Ok")
    return Future.error(
      OSRMError(
        'routing',
        data["code"],
        data["message"],
      ),
    );

  // Close HTTP client
  client.close();

  // Return appropriate data
  //? if (alternatives != 0) return data;
  return [data];
}
