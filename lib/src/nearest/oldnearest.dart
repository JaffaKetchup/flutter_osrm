import 'package:flutter_osrm/src/shared/service.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

import '../shared.dart';

/// An implementation of `OSRMProcessed` representing a processed 'nearest' response
///
/// To use fields specific to this object, you should use the 'as' operator to specify that the `OSRMProcessed` object returned from the `.processed` getter is actually a `OSRMNearest` object (for example, `obj as OSRMNearest`)
class OSRMNearest implements OSRMProcessed {
  /// The service that this processed object represents, also represented by the name
  ///
  /// To use fields specific to this object, you should use the 'as' operator to specify that the `OSRMProcessed` object returned from the `.processed` getter is actually a `OSRM{service}` object (for example, `obj as OSRMNearest`)
  @override
  OSRMService service = OSRMService.nearest;

  /// Distance in metres away from original location
  final List<double> distance;

  /// Nearest real location to original location
  final List<LatLng> location;

  /// Street name (if applicable) of location
  final List<String> name;

  @internal
  OSRMNearest(this.distance, this.location, this.name);
}

@internal
OSRMNearest processNearest(Map<String, dynamic> data) {
  final List<Map<String, dynamic>> waypoints = data["waypoints"];

  return OSRMNearest(
    waypoints.map<double>((e) => e["distance"]).toList(),
    waypoints
        .map<LatLng>((e) => LatLng(e["location"][1], e["location"][2]))
        .toList(),
    waypoints.map<String>((e) => e["name"]).toList(),
  );
}
