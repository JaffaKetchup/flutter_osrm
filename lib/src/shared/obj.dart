import 'package:flutter_osrm/src/nearest/nearest.dart';

import 'options.dart';
import 'service.dart';

abstract class OSRM {
  /// A supported service to use to make and process requests
  final OSRMService service;

  /// A supported profile (mode) to use when making or processing requests
  ///
  /// Note that the basic profiles are: "car", "bike", "foot"; but you can assign any profile your server supports, if using a custom server.
  final String profile;

  /// An optional options object describing query parameters to be sent with requests that do not depend on service
  final OSRMGeneralOptions? config;

  OSRM(this.service, this.profile, this.config);

  factory OSRM.build(
    OSRMService service,
    String profile, [
    OSRMGeneralOptions? config,
  ]) {
    if (service == OSRMService.nearest)
      return OSRMNearest(service, profile, config);
    throw UnimplementedError();
  }

  String prin() => 'hello';
}
