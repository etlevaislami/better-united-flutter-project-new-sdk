import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'verify_purchase_request.g.dart';

String _getPlatform() {
  if (Platform.isAndroid) {
    return "android";
  } else if (Platform.isIOS) {
    return "ios";
  }
  return "";
}

@JsonSerializable()
class VerifyPurchaseRequest {
  String platform = _getPlatform();
  final String productId;
  final String receipt;

  factory VerifyPurchaseRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyPurchaseRequestFromJson(json);

  VerifyPurchaseRequest(this.productId, this.receipt);

  Map<String, dynamic> toJson() => _$VerifyPurchaseRequestToJson(this);
}
