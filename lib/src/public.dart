import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

import 'enums.dart';
import 'nearest.dart';
import 'route.dart';

/// The master OSRM object used to make requests and get back the simple, formatted response usually needed
///
/// If you require the full response, use `OSRMFull` instead.
class OSRM {
  /// The profile to use when making a request
  final OSRMProfile profile;

  /// Creates a master OSRM object used to make requests and get back the simple, formatted response usually needed
  OSRM(this.profile);

  /// Uses the 'nearest' service to get the closest useful (eg. on a network/ways) coordinate to a coordinate anywhere on Earth
  Future<List<OSRMNearest>> nearest(LatLng coord, [int number = 1]) {
    return nearestInternal(profile, coord, number);
  }

  /// Uses the 'route' service to get the shortest routes following networks/ways between 2 or more waypoints
  Future<OSRMRoute> route(List<LatLng> waypoints) {
    return routeInternalMain(profile, waypoints);
  }
}

/// The secondary OSRM object used to make requests and get back the full, unformatted server response
///
/// Some services may not be present due to their simple response, use `OSRM` to use those services.
class OSRMFull {
  /// The profile to use when making a request
  final OSRMProfile profile;

  /// Creates a secondary OSRM object used to make requests and get back the full, unformatted server response
  ///
  /// Some services may not be present due to their simple response, use `OSRM` to use those services.
  OSRMFull(this.profile);

  /// Uses the 'route' service to get the shortest routes following networks/ways between 2 or more waypoints
  ///
  /// Returns the full server response, unless an error occurred
  Future<List<Map<String, dynamic>>> route(
    List<LatLng> waypoints, {
    int alternatives = 0,
    bool steps = false,
  }) {
    return routeInternalFull(
      profile,
      waypoints,
      alternatives: alternatives,
      steps: steps,
    );
  }
}

/// An error returned from the request if something went wrong
class OSRMError implements Exception {
  /// Defines what service was in use when the error was created
  final String service;

  /// Defines the error code
  final String code;

  /// Defines the error message
  final String message;

  @internal
  OSRMError(this.service, this.code, this.message);
}
