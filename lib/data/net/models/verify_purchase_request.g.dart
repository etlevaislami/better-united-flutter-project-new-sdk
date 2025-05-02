// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_purchase_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyPurchaseRequest _$VerifyPurchaseRequestFromJson(
        Map<String, dynamic> json) =>
    VerifyPurchaseRequest(
      json['productId'] as String,
      json['receipt'] as String,
    )..platform = json['platform'] as String;

Map<String, dynamic> _$VerifyPurchaseRequestToJson(
        VerifyPurchaseRequest instance) =>
    <String, dynamic>{
      'platform': instance.platform,
      'productId': instance.productId,
      'receipt': instance.receipt,
    };
