import 'package:meta/meta.dart';

import 'enums.dart';

@internal
extension OSRMProfileExts on OSRMProfile {
  String get profile {
    return this.toString().split('OSRMProfile.')[1];
  }
}
