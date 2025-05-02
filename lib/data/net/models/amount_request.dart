import 'package:json_annotation/json_annotation.dart';

part 'amount_request.g.dart';

@JsonSerializable()
class AmountRequest {
  final int amount;

  AmountRequest(this.amount);

  factory AmountRequest.fromJson(Map<String, dynamic> json) =>
      _$AmountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AmountRequestToJson(this);
}
