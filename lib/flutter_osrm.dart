export 'package:latlong2/latlong.dart';

export 'src/main.dart';
//export 'src/shared/options.dart';
//export 'src/shared/service.dart';
//export 'src/shared.dart' hide OSRMProcessed, ServiceExtensions;
//export 'src/options.dart' hide OSRMServiceOptions;

//export 'src/nearest/nearest.dart' hide processNearest;
//export 'src/route/route.dart' hide processRoute;

/* EXAMPLE BASIC USAGE */

/*
import 'package:flutter_osrm/flutter_osrm.dart';

void osrmExample() async {
  OSRM(OSRMService.nearest, 'car').





  final OSRM osrm = OSRM(
    profile: 'car',
    service: OSRMService.nearest,
  );
  await osrm.makeRequest([]);

  final Map<String, dynamic>? raw = osrm.response;
  final OSRMNearest processed = osrm.processed as OSRMNearest;
}
*/