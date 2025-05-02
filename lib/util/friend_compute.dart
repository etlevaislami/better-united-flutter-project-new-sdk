import 'package:tuple/tuple.dart';

import '../data/model/friend.dart';

List<Friend> filterFriends(Tuple2<String, List<Friend>> data) {
  final String criteria = data.item1.toLowerCase();
  final List<Friend> matches = data.item2;
  return matches
      .where((f) => f.nickname.toLowerCase().contains(criteria))
      .toList();
}
