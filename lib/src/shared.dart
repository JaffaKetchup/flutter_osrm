enum Profile {
  car,
  bike,
  foot,
}

enum Service {
  nearest,
  routing,
}

class OSRMError implements Exception {
  final Service service;
  final String code;
  final String message;
  OSRMError(this.service, this.code, this.message);
}
