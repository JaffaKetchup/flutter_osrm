import 'src/services/match/result.dart';
import 'src/services/nearest/result.dart';
import 'src/services/route/result.dart';
import 'src/services/table/result.dart';
import 'src/services/trip/result.dart';
import 'src/utils/rate_limited_stream.dart';

class OSRM {
  factory OSRM() => _instance;

  factory OSRM.initialize({
    String urlTemplate =
        'https://routing.openstreetmap.de/routed-{p}/{s}/v1/{p}/{l}.json?{q}',
    Duration osrmRateLimiting = const Duration(milliseconds: 500),
  }) =>
      _instance = OSRM._(urlTemplate, osrmRateLimiting);

  OSRM._(this.urlTemplate, Duration osrmRateLimiting)
      : osrmRateLimitedStream = RateLimitedStream(emitEvery: osrmRateLimiting);

  static late OSRM _instance;

  final RateLimitedStream osrmRateLimitedStream;

  final String urlTemplate;

  Future<void> dispose() async {
    await osrmRateLimitedStream.close();
  }

  MatchResult match() => matchImpl(this);
  NearestResult nearest() => nearestImpl(this);
  RouteResult route() => routeImpl(this);
  TableResult table() => tableImpl(this);
  TripResult trip() => tripImpl(this);
}
