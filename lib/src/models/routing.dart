// To parse this JSON data, do
//
//     final routingOutput = routingOutputFromJson(jsonString);

import 'dart:convert';

class RoutingOutput {
  RoutingOutput({
    this.code,
    this.waypoints,
    this.routes,
  });

  final String? code;
  final List<Waypoint>? waypoints;
  final List<Route>? routes;

  RoutingOutput copyWith({
    String? code,
    List<Waypoint>? waypoints,
    List<Route>? routes,
  }) =>
      RoutingOutput(
        code: code ?? this.code,
        waypoints: waypoints ?? this.waypoints,
        routes: routes ?? this.routes,
      );

  factory RoutingOutput.fromRawJson(String str) =>
      RoutingOutput.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoutingOutput.fromJson(Map<String, dynamic> json) => RoutingOutput(
        code: json["code"] == null ? null : json["code"],
        waypoints: json["waypoints"] == null
            ? null
            : List<Waypoint>.from(
                json["waypoints"]!.map((x) => Waypoint.fromJson(x))),
        routes: json["routes"] == null
            ? null
            : List<Route>.from(json["routes"]!.map((x) => Route.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "waypoints": waypoints == null
            ? null
            : List<dynamic>.from(waypoints!.map((x) => x.toJson())),
        "routes": routes == null
            ? null
            : List<dynamic>.from(routes!.map((x) => x.toJson())),
      };
}

class Route {
  Route({
    this.legs,
    this.weightName,
    this.geometry,
    this.weight,
    this.distance,
    this.duration,
  });

  final List<Leg>? legs;
  final String? weightName;
  final Geometry? geometry;
  final double? weight;
  final double? distance;
  final double? duration;

  Route copyWith({
    List<Leg>? legs,
    String? weightName,
    Geometry? geometry,
    double? weight,
    double? distance,
    double? duration,
  }) =>
      Route(
        legs: legs ?? this.legs,
        weightName: weightName ?? this.weightName,
        geometry: geometry ?? this.geometry,
        weight: weight ?? this.weight,
        distance: distance ?? this.distance,
        duration: duration ?? this.duration,
      );

  factory Route.fromRawJson(String str) => Route.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        legs: json["legs"] == null
            ? null
            : List<Leg>.from(json["legs"]!.map((x) => Leg.fromJson(x))),
        weightName: json["weight_name"] == null ? null : json["weight_name"],
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        weight: json["weight"] == null ? null : json["weight"].toDouble(),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        duration: json["duration"] == null ? null : json["duration"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "legs": legs == null
            ? null
            : List<dynamic>.from(legs!.map((x) => x.toJson())),
        "weight_name": weightName == null ? null : weightName,
        "geometry": geometry == null ? null : geometry!.toJson(),
        "weight": weight == null ? null : weight,
        "distance": distance == null ? null : distance,
        "duration": duration == null ? null : duration,
      };
}

class Geometry {
  Geometry({
    this.coordinates,
    this.type,
  });

  final List<List<double>>? coordinates;
  final Type? type;

  Geometry copyWith({
    List<List<double>>? coordinates,
    Type? type,
  }) =>
      Geometry(
        coordinates: coordinates ?? this.coordinates,
        type: type ?? this.type,
      );

  factory Geometry.fromRawJson(String str) =>
      Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: json["coordinates"] == null
            ? null
            : List<List<double>>.from(json["coordinates"]!
                .map((x) => List<double>.from(x!.map((x) => x.toDouble())))),
        type: json["type"] == null ? null : typeValues.map![json["type"]],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(
                coordinates!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "type": type == null ? null : typeValues.reverse![type],
      };
}

enum Type { LINE_STRING }

final typeValues = EnumValues({"LineString": Type.LINE_STRING});

class Leg {
  Leg({
    this.steps,
    this.weight,
    this.distance,
    this.annotation,
    this.summary,
    this.duration,
  });

  final List<Step>? steps;
  final double? weight;
  final double? distance;
  final Annotation? annotation;
  final String? summary;
  final double? duration;

  Leg copyWith({
    List<Step>? steps,
    double? weight,
    double? distance,
    Annotation? annotation,
    String? summary,
    double? duration,
  }) =>
      Leg(
        steps: steps ?? this.steps,
        weight: weight ?? this.weight,
        distance: distance ?? this.distance,
        annotation: annotation ?? this.annotation,
        summary: summary ?? this.summary,
        duration: duration ?? this.duration,
      );

  factory Leg.fromRawJson(String str) => Leg.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        steps: json["steps"] == null
            ? null
            : List<Step>.from(json["steps"]!.map((x) => Step.fromJson(x))),
        weight: json["weight"] == null ? null : json["weight"].toDouble(),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        annotation: json["annotation"] == null
            ? null
            : Annotation.fromJson(json["annotation"]),
        summary: json["summary"] == null ? null : json["summary"],
        duration: json["duration"] == null ? null : json["duration"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "steps": steps == null
            ? null
            : List<dynamic>.from(steps!.map((x) => x.toJson())),
        "weight": weight == null ? null : weight,
        "distance": distance == null ? null : distance,
        "annotation": annotation == null ? null : annotation!.toJson(),
        "summary": summary == null ? null : summary,
        "duration": duration == null ? null : duration,
      };
}

class Annotation {
  Annotation({
    this.speed,
    this.metadata,
    this.nodes,
    this.duration,
    this.distance,
    this.weight,
    this.datasources,
  });

  final List<double>? speed;
  final Metadata? metadata;
  final List<int>? nodes;
  final List<double>? duration;
  final List<double>? distance;
  final List<double>? weight;
  final List<int>? datasources;

  Annotation copyWith({
    List<double>? speed,
    Metadata? metadata,
    List<int>? nodes,
    List<double>? duration,
    List<double>? distance,
    List<double>? weight,
    List<int>? datasources,
  }) =>
      Annotation(
        speed: speed ?? this.speed,
        metadata: metadata ?? this.metadata,
        nodes: nodes ?? this.nodes,
        duration: duration ?? this.duration,
        distance: distance ?? this.distance,
        weight: weight ?? this.weight,
        datasources: datasources ?? this.datasources,
      );

  factory Annotation.fromRawJson(String str) =>
      Annotation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Annotation.fromJson(Map<String, dynamic> json) => Annotation(
        speed: json["speed"] == null
            ? null
            : List<double>.from(json["speed"]!.map((x) => x.toDouble())),
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
        nodes: json["nodes"] == null
            ? null
            : List<int>.from(json["nodes"]!.map((x) => x)),
        duration: json["duration"] == null
            ? null
            : List<double>.from(json["duration"]!.map((x) => x.toDouble())),
        distance: json["distance"] == null
            ? null
            : List<double>.from(json["distance"]!.map((x) => x.toDouble())),
        weight: json["weight"] == null
            ? null
            : List<double>.from(json["weight"]!.map((x) => x.toDouble())),
        datasources: json["datasources"] == null
            ? null
            : List<int>.from(json["datasources"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "speed":
            speed == null ? null : List<dynamic>.from(speed!.map((x) => x)),
        "metadata": metadata == null ? null : metadata!.toJson(),
        "nodes":
            nodes == null ? null : List<dynamic>.from(nodes!.map((x) => x)),
        "duration": duration == null
            ? null
            : List<dynamic>.from(duration!.map((x) => x)),
        "distance": distance == null
            ? null
            : List<dynamic>.from(distance!.map((x) => x)),
        "weight":
            weight == null ? null : List<dynamic>.from(weight!.map((x) => x)),
        "datasources": datasources == null
            ? null
            : List<dynamic>.from(datasources!.map((x) => x)),
      };
}

class Metadata {
  Metadata({
    this.datasourceNames,
  });

  final List<String>? datasourceNames;

  Metadata copyWith({
    List<String>? datasourceNames,
  }) =>
      Metadata(
        datasourceNames: datasourceNames ?? this.datasourceNames,
      );

  factory Metadata.fromRawJson(String str) =>
      Metadata.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        datasourceNames: json["datasource_names"] == null
            ? null
            : List<String>.from(json["datasource_names"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "datasource_names": datasourceNames == null
            ? null
            : List<dynamic>.from(datasourceNames!.map((x) => x)),
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
    this.stepIntersections,
    this.stepDrivingSide,
    this.stepGeometry,
    this.stepDuration,
    this.stepDistance,
    this.stepName,
    this.stepWeight,
    this.stepMode,
    this.stepManeuver,
    this.stepRef,
    this.ref,
  });

  final List<Intersection>? intersections;
  final DrivingSide? drivingSide;
  final Geometry? geometry;
  final double? duration;
  final double? distance;
  final String? name;
  final double? weight;
  final Mode? mode;
  final Maneuver? maneuver;
  final List<Intersections>? stepIntersections;
  final String? stepDrivingSide;
  final GeometryClass? stepGeometry;
  final double? stepDuration;
  final double? stepDistance;
  final String? stepName;
  final double? stepWeight;
  final String? stepMode;
  final ManeuverClass? stepManeuver;
  final String? stepRef;
  final String? ref;

  Step copyWith({
    List<Intersection>? intersections,
    DrivingSide? drivingSide,
    Geometry? geometry,
    double? duration,
    double? distance,
    String? name,
    double? weight,
    Mode? mode,
    Maneuver? maneuver,
    List<Intersections>? stepIntersections,
    String? stepDrivingSide,
    GeometryClass? stepGeometry,
    double? stepDuration,
    double? stepDistance,
    String? stepName,
    double? stepWeight,
    String? stepMode,
    ManeuverClass? stepManeuver,
    String? stepRef,
    String? ref,
  }) =>
      Step(
        intersections: intersections ?? this.intersections,
        drivingSide: drivingSide ?? this.drivingSide,
        geometry: geometry ?? this.geometry,
        duration: duration ?? this.duration,
        distance: distance ?? this.distance,
        name: name ?? this.name,
        weight: weight ?? this.weight,
        mode: mode ?? this.mode,
        maneuver: maneuver ?? this.maneuver,
        stepIntersections: stepIntersections ?? this.stepIntersections,
        stepDrivingSide: stepDrivingSide ?? this.stepDrivingSide,
        stepGeometry: stepGeometry ?? this.stepGeometry,
        stepDuration: stepDuration ?? this.stepDuration,
        stepDistance: stepDistance ?? this.stepDistance,
        stepName: stepName ?? this.stepName,
        stepWeight: stepWeight ?? this.stepWeight,
        stepMode: stepMode ?? this.stepMode,
        stepManeuver: stepManeuver ?? this.stepManeuver,
        stepRef: stepRef ?? this.stepRef,
        ref: ref ?? this.ref,
      );

  factory Step.fromRawJson(String str) => Step.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        intersections: json["intersections"] == null
            ? null
            : List<Intersection>.from(
                json["intersections"]!.map((x) => Intersection.fromJson(x))),
        drivingSide: json["driving_side"] == null
            ? null
            : drivingSideValues.map![json["driving_side"]],
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        duration: json["duration"] == null ? null : json["duration"].toDouble(),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        name: json["name"] == null ? null : json["name"],
        weight: json["weight"] == null ? null : json["weight"].toDouble(),
        mode: json["mode"] == null ? null : modeValues.map![json["mode"]],
        maneuver: json["maneuver"] == null
            ? null
            : Maneuver.fromJson(json["maneuver"]),
        stepIntersections: json["intersections "] == null
            ? null
            : List<Intersections>.from(
                json["intersections "]!.map((x) => Intersections.fromJson(x))),
        stepDrivingSide:
            json["driving_side "] == null ? null : json["driving_side "],
        stepGeometry: json["geometry "] == null
            ? null
            : GeometryClass.fromJson(json["geometry "]),
        stepDuration:
            json["duration "] == null ? null : json["duration "].toDouble(),
        stepDistance:
            json["distance "] == null ? null : json["distance "].toDouble(),
        stepName: json["name "] == null ? null : json["name "],
        stepWeight: json["weight "] == null ? null : json["weight "].toDouble(),
        stepMode: json["mode "] == null ? null : json["mode "],
        stepManeuver: json["maneuver "] == null
            ? null
            : ManeuverClass.fromJson(json["maneuver "]),
        stepRef: json["ref "] == null ? null : json["ref "],
        ref: json["ref"] == null ? null : json["ref"],
      );

  Map<String, dynamic> toJson() => {
        "intersections": intersections == null
            ? null
            : List<dynamic>.from(intersections!.map((x) => x.toJson())),
        "driving_side": drivingSide == null
            ? null
            : drivingSideValues.reverse![drivingSide],
        "geometry": geometry == null ? null : geometry!.toJson(),
        "duration": duration == null ? null : duration,
        "distance": distance == null ? null : distance,
        "name": name == null ? null : name,
        "weight": weight == null ? null : weight,
        "mode": mode == null ? null : modeValues.reverse![mode],
        "maneuver": maneuver == null ? null : maneuver!.toJson(),
        "intersections ": stepIntersections == null
            ? null
            : List<dynamic>.from(stepIntersections!.map((x) => x.toJson())),
        "driving_side ": stepDrivingSide == null ? null : stepDrivingSide,
        "geometry ": stepGeometry == null ? null : stepGeometry!.toJson(),
        "duration ": stepDuration == null ? null : stepDuration,
        "distance ": stepDistance == null ? null : stepDistance,
        "name ": stepName == null ? null : stepName,
        "weight ": stepWeight == null ? null : stepWeight,
        "mode ": stepMode == null ? null : stepMode,
        "maneuver ": stepManeuver == null ? null : stepManeuver!.toJson(),
        "ref ": stepRef == null ? null : stepRef,
        "ref": ref == null ? null : ref,
      };
}

enum DrivingSide { RIGHT, LEFT }

final drivingSideValues =
    EnumValues({"left": DrivingSide.LEFT, "right": DrivingSide.RIGHT});

class Intersection {
  Intersection({
    this.out,
    this.entry,
    this.location,
    this.bearings,
    this.intersectionIn,
  });

  final int? out;
  final List<bool>? entry;
  final List<double>? location;
  final List<int>? bearings;
  final int? intersectionIn;

  Intersection copyWith({
    int? out,
    List<bool>? entry,
    List<double>? location,
    List<int>? bearings,
    int? intersectionIn,
  }) =>
      Intersection(
        out: out ?? this.out,
        entry: entry ?? this.entry,
        location: location ?? this.location,
        bearings: bearings ?? this.bearings,
        intersectionIn: intersectionIn ?? this.intersectionIn,
      );

  factory Intersection.fromRawJson(String str) =>
      Intersection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Intersection.fromJson(Map<String, dynamic> json) => Intersection(
        out: json["out"] == null ? null : json["out"],
        entry: json["entry"] == null
            ? null
            : List<bool>.from(json["entry"]!.map((x) => x)),
        location: json["location"] == null
            ? null
            : List<double>.from(json["location"]!.map((x) => x.toDouble())),
        bearings: json["bearings"] == null
            ? null
            : List<int>.from(json["bearings"]!.map((x) => x)),
        intersectionIn: json["in"] == null ? null : json["in"],
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
      };
}

class Maneuver {
  Maneuver({
    this.bearingAfter,
    this.location,
    this.type,
    this.maneuverBearingBefore,
    this.maneuverModifier,
    this.bearingBefore,
    this.modifier,
  });

  final int? bearingAfter;
  final List<double>? location;
  final String? type;
  final int? maneuverBearingBefore;
  final String? maneuverModifier;
  final int? bearingBefore;
  final DrivingSide? modifier;

  Maneuver copyWith({
    int? bearingAfter,
    List<double>? location,
    String? type,
    int? maneuverBearingBefore,
    String? maneuverModifier,
    int? bearingBefore,
    DrivingSide? modifier,
  }) =>
      Maneuver(
        bearingAfter: bearingAfter ?? this.bearingAfter,
        location: location ?? this.location,
        type: type ?? this.type,
        maneuverBearingBefore:
            maneuverBearingBefore ?? this.maneuverBearingBefore,
        maneuverModifier: maneuverModifier ?? this.maneuverModifier,
        bearingBefore: bearingBefore ?? this.bearingBefore,
        modifier: modifier ?? this.modifier,
      );

  factory Maneuver.fromRawJson(String str) =>
      Maneuver.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Maneuver.fromJson(Map<String, dynamic> json) => Maneuver(
        bearingAfter:
            json["bearing_after"] == null ? null : json["bearing_after"],
        location: json["location"] == null
            ? null
            : List<double>.from(json["location"]!.map((x) => x.toDouble())),
        type: json["type"] == null ? null : json["type"],
        maneuverBearingBefore:
            json["bearing_before "] == null ? null : json["bearing_before "],
        maneuverModifier: json["modifier "] == null ? null : json["modifier "],
        bearingBefore:
            json["bearing_before"] == null ? null : json["bearing_before"],
        modifier: json["modifier"] == null
            ? null
            : drivingSideValues.map![json["modifier"]],
      );

  Map<String, dynamic> toJson() => {
        "bearing_after": bearingAfter == null ? null : bearingAfter,
        "location": location == null
            ? null
            : List<dynamic>.from(location!.map((x) => x)),
        "type": type == null ? null : type,
        "bearing_before ":
            maneuverBearingBefore == null ? null : maneuverBearingBefore,
        "modifier ": maneuverModifier == null ? null : maneuverModifier,
        "bearing_before": bearingBefore == null ? null : bearingBefore,
        "modifier":
            modifier == null ? null : drivingSideValues.reverse![modifier],
      };
}

enum Mode { DRIVING }

final modeValues = EnumValues({"driving": Mode.DRIVING});

class GeometryClass {
  GeometryClass({
    this.coordinates,
    this.geometryType,
    this.type,
  });

  final List<List<double>>? coordinates;
  final String? geometryType;
  final Type? type;

  GeometryClass copyWith({
    List<List<double>>? coordinates,
    String? geometryType,
    Type? type,
  }) =>
      GeometryClass(
        coordinates: coordinates ?? this.coordinates,
        geometryType: geometryType ?? this.geometryType,
        type: type ?? this.type,
      );

  factory GeometryClass.fromRawJson(String str) =>
      GeometryClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeometryClass.fromJson(Map<String, dynamic> json) => GeometryClass(
        coordinates: json["coordinates "] == null
            ? null
            : List<List<double>>.from(json["coordinates "]!
                .map((x) => List<double>.from(x!.map((x) => x.toDouble())))),
        geometryType: json["type "] == null ? null : json["type "],
        type: json["type"] == null ? null : typeValues.map![json["type"]],
      );

  Map<String, dynamic> toJson() => {
        "coordinates ": coordinates == null
            ? null
            : List<dynamic>.from(
                coordinates!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "type ": geometryType == null ? null : geometryType,
        "type": type == null ? null : typeValues.reverse![type],
      };
}

class Intersections {
  Intersections({
    this.out,
    this.intersectionsIn,
    this.entry,
    this.location,
    this.bearings,
  });

  final int? out;
  final int? intersectionsIn;
  final List<bool>? entry;
  final List<double>? location;
  final List<int>? bearings;

  Intersections copyWith({
    int? out,
    int? intersectionsIn,
    List<bool>? entry,
    List<double>? location,
    List<int>? bearings,
  }) =>
      Intersections(
        out: out ?? this.out,
        intersectionsIn: intersectionsIn ?? this.intersectionsIn,
        entry: entry ?? this.entry,
        location: location ?? this.location,
        bearings: bearings ?? this.bearings,
      );

  factory Intersections.fromRawJson(String str) =>
      Intersections.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Intersections.fromJson(Map<String, dynamic> json) => Intersections(
        out: json["out "] == null ? null : json["out "],
        intersectionsIn: json[" in "] == null ? null : json[" in "],
        entry: json["entry "] == null
            ? null
            : List<bool>.from(json["entry "]!.map((x) => x)),
        location: json["location "] == null
            ? null
            : List<double>.from(json["location "]!.map((x) => x.toDouble())),
        bearings: json["bearings "] == null
            ? null
            : List<int>.from(json["bearings "]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "out ": out == null ? null : out,
        " in ": intersectionsIn == null ? null : intersectionsIn,
        "entry ":
            entry == null ? null : List<dynamic>.from(entry!.map((x) => x)),
        "location ": location == null
            ? null
            : List<dynamic>.from(location!.map((x) => x)),
        "bearings ": bearings == null
            ? null
            : List<dynamic>.from(bearings!.map((x) => x)),
      };
}

class ManeuverClass {
  ManeuverClass({
    this.bearingAfter,
    this.location,
    this.type,
    this.bearingBefore,
    this.modifier,
  });

  final int? bearingAfter;
  final List<double>? location;
  final String? type;
  final int? bearingBefore;
  final String? modifier;

  ManeuverClass copyWith({
    int? bearingAfter,
    List<double>? location,
    String? type,
    int? bearingBefore,
    String? modifier,
  }) =>
      ManeuverClass(
        bearingAfter: bearingAfter ?? this.bearingAfter,
        location: location ?? this.location,
        type: type ?? this.type,
        bearingBefore: bearingBefore ?? this.bearingBefore,
        modifier: modifier ?? this.modifier,
      );

  factory ManeuverClass.fromRawJson(String str) =>
      ManeuverClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ManeuverClass.fromJson(Map<String, dynamic> json) => ManeuverClass(
        bearingAfter:
            json["bearing_after "] == null ? null : json["bearing_after "],
        location: json["location "] == null
            ? null
            : List<double>.from(json["location "]!.map((x) => x.toDouble())),
        type: json["type "] == null ? null : json["type "],
        bearingBefore:
            json["bearing_before "] == null ? null : json["bearing_before "],
        modifier: json["modifier "] == null ? null : json["modifier "],
      );

  Map<String, dynamic> toJson() => {
        "bearing_after ": bearingAfter == null ? null : bearingAfter,
        "location ": location == null
            ? null
            : List<dynamic>.from(location!.map((x) => x)),
        "type ": type == null ? null : type,
        "bearing_before ": bearingBefore == null ? null : bearingBefore,
        "modifier ": modifier == null ? null : modifier,
      };
}

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

  Waypoint copyWith({
    String? hint,
    double? distance,
    List<double>? location,
    String? name,
  }) =>
      Waypoint(
        hint: hint ?? this.hint,
        distance: distance ?? this.distance,
        location: location ?? this.location,
        name: name ?? this.name,
      );

  factory Waypoint.fromRawJson(String str) =>
      Waypoint.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
        hint: json["hint"] == null ? null : json["hint"],
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        location: json["location"] == null
            ? null
            : List<double>.from(json["location"]!.map((x) => x.toDouble())),
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
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
