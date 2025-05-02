import 'dart:typed_data';

import 'package:flutter_better_united/data/net/models/coach_tip_response.dart';

class CoachTip {
  final int id;
  final String text;
  final int announceAfterMinutes;
  final DateTime expiresAt;
  final String imageUrl;
  Uint8List? image;
  bool isDismissed = false;

  CoachTip(this.id, this.text, this.announceAfterMinutes, this.expiresAt,
      this.imageUrl);

  CoachTip.fromCoachTipResponse(CoachTipResponse coachTipResponse)
      : this(
            coachTipResponse.id,
            coachTipResponse.text,
            coachTipResponse.announceAfterMinutes,
            coachTipResponse.expiresAt,
            coachTipResponse.imageUrl);
}
