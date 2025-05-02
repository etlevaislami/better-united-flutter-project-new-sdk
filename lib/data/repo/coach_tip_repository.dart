import 'package:flutter_better_united/data/model/coach_tip.dart';

import '../net/api_service.dart';

class CoachTipRepository {
  final ApiService _apiService;

  CoachTipRepository(this._apiService);

  Future<List<CoachTip>> getCoachTips() async {
    var coachTips = await _apiService.getCoachTip();
    return coachTips.map((e) => CoachTip.fromCoachTipResponse(e)).toList();
  }
}
