import 'package:json_annotation/json_annotation.dart';

class PouleStatusTypeConverter extends JsonConverter<bool, String> {
  const PouleStatusTypeConverter();

  @override
  bool fromJson(String json) {
    switch (json) {
      case 'ENDED':
        return true;
      case 'UPCOMING':
      case 'IN_PROGRESS':
      default:
        return false;
    }
  }

  @override
  String toJson(bool object) {
    return object ? 'ENDED' : 'UPCOMING';
  }
}
