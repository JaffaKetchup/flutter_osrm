import 'package:meta/meta.dart';

import '../../experimental.dart';
import '../route/route.dart';
import 'shared.dart';

/// The experimental master OSRM object used to make advanced, experimental requests and get back the simple, formatted response usually needed
///
/// All functionality within is experimental and subject to major, breaking changes without major updates, or removal altogether.
///
/// Non-experimental functionality is not included: use the standard import and `OSRM`/`OSRMFull`. However, some overall non-experimental functionality has parts of optional experimental functionality within. To use these features you should use this import and this/`OSRMExperimentalFull`.
///
/// You must set `forceExperimental` to `true`.
///
/// If you require the full response, use `OSRMExperimentalFull` instead.
class OSRMExperimental {
  /// The profile to use when making a request
  final OSRMProfile profile;

  /// Must set to true; by setting to true you realise the potential dangers ahead
  final bool forceExperimental;

  /// Creates an experimental master OSRM object used to make advanced, experimental requests and get back the simple, formatted response usually needed
  ///
  /// All functionality within is experimental and subject to major, breaking changes without major updates, or removal altogether.
  ///
  /// Non-experimental functionality is not included: use the standard import and `OSRM`/`OSRMFull`. However, some overall non-experimental functionality has parts of optional experimental functionality within. To use these features you should use this import and this/`OSRMExperimentalFull`.
  ///
  /// You must set `forceExperimental` to `true`.
  ///
  /// If you require the full response, use `OSRMExperimentalFull` instead.
  OSRMExperimental(this.profile, {this.forceExperimental = false})
      : assert(forceExperimental,
            'You must set `forceExperimental` to `true` to use this object. By setting that, you realise the potential dangers ahead.');

  /// Uses the 'route' service to get the shortest routes following networks/ways between 2 or more waypoints, optionally reverse geocoding each waypoint through 'Nominatim'.
  Future<OSRMRoute> route(List<LatLng> waypoints,
      [bool reverseGeocode = true]) {
    return routeInternalMain(profile, waypoints, reverseGeocode);
  }

  /// Uses 'Nominatim' to get the address of locations
  Future<List<String>> reverseGeocode(
    List<LatLng> locations,
  ) {
    return reverseGeocodeInternal(locations);
  }

  /// COMING SOON
  ///
  /// Uses the trip service to "solves the Traveling Salesman Problem using a greedy heuristic (farthest-insertion algorithm) for 10 or more waypoints and uses brute force for less than 10 waypoints. The returned path does not have to be the fastest path. As TSP is NP-hard it only returns an approximation. Note that all input coordinates have to be connected for the trip service to work."
  @alwaysThrows
  void trip() {
    throw UnimplementedError('\'trip\' service being exposed soon!');
  }
}

/// The experimental secondary OSRM object used to make advanced, experimental requests and get back the the full, unformatted server response
///
/// All functionality within is experimental and subject to major, breaking changes without major updates, or removal altogether.
///
/// Non-experimental functionality is not included: use the standard import and `OSRM`/`OSRMFull`. However, some overall non-experimental functionality has parts of optional experimental functionality within. To use these features you should use this import and `OSRMExperimental`/this.
///
/// You must set `forceExperimental` to `true`.
/// Some services may not be present due to their simple response, use `OSRMExperimental` to use those services.
class OSRMExperimentalFull {
  /// The profile to use when making a request
  final OSRMProfile profile;

  /// Must set to true; by setting to true you realise the potential dangers ahead
  final bool forceExperimental;

  /// Creates an experimental secondary OSRM object used to make advanced, experimental requests and get back the the full, unformatted server response
  ///
  /// All functionality within is experimental and subject to major, breaking changes without major updates, or removal altogether.
  ///
  /// Non-experimental functionality is not included: use the standard import and `OSRM`/`OSRMFull`. However, some overall non-experimental functionality has parts of optional experimental functionality within. To use these features you should use this import and `OSRMExperimental`/this.
  ///
  /// You must set `forceExperimental` to `true`.
  ///
  /// Some services may not be present due to their simple response, use `OSRMExperimental` to use those services.
  OSRMExperimentalFull(this.profile, {this.forceExperimental = false})
      : assert(forceExperimental,
            'You must set `forceExperimental` to `true` to use this object. By setting that, you realise the potential dangers ahead.');

  /// Uses the 'route' service to get the shortest routes following networks/ways between 2 or more waypoints
  ///
  /// Returns the full server response, unless an error occurred
  Future<List<Map<String, dynamic>>> route(
    List<LatLng> waypoints, {
    int alternatives = 0,
    bool steps = false,
    OSRMGeometries geometries = OSRMGeometries.polyline,
    OSRMOverview overview = OSRMOverview.simplified,
    List<OSRMAnnotation> annotations = const [OSRMAnnotation.none],
  }) {
    return routeInternalFull(
      profile,
      waypoints,
      alternatives: alternatives,
      steps: steps,
      geometries: geometries,
      overview: overview,
      annotations: annotations,
    );
  }

  /// Uses 'Nominatim' to get the address of locations
  ///
  /// Returns the full server response, unless an error occurred
  Future<List<String>> reverseGeocode(
    List<LatLng> locations,
  ) {
    return reverseGeocodeInternal(locations, ReverseGeocodeOutputType.all);
  }

  /// COMING SOON
  ///
  /// Uses the trip service to "solves the Traveling Salesman Problem using a greedy heuristic (farthest-insertion algorithm) for 10 or more waypoints and uses brute force for less than 10 waypoints. The returned path does not have to be the fastest path. As TSP is NP-hard it only returns an approximation. Note that all input coordinates have to be connected for the trip service to work."
  @alwaysThrows
  void trip() {
    throw UnimplementedError('\'trip\' service being exposed soon!');
  }
}
