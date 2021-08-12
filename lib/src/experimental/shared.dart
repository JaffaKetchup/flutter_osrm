import 'package:latlong2/latlong.dart';

enum OSRMAnnotation {
  all,
  none,
  nodes,
  distance,
  duration,
  datasources,
  weight,
  speed,
}
enum OSRMGeometries {
  polyline,
  polyline6,
  geojson,
}

enum OSRMOverview {
  simplified,
  full,
  none,
}

class OSRMRouteTrip {
  /// Total distance of route (m)
  final num totalDistance;

  /// Total duration of route
  final Duration totalDuration;

  /// List of all nodes on route
  final List<LatLng> nodesLocations;

  /// Optional list of address' of waypoints
  final List<String>? waypointAddresses;

  OSRMRouteTrip(this.totalDistance, this.totalDuration, this.nodesLocations,
      [this.waypointAddresses]);
}

void printWrapped(String text) {
  final pattern = new RegExp('.{1,1023}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
