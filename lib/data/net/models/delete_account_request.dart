import 'package:json_annotation/json_annotation.dart';

part 'delete_account_request.g.dart';

@JsonSerializable()
class DeleteAccountRequest {
  final String password;

  DeleteAccountRequest(this.password);

  factory DeleteAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteAccountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteAccountRequestToJson(this);
}
