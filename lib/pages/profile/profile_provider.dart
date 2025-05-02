import 'package:flutter/material.dart';
import 'package:flutter_better_united/data/repo/profile_repository.dart';

import '../../data/model/user.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileRepository _profileRepository;
  final int userId;
  User? user;

  ProfileProvider(this._profileRepository, this.userId);

  fetchProfile() async {
    user = await _profileRepository.getOtherProfile(userId);
    notifyListeners();
  }

  toggleFollowUser() {
    final user = this.user;
    if (user == null) {
      return;
    }
    if (user.isFollowingAuthor) {
      _profileRepository.unfollowUser(userId);
      user.isFollowingAuthor = false;
    } else {
      _profileRepository.followUser(userId);
      user.isFollowingAuthor = true;
    }
    notifyListeners();
  }
}
