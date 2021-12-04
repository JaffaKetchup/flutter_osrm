import 'package:flutter_osrm/src/shared/service.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

import '../shared.dart';
import 'models.dart';

////////////////////////////////////////////
/*        FROM THIS POINT ONWARD          */
/* experimental functionality is mixed in */
/*      with working functionality        */
/*                                        */
/*    Any comment in red will warn of     */
/*        an experimental feature         */
////////////////////////////////////////////

/// An implementation of `OSRMProcessed` representing a processed 'nearest' response
///
/// To use fields specific to this object, you should use the 'as' operator to specify that the `OSRMProcessed` object returned from the `.processed` getter is actually a `OSRMRoute` object (for example, `obj as OSRMNearest`)
class OSRMRoute implements OSRMProcessed {
  /// The service that this processed object represents, also represented by the name
  ///
  /// To use fields specific to this object, you should use the 'as' operator to specify that the `OSRMProcessed` object returned from the `.processed` getter is actually a `OSRM{service}` object (for example, `obj as OSRMNearest`)
  @override
  OSRMService service = OSRMService.route;

  /// Total distance of route (m)
  final num totalDistance;

  /// Total duration of route
  final Duration totalDuration;

  /// List of all nodes on route
  final List<LatLng> nodesLocations;

  /// The full API response as a set of classes and sub-classes designed to make navigating the API response easier
  final Route fullResponse;
  @internal
  OSRMRoute(
    this.totalDistance,
    this.totalDuration,
    this.nodesLocations,
    this.fullResponse,
  );
}

@internal
OSRMRoute processRoute(Map<String, dynamic> data) => OSRMRoute(
      data["routes"][0]["distance"],
      Duration(
        seconds: double.parse(data["routes"][0]["duration"].toString()).round(),
      ),
      PolylinePoints()
          .decodePolyline(data["routes"][0]["geometry"])
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList(),
      Route.fromJson(data),
    );



/*
/// Use the Route API, and return a route that can be easily processed and drawn. Also optionally reverse geocode waypoints using Nominatim
Future<OSRMRoute> routeInternalMain(OSRMProfile profile, List<LatLng> waypoints,
    [bool reverseGeocode = false]) async {
  // Make appropriate API request through fullData function
  final List<dynamic> apiResponse = await routeInternalFull(
    profile,
    waypoints,
    //!
    overview: experimental.OSRMOverview.full,
  );

  // Convert the polyline to a list of LatLng nodes
  final List<LatLng> nodes = PolylinePoints()
      .decodePolyline(apiResponse[0]["routes"][0]["geometry"])
      .map((point) => LatLng(point.latitude, point.longitude))
      .toList();

  //!
  // If reverseGeocode has been specified, perform reverse geocoding through Nominatim
  List<String>? outGeocode;
  if (reverseGeocode)
    outGeocode = await geocoding.reverseGeocodeInternal(waypoints);

  // Return formatted data
  return OSRMRoute(
    apiResponse[0]["routes"][0]["distance"],
    Duration(
      seconds: double.parse(apiResponse[0]["routes"][0]["duration"].toString())
          .round(),
    ),
    nodes,
    //!
    outGeocode,
  );
}*/
/*
/// Use the Route API, and return the raw JSON body
// ignore: non_constant_identifier_names
Future<List<Map<String, dynamic>>> routeInternalFull(
  OSRMProfile profile,
  List<LatLng> coords, {
  int alternatives = 0,
  bool steps = false,
  //!
  experimental.OSRMGeometries geometries = experimental.OSRMGeometries.polyline,
  //!
  experimental.OSRMOverview overview = experimental.OSRMOverview.simplified,
  //!
  List<experimental.OSRMAnnotation> annotations = const [
    experimental.OSRMAnnotation.none
  ],
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

  //!
  // Format annotations parameter
  String formattedAnnotations = "";
  if (annotations.contains(experimental.OSRMAnnotation.all))
    formattedAnnotations = "true";
  else if (annotations.contains(experimental.OSRMAnnotation.none))
    formattedAnnotations = "false";
  else {
    for (experimental.OSRMAnnotation item in annotations) {
      formattedAnnotations +=
          item.toString().split('RouteAnnotation.')[1] + ',';
    }
    formattedAnnotations =
        formattedAnnotations.substring(0, formattedAnnotations.length - 1);
  }

  // Make request and format to JSON
  http.Response res = await client.get(
    Uri.parse(
        'https://routing.openstreetmap.de/routed-${profile.toString().split('OSRMProfile.')[1]}/route/v1/driving/$formattedCoords?alternatives=$alternatives&steps=$steps&annotations=$formattedAnnotations&geometries=${geometries.toString().split('OSRMGeometries.')[1]}&overview=${overview.toString().split('OSRMOverview.')[1] == 'none' ? 'false' : overview.toString().split('OSRMOverview.')[1]}'),
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
*/