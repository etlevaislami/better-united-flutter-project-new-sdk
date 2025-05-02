import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_better_united/data/net/models/power_up_response.dart';

import '../../constants/app_colors.dart';
import '../net/models/power_up_info_response.dart';

const int experienceType = 1;
const int quotationType = 2;

class PowerUp {
  final int id;
  final int powerUpTypeId;
  final String name;
  final int price;
  final String iconUrl;
  final double multiplier;
  final String description;
  int powerUpCount;

  PowerUp(this.id, this.powerUpTypeId, this.name, this.price, this.iconUrl,
      this.multiplier, this.description, this.powerUpCount);

  PowerUp.fromPowerUpResponse(PowerUpResponse powerUpResponse)
      : this(
            powerUpResponse.id,
            powerUpResponse.powerupTypeId,
            powerUpResponse.name,
            powerUpResponse.price,
            powerUpResponse.iconUrl,
            powerUpResponse.multiplier,
            powerUpResponse.description,
            powerUpResponse.powerupCount);

  PowerUp.fromPowerUpInfoResponse(PowerUpInfoResponse powerUpResponse)
      : this(
            -1,
            powerUpResponse.powerupTypeId,
            powerUpResponse.powerupName,
            0,
            powerUpResponse.powerupIconUrl,
            powerUpResponse.powerupMultiplier,
            "",
            0);

  String get powerUpName {
    if (powerUpTypeId == experienceType) {
      return "expMultiplier".tr();
    }

    if (powerUpTypeId == quotationType) {
      return "quotationMultiplier".tr();
    }

    return "";
  }

  Color get powerUpColor {
    if (powerUpTypeId == experienceType) {
      return AppColors.solidGold;
    }

    if (powerUpTypeId == quotationType) {
      return AppColors.monaLisa;
    }

    return AppColors.forgedSteel;
  }
}
