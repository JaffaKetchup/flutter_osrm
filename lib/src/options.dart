import 'package:meta/meta.dart';

import 'shared.dart';

@internal
abstract class OSRMServiceOptions {
  String get queryString;
}

/// Options available for OSRM requests and processing for service 'nearest'
class OSRMNearestOptions implements OSRMServiceOptions {
  /// Specifies the number of alternative points to also return
  ///
  /// Defaults to `1` (return only the nearest point).
  final int number;

  /// Options available for OSRM requests and processing for service 'nearest'
  OSRMNearestOptions({
    this.number = 1,
  }) : assert(
          number >= 1,
          'The `number` option must be a number greater or equal to 1',
        );

  @override
  @internal
  String get queryString => 'number=' + number.toString();
}

/// Options available for OSRM requests and processing for service 'route'
class OSRMRouteOptions implements OSRMServiceOptions {
  /// Whether to provide alternative routes
  ///
  /// Note that alternatives cannot be guranteed, even if this parameter is `true`.
  ///
  /// Defaults to `false`.
  final bool alternatives;

  /// Whether to return route steps for each leg
  ///
  /// Defaults to `true` (inverse to OSRM API specification).
  final bool steps;

  /// Whether to return 'additional metadata' about each coordinate along the route geometry
  ///
  /// Defaults to `false`.
  final bool annotations;

  /// Specifies the format to return route geometries as
  ///
  /// Defaults to `OSRMGeometry.polyline`, and this is the recommended geometry.
  final OSRMGeometry geometries;

  /// Whether to add overview geometry either full, simplified according to highest zoom level it could be displayed on, or not at all
  ///
  /// 'simplifed': `null`; 'full' (default): `true`; 'false': `false`;
  final bool? overview;

  /// Whether to force the route to keep going straight at waypoints constraining uturns, even if it would be faster
  ///
  /// 'default (depends on profile)' (default): `null`; 'true': 'true'; 'false': 'false';
  // ignore: non_constant_identifier_names
  final bool? continue_straight;

  /// Options available for OSRM requests and processing for service 'nearest'
  OSRMRouteOptions({
    this.alternatives = false,
    this.steps = true,
    this.annotations = false,
    this.geometries = OSRMGeometry.polyline,
    this.overview = true,
    // ignore: non_constant_identifier_names
    this.continue_straight,
  });

  @override
  @internal
  String get queryString =>
      'alternatives=${alternatives.toString()}&steps=${steps.toString()}&annotations=${annotations.toString()}&geometries=${geometries.toString().split('.')[1]}&overview=${overview == null ? 'simplified' : (overview! ? 'full' : 'false')}&continue_straight=${continue_straight == null ? 'default' : continue_straight.toString()}';
}
