import 'package:flutter_better_united/data/model/filter_criteria.dart';

import 'league.dart';

class FilterData {
  final FilterCriteria filterCriteria;
  final List<League> leagues;

  FilterData(this.filterCriteria, this.leagues);
}
