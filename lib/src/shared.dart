import 'package:meta/meta.dart';

import 'shared/service.dart';

/// Supported geometries to get return data as
enum OSRMGeometry {
  /// Google's encoded polyline with precision 5
  polyline,

  /// Google's encoded polyline with precision 6
  polyline6,

  /// JSON format data
  geojson,
}

@internal
abstract class OSRMProcessed {
  late final OSRMService service;
}

@internal
extension ServiceExtensions on OSRMService {
  String get toStr => this.toString().split('.')[1];
}
