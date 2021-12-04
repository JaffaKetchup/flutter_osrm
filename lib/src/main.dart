import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:latlong2/latlong.dart';

import 'nearest/nearest.dart';

/// Singleton to manage all OSRM requests and responses, as the public endpoint for you, the developer.
///
/// You must construct using [OSRM.initialise] before using [OSRM.instance], otherwise a [StateError] will be thrown. Note that the singleton can be re-initialised/changed by calling the aforementioned constructor again.
class OSRM {
  //! PROPERTIES & INITIALISE !//

  /// The URL template to use to construct OSRM request URLs
  ///
  /// Note that this should be a secure https server, and the URL should be a valid URI, after the following substitutions have been made...
  ///
  /// The following variables must be present, and will be subsituted with the correct information before a request:
  ///
  /// * {p}: profile
  /// * {s}: service
  /// * {l}: polyline
  /// * {q}: query paramters
  ///
  /// Defaults to 'https://routing.openstreetmap.de/routed-{p}/{s}/v1/{p}/{l}.json?{q}'.
  ///
  /// If using the default server, you and any of your app's users must agree and respect the server's rules and restrictions, available at https://routing.openstreetmap.de/about.html.
  ///
  /// It is strongly recommended to use your own server for speed and stability.
  final String templateURL;

  /// A supported profile to use when making or processing requests
  ///
  /// Note that the basic profiles are: 'car', 'bike', 'foot'; but you can assign any profile your server supports, if using a custom server.
  ///
  /// Defaults to 'car'.
  final Profile profile;

  /// The accuracy to use whilst converting between [LatLng]s and [Polyline]s, using [latLngsToPolyline] & [polylineToLatLngs]
  ///
  /// Must be more than or equal to 1.
  ///
  /// Defaults to 5 (10^5).
  final int accuracyExponent;

  /// Create a singleton to manage all OSRM requests and responses, as the public endpoint for you, the developer.
  ///
  /// You must construct using this before using [OSRM.instance], otherwise a [StateError] will be thrown. Note that the singleton can be re-initialised/changed by calling this constructor again.
  ///
  /// This returns the same object as [OSRM.instance] will afterward.
  OSRM.initialise({
    this.templateURL =
        'https://routing.openstreetmap.de/routed-{p}/{s}/v1/{p}/{l}.json?{q}',
    this.profile = 'car',
    this.accuracyExponent = 5,
  }) {
    assert(
      templateURL.contains('{p}'),
      '`templateURL` must contain variable \'{p}\' for Profile',
    );
    assert(
      templateURL.contains('{s}'),
      '`templateURL` must contain variable \'{s}\' for Service',
    );
    assert(
      templateURL.contains('{l}'),
      '`templateURL` must contain variable \'{l}\' for polyLine',
    );
    assert(
      templateURL.contains('{q}'),
      '`templateURL` must contain variable \'{q}\' for Query parameters',
    );

    assert(
      accuracyExponent >= 1,
      '`accuracyExponent` must be more than or equal to 1',
    );

    _instance = this;
  }

  //! MAIN USAGE !//

  LatLng nearest(double testZero) => nearestService(testZero);

  //! NON-STATIC !//

  /// Convert a series of [LatLng]s to a [Polyline], for use elsewhere within the library
  Polyline latLngsToPolyline(List<LatLng> latLngs) =>
      encodePolyline(latLngs.map((e) => [e.latitude, e.longitude]).toList(),
          accuracyExponent: accuracyExponent);

  /// Convert a [Polyline] to a series of [LatLng]s, for use elsewhere (for example in 'flutter_map')
  List<LatLng> polylineToLatLngs(String polyline) =>
      decodePolyline(polyline, accuracyExponent: accuracyExponent)
          .map((e) => LatLng(e[0].toDouble(), e[1].toDouble()))
          .toList();

  //! STATIC !//

  /// The singleton instance of [OSRM] at call time
  ///
  /// Must not be read or written directly, except in [OSRM.instance] and [OSRM.initialise] respectively.
  static OSRM? _instance;

  /// Get the configured instance of [OSRM], after [OSRM.initialise] has been called, for further actions
  static OSRM get instance {
    if (_instance == null)
      throw StateError(
          'You must construct using `OSRM.initialise()` before getting `OSRM.instance`.');

    return _instance!;
  }
}

/// A Google lossy compression polyline format, represented as a [String] internally
typedef Polyline = String;

/// A profile for an OSRM engine, usually 'car'/'bike'/'foot', represented as a [String] internally
typedef Profile = String;

void main() {
  OSRM.initialise();
  print(OSRM.instance.templateURL);
  print(OSRM.instance.templateURL);
  OSRM.initialise(templateURL: 'd');
  print(OSRM.instance.templateURL);
  print(OSRM.instance.templateURL);
}

/*import 'shared/service.dart';
import 'shared/options.dart';

import 'nearest/nearest.dart';
import 'shared/obj.dart';

OSRMObj OSRM(
  OSRMService service,
  String profile, [
  OSRMGeneralOptions? config,
]) {
  if (service == OSRMService.nearest)
    return OSRMNearest(service, profile, config);
  throw UnimplementedError();
}*/

/*
/// The master OSRM object used to make and process requests to an OSRM API and Nominatim for geocoding if specifed
class OSRM {
  /// A supported profile to use when making or processing requests
  ///
  /// Note that the basic profiles are: "car", "bike", "foot"; but you can assign any profile your server supports, if using a custom server.
  final String profile;

  /// A supported service to use to make and process requests
  final OSRMService service;

  /// An optional options object describing query parameters to be sent with requests that do not depend on service
  final OSRMGeneralOptions? generalOptions;

  /// An optional options object describing query parameters to be sent with requests for a particular service
  ///
  /// Note that the type of options specified here (if any) must match the service type
  final OSRMServiceOptions? serviceOptions;

  /// Get the last response from the API without sending another request
  ///
  /// Returns `null` if a previous response is not available for any reason.
  Map<String, dynamic>? get response =>
      _responseAvailable ? _rawAPIResponse : null;
  late final Map<String, dynamic> _rawAPIResponse;
  bool _responseAvailable = false;

  /// Creates a master OSRM object used to make and process requests to an OSRM API and Nominatim for geocoding if specifed
  OSRM({
    required this.profile,
    required this.service,
    this.generalOptions,
    this.serviceOptions,
  }) : assert(
            serviceOptions != null
                ? (service == OSRMService.nearest
                    ? serviceOptions is OSRMNearestOptions
                    : (service == OSRMService.route
                        ? serviceOptions is OSRMRouteOptions
                        : false))
                : true,
            'When specified, the `serviceOptions` type must match the type of the service in use (dictated by `service`); but it does not');

  Uri _constructURL(List<LatLng> coordinates, OSRMServiceOptions? options) =>
      Uri.parse(
        (generalOptions ?? OSRMGeneralOptions())
            .urlTemplate
            .replaceAll('{p}', profile)
            .replaceAll('{s}', service.toStr)
            .replaceAll(
              '{c}',
              coordinates
                  .map<String>(
                    (e) => e.longitude.toString() + ',' + e.latitude.toString(),
                  )
                  .join(';'),
            )
            .replaceAll(
                '{q}',
                (options ??
                        (service == OSRMService.nearest
                            ? OSRMNearestOptions()
                            : (service == OSRMService.route
                                ? OSRMRouteOptions()
                                : throw UnimplementedError())))
                    .queryString),
      );

  /// Make a request to the OSRM API using the given options and coordinates
  ///
  /// Makes `.response` available, and returns the same response
  Future<Map<String, dynamic>> makeRequest(List<LatLng> coordinates) async {
    final Response res = await get(
      _constructURL(
        coordinates,
        serviceOptions,
      ),
    );
    _rawAPIResponse = json.decode(res.body);
    if (_rawAPIResponse["code"] != "Ok")
      return Future.error(
        OSRMError(
          service.toStr,
          _rawAPIResponse["code"],
          _rawAPIResponse["message"],
        ),
      );

    _responseAvailable = true;
    return response!;
  }

  /// Process the raw API response into an object with only the usually useful information
  ///
  /// To use fields specific to this object, you should use the 'as' operator to specify that the `OSRMProcessed` object returned is actually a `OSRM{service}` object (for example, `obj as OSRMNearest`)
  OSRMProcessed get processed {
    if (!_responseAvailable)
      throw StateError(
          'The raw API response must be available before calling this method. Try calling `.makeRequest(...)` first.');

    if (service == OSRMService.nearest) return processNearest(response!);
    if (service == OSRMService.route) return processRoute(response!);

    throw UnimplementedError();
  }

/*
  /// Uses the 'nearest' service to find the nearest 'real' location (on a building or way/line) from a coordinate
    return nearestInternal(profile, coord, number);
  }

  /// Uses the 'route' service to get the shortest routes following networks/ways between 2 or more waypoints
  Future<OSRMRoute> route(List<LatLng> waypoints) {
    return routeInternalMain(profile, waypoints);
  }
  */
}

/*
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
*/

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
*/
