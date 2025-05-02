import 'package:flutter_better_united/data/model/football_match.dart';

class GroupedMatches {
  final DateTime date;
  final List<FootballMatch> footballMatches;

  GroupedMatches(this.date, this.footballMatches);
}
