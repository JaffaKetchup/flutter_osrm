import 'package:meta/meta.dart';

/// Options available for any OSRM/Nominatim request and processing
class OSRMGeneralOptions {
  /// The URL template to use to construct OSRM request URLs
  ///
  /// Must follow a certain format:
  ///  - {p}: profile
  ///  - {s}: service
  ///  - {c}: coordinates
  ///  - {q}: query paramters
  ///
  /// Defaults to 'https://routing.openstreetmap.de/routed-{p}/{s}/v1/{p}/{c}.json?{q}'.
  ///
  /// If using the default server, you and any of your app's users must agree and respect the server's rules and restrictions, available at https://routing.openstreetmap.de/about.html.
  ///
  /// It is strongly recommended to use your own server for speed and stability.
  final String osrmUrlTemplate;

  /// The URL template to use to construct Nominatim Reverse request URLs
  ///
  /// Must follow a certain format:
  ///  - {lat}: latitiude coordinate
  ///  - {lon}: longitude coordinate
  ///
  /// Defaults to 'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat={lat}&lon={lon}'.
  ///
  /// If using the default server, you and any of your app's users must agree and respect the server's rules and restrictions, available at https://operations.osmfoundation.org/policies/nominatim/.
  ///
  /// It is strongly recommended to use your own server for speed and stability.
  final String nominatimReverseUrlTemplate;

  /// The URL template to use to construct Nominatim Search request URLs
  ///
  /// Must follow a certain format:
  ///  - {lat}: latitiude coordinate
  ///  - {lon}: longitude coordinate
  ///
  /// Defaults to 'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${lat}&lon=${lon}'.
  ///
  /// If using the default server, you and any of your app's users must agree and respect the server's rules and restrictions, available at https://operations.osmfoundation.org/policies/nominatim/.
  ///
  /// It is strongly recommended to use your own server for speed and stability.
  final String nominatimSearchUrlTemplate;

  /// Limits the search for nodes to given radius in meters
  ///
  /// Note that this option may prevent certain requests from working if a node close enough cannot be found.
  ///
  /// Defaults to `-1`/`double.infinity` (ie. no limit).
  final double radius;

  OSRMGeneralOptions({
    this.osrmUrlTemplate =
        'https://routing.openstreetmap.de/routed-{p}/{s}/v1/{p}/{c}.json?{q}',
    this.nominatimReverseUrlTemplate =
        'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat={lat}&lon={lon}',
    this.nominatimSearchUrlTemplate = '',
    this.radius = -1,
  }) : assert(
          radius >= -1,
          'The `radius` option must be a number greater than or equal to 0, except for -1 specifying no limit',
        );

  @internal
  String get queryString => radius == -1 ? '' : 'radius=' + radius.toString();
}
