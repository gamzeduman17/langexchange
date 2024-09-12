import 'package:uuid/uuid.dart';

class UuidHelper {
  static final Uuid _uuid = Uuid();//general string Guid
  static String generateUuid() {
    return _uuid.v4();
  }
}
