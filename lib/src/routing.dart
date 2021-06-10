import 'dart:convert';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../flutter_map_routing.dart';

class RouteOutput {
  /// Total distance of route (m)
  final num totalDistance;

  /// Total duration of route
  final Duration totalDuration;

  /// List of all nodes' locations on route
  final List<LatLng> nodesLocations;

  RouteOutput(this.totalDistance, this.totalDuration, this.nodesLocations);
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
enum RouteAnnotation {
  all,
  none,
  nodes,
  distance,
  duration,
  datasources,
  weight,
  speed,
}

Future<RouteOutput> fastestRoute(Profile profile, List<LatLng> coords) async {
  // Make appropriate API request through fullData function
  final List<dynamic> apiResponse = await fastestRoute_fullData(
    profile,
    coords,
    overview: RouteOverview.full,
  );

  // Convert the polyline to a list of LatLng nodes
  final List<LatLng> nodes = PolylinePoints()
      .decodePolyline(apiResponse[0]["routes"][0]["geometry"])
      .map((point) => LatLng(point.latitude, point.longitude))
      .toList();

  // Return formatted data
  return RouteOutput(
    apiResponse[0]["routes"][0]["distance"],
    Duration(
      seconds: double.parse(apiResponse[0]["routes"][0]["duration"].toString())
          .round(),
    ),
    nodes,
  );
}

// ignore: non_constant_identifier_names
Future<List<Map<String, dynamic>>> fastestRoute_fullData(
  Profile profile,
  List<LatLng> coords, {
  int alternatives = 0,
  bool steps = false,
  RouteGeometries geometries = RouteGeometries.polyline,
  RouteOverview overview = RouteOverview.simplified,
  List<RouteAnnotation> annotations = const [RouteAnnotation.none],
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
  if (annotations.contains(RouteAnnotation.all))
    formattedAnnotations = "true";
  else if (annotations.contains(RouteAnnotation.none))
    formattedAnnotations = "false";
  else {
    for (RouteAnnotation item in annotations) {
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
        Service.routing,
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
