import 'package:flutter_better_united/data/net/converters/date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ranked_participant_response.g.dart';

@JsonSerializable()
@DateTimeConverter()
class RankedParticipantResponse {
  final int rank;
  final int userId;
  final bool isLoggedUser;
  final String? profileIconUrl;
  final int pointsEarned;
  final String levelName;
  final String? nickname;

  factory RankedParticipantResponse.fromJson(Map<String, dynamic> json) =>
      _$RankedParticipantResponseFromJson(json);

  RankedParticipantResponse(this.rank, this.userId, this.isLoggedUser,
      this.profileIconUrl, this.pointsEarned, this.levelName, this.nickname);

  Map<String, dynamic> toJson() => _$RankedParticipantResponseToJson(this);
}
