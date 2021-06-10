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

void printWrapped(String text) {
  final pattern = new RegExp('.{1,1023}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
