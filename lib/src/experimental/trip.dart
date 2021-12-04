import 'dart:convert' show json;

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

import '../shared.dart';
import '../exts.dart';
import '../main.dart';
import 'shared.dart';
import 'geocoding.dart' as geocoding;

/// CAUTION: EXPERIMENTAL API AHEAD
///
/// Use the Trip API, and return a route that can be easily processed and drawn. Also optionally reverse geocode waypoints using Nominatim
@experimental
Future<OSRMRouteTrip> osrmTrip(OSRMProfile profile, List<LatLng> waypoints,
    [bool reverseGeocode = false]) async {
  // Make appropriate API request through fullData function
  final List<dynamic> apiResponse = await osrmTrip_(
    profile,
    waypoints,
    overview: OSRMOverview.full,
    sourceAtFirst: true,
    destinationAtLast: true,
    roundtrip: waypoints.length > 2,
  );

  // Convert the polyline to a list of LatLng nodes
  final List<LatLng> nodes = PolylinePoints()
      .decodePolyline(apiResponse[0]["trips"][0]["geometry"])
      .map((point) => LatLng(point.latitude, point.longitude))
      .toList();

  // If reverseGeocode has been specified, perform reverse geocoding through Nominatim
  List<String>? outGeocode;
  if (reverseGeocode)
    outGeocode = await geocoding.reverseGeocodeInternal(waypoints);

  // Return formatted data
  return OSRMRouteTrip(
    apiResponse[0]["trips"][0]["distance"],
    Duration(
      seconds: double.parse(apiResponse[0]["trips"][0]["duration"].toString())
          .round(),
    ),
    nodes,
    outGeocode,
  );
}

/// CAUTION: EXPERIMENTAL API AHEAD
///
/// Use the Trip API, and return the raw JSON body
@experimental
// ignore: non_constant_identifier_names
Future<List<Map<String, dynamic>>> osrmTrip_(
  OSRMProfile profile,
  List<LatLng> coords, {
  bool sourceAtFirst = false,
  bool destinationAtLast = false,
  bool roundtrip = true,
  bool steps = false,
  OSRMGeometries geometries = OSRMGeometries.polyline,
  OSRMOverview overview = OSRMOverview.simplified,
  List<OSRMAnnotation> annotations = const [OSRMAnnotation.none],
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
  if (annotations.contains(OSRMAnnotation.all))
    formattedAnnotations = "true";
  else if (annotations.contains(OSRMAnnotation.none))
    formattedAnnotations = "false";
  else {
    for (OSRMAnnotation item in annotations) {
      formattedAnnotations +=
          item.toString().split('RouteAnnotation.')[1] + ',';
    }
    formattedAnnotations =
        formattedAnnotations.substring(0, formattedAnnotations.length - 1);
  }

  // Make request and format to JSON
  http.Response res = await client.get(
    Uri.parse(
        'https://routing.openstreetmap.de/routed-${profile.profile}/trip/v1/${profile.profile}/$formattedCoords?steps=$steps&annotations=$formattedAnnotations&geometries=${geometries.toString().split('OSRMGeometries.')[1]}&overview=${overview.toString().split('OSRMOverview.')[1] == 'none' ? 'false' : overview.toString().split('OSRMOverview.')[1]}&source=${sourceAtFirst == true ? 'first' : 'any'}&destination=${destinationAtLast == true ? 'last' : 'any'}&roundtrip=${roundtrip.toString()}'),
  );
  final data = json.decode(res.body);

  // Check report was ok, else throw an exception
  if (data["code"] != "Ok")
    return Future.error(
      OSRMError(
        'trip',
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
