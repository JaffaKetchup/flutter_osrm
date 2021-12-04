// Automagically created with huge thanks to https://app.quicktype.io/

import 'dart:convert';

class Route {
  Route({
    this.code,
    this.waypoints,
    this.routes,
  });

  final String? code;
  final List<Waypoint>? waypoints;
  final List<SubRoute>? routes;

  factory Route.fromRawJson(String str) => Route.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        code: json["code"] == null ? null : json["code"],
        waypoints: json["waypoints"] == null
            ? null
            : List<Waypoint>.from(
                json["waypoints"].map((x) => Waypoint.fromJson(x))),
        routes: json["routes"] == null
            ? null
            : List<SubRoute>.from(
                json["routes"].map((x) => SubRoute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "waypoints": waypoints == null
            ? null
            : List<dynamic>.from(waypoints!.map((x) => x.toJson())),
        "routes": routes == null
            ? null
            : List<dynamic>.from(routes!.map((x) => x.toJson())),
      };
}

class SubRoute {
  SubRoute({
    this.legs,
    this.weightName,
    this.weight,
    this.distance,
    this.duration,
  });

  final List<Leg>? legs;
  final String? weightName;
  final double? weight;
  final double? distance;
  final double? duration;

  factory SubRoute.fromRawJson(String str) =>
      SubRoute.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubRoute.fromJson(Map<String, dynamic> json) => SubRoute(
        legs: json["legs"] == null
            ? null
            : List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
        weightName: json["weight_name"] == null ? null : json["weight_name"],
        weight: json["weight"] == null ? null : json["weight"].toDouble(),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        duration: json["duration"] == null ? null : json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "legs": legs == null
            ? null
            : List<dynamic>.from(legs!.map((x) => x.toJson())),
        "weight_name": weightName == null ? null : weightName,
        "weight": weight == null ? null : weight,
        "distance": distance == null ? null : distance,
        "duration": duration == null ? null : duration,
      };
}

class Leg {
  Leg({
    this.steps,
    this.weight,
    this.distance,
    this.summary,
    this.duration,
  });

  final List<Step>? steps;
  final double? weight;
  final double? distance;
  final String? summary;
  final double? duration;

  factory Leg.fromRawJson(String str) => Leg.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        steps: json["steps"] == null
            ? null
            : List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
        weight: json["weight"] == null ? null : json["weight"].toDouble(),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        summary: json["summary"] == null ? null : json["summary"],
        duration: json["duration"] == null ? null : json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "steps": steps == null
            ? null
            : List<dynamic>.from(steps!.map((x) => x.toJson())),
        "weight": weight == null ? null : weight,
        "distance": distance == null ? null : distance,
        "summary": summary == null ? null : summary,
        "duration": duration == null ? null : duration,
      };
}

class Step {
  Step({
    this.intersections,
    this.drivingSide,
    this.geometry,
    this.duration,
    this.distance,
    this.name,
    this.weight,
    this.mode,
    this.maneuver,
    this.ref,
    this.destinations,
    this.rotaryName,
  });

  final List<Intersection>? intersections;
  final DrivingSide? drivingSide;
  final String? geometry;
  final double? duration;
  final double? distance;
  final String? name;
  final double? weight;
  final Mode? mode;
  final Maneuver? maneuver;
  final String? ref;
  final String? destinations;
  final String? rotaryName;

  factory Step.fromRawJson(String str) => Step.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        intersections: json["intersections"] == null
            ? null
            : List<Intersection>.from(
                json["intersections"].map((x) => Intersection.fromJson(x))),
        drivingSide: json["driving_side"] == null
            ? null
            : drivingSideValues.map[json["driving_side"]],
        geometry: json["geometry"] == null ? null : json["geometry"],
        duration: json["duration"] == null ? null : json["duration"].toDouble(),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        name: json["name"] == null ? null : json["name"],
        weight: json["weight"] == null ? null : json["weight"].toDouble(),
        mode: json["mode"] == null ? null : modeValues.map[json["mode"]],
        maneuver: json["maneuver"] == null
            ? null
            : Maneuver.fromJson(json["maneuver"]),
        ref: json["ref"] == null ? null : json["ref"],
        destinations:
            json["destinations"] == null ? null : json["destinations"],
        rotaryName: json["rotary_name"] == null ? null : json["rotary_name"],
      );

  Map<String, dynamic> toJson() => {
        "intersections": intersections == null
            ? null
            : List<dynamic>.from(intersections!.map((x) => x.toJson())),
        "driving_side":
            drivingSide == null ? null : drivingSideValues.reverse[drivingSide],
        "geometry": geometry == null ? null : geometry,
        "duration": duration == null ? null : duration,
        "distance": distance == null ? null : distance,
        "name": name == null ? null : name,
        "weight": weight == null ? null : weight,
        "mode": mode == null ? null : modeValues.reverse[mode],
        "maneuver": maneuver == null ? null : maneuver!.toJson(),
        "ref": ref == null ? null : ref,
        "destinations": destinations == null ? null : destinations,
        "rotary_name": rotaryName == null ? null : rotaryName,
      };
}

enum DrivingSide {
  SLIGHT_LEFT,
  NONE,
  STRAIGHT,
  LEFT,
  SLIGHT_RIGHT,
  RIGHT,
  UTURN
}

final drivingSideValues = EnumValues({
  "left": DrivingSide.LEFT,
  "none": DrivingSide.NONE,
  "right": DrivingSide.RIGHT,
  "slight left": DrivingSide.SLIGHT_LEFT,
  "slight right": DrivingSide.SLIGHT_RIGHT,
  "straight": DrivingSide.STRAIGHT,
  "uturn": DrivingSide.UTURN
});

class Intersection {
  Intersection({
    this.out,
    this.entry,
    this.location,
    this.bearings,
    this.intersectionIn,
    this.classes,
    this.lanes,
  });

  final int? out;
  final List<bool>? entry;
  final List<double>? location;
  final List<int>? bearings;
  final int? intersectionIn;
  final List<Class>? classes;
  final List<Lane>? lanes;

  factory Intersection.fromRawJson(String str) =>
      Intersection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Intersection.fromJson(Map<String, dynamic> json) => Intersection(
        out: json["out"] == null ? null : json["out"],
        entry: json["entry"] == null
            ? null
            : List<bool>.from(json["entry"].map((x) => x)),
        location: json["location"] == null
            ? null
            : List<double>.from(json["location"].map((x) => x.toDouble())),
        bearings: json["bearings"] == null
            ? null
            : List<int>.from(json["bearings"].map((x) => x)),
        intersectionIn: json["in"] == null ? null : json["in"],
        classes: json["classes"] == null
            ? null
            : List<Class>.from(json["classes"].map((x) => classValues.map[x])),
        lanes: json["lanes"] == null
            ? null
            : List<Lane>.from(json["lanes"].map((x) => Lane.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "out": out == null ? null : out,
        "entry":
            entry == null ? null : List<dynamic>.from(entry!.map((x) => x)),
        "location": location == null
            ? null
            : List<dynamic>.from(location!.map((x) => x)),
        "bearings": bearings == null
            ? null
            : List<dynamic>.from(bearings!.map((x) => x)),
        "in": intersectionIn == null ? null : intersectionIn,
        "classes": classes == null
            ? null
            : List<dynamic>.from(classes!.map((x) => classValues.reverse[x])),
        "lanes": lanes == null
            ? null
            : List<dynamic>.from(lanes!.map((x) => x.toJson())),
      };
}

enum Class { MOTORWAY, TOLL, TUNNEL }

final classValues = EnumValues(
    {"motorway": Class.MOTORWAY, "toll": Class.TOLL, "tunnel": Class.TUNNEL});

class Lane {
  Lane({
    this.valid,
    this.indications,
  });

  final bool? valid;
  final List<DrivingSide>? indications;

  factory Lane.fromRawJson(String str) => Lane.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Lane.fromJson(Map<String, dynamic> json) => Lane(
        valid: json["valid"] == null ? null : json["valid"],
        indications: json["indications"] == null
            ? null
            : List<DrivingSide>.from(
                json["indications"].map((x) => drivingSideValues.map[x])),
      );

  Map<String, dynamic> toJson() => {
        "valid": valid == null ? null : valid,
        "indications": indications == null
            ? null
            : List<dynamic>.from(
                indications!.map((x) => drivingSideValues.reverse[x])),
      };
}

class Maneuver {
  Maneuver({
    this.bearingAfter,
    this.bearingBefore,
    this.type,
    this.location,
    this.modifier,
    this.exit,
  });

  final int? bearingAfter;
  final int? bearingBefore;
  final String? type;
  final List<double>? location;
  final DrivingSide? modifier;
  final int? exit;

  factory Maneuver.fromRawJson(String str) =>
      Maneuver.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Maneuver.fromJson(Map<String, dynamic> json) => Maneuver(
        bearingAfter:
            json["bearing_after"] == null ? null : json["bearing_after"],
        bearingBefore:
            json["bearing_before"] == null ? null : json["bearing_before"],
        type: json["type"] == null ? null : json["type"],
        location: json["location"] == null
            ? null
            : List<double>.from(json["location"].map((x) => x.toDouble())),
        modifier: json["modifier"] == null
            ? null
            : drivingSideValues.map[json["modifier"]],
        exit: json["exit"] == null ? null : json["exit"],
      );

  Map<String, dynamic> toJson() => {
        "bearing_after": bearingAfter == null ? null : bearingAfter,
        "bearing_before": bearingBefore == null ? null : bearingBefore,
        "type": type == null ? null : type,
        "location": location == null
            ? null
            : List<dynamic>.from(location!.map((x) => x)),
        "modifier":
            modifier == null ? null : drivingSideValues.reverse[modifier],
        "exit": exit == null ? null : exit,
      };
}

enum Mode { DRIVING, FERRY }

final modeValues = EnumValues({"driving": Mode.DRIVING, "ferry": Mode.FERRY});

class Waypoint {
  Waypoint({
    this.hint,
    this.distance,
    this.location,
    this.name,
  });

  final String? hint;
  final double? distance;
  final List<double>? location;
  final String? name;

  factory Waypoint.fromRawJson(String str) =>
      Waypoint.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
        hint: json["hint"] == null ? null : json["hint"],
        distance: json["distance"] == null ? null : json["distance"],
        location: json["location"] == null
            ? null
            : List<double>.from(json["location"].map((x) => x.toDouble())),
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "hint": hint == null ? null : hint,
        "distance": distance == null ? null : distance,
        "location": location == null
            ? null
            : List<dynamic>.from(location!.map((x) => x)),
        "name": name == null ? null : name,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
