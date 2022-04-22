import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleepy_head/models/user_data.dart';
import 'package:sleepy_head/models/user_reward.dart';
import 'package:sleepy_head/models/reward.dart';

import 'dart:convert';

class UserRewardProvider extends ChangeNotifier {
  List<UserReward> _userRewards = [];
  List<Reward> _rewards = [
    Reward(
        id: 0,
        name: 'Open the App',
        rewardDescription: 'You managed to open the app'),
    Reward(
        id: 1,
        name: 'Be one with the App',
        unlockDescription: 'You have to use the app your whole life'),
    Reward(
        id: 2,
        name: 'Be who you are',
        unlockDescription: 'Be who you are!'),
  ];

  List<UserReward> get userRewards => _userRewards;

  UserRewardProvider() {
    initialState();
  }

  void initialState() {
    syncDataWithProvider();
  }

  // additional getters

  // CRUD Methods for local Variables

  void unlockUserReward(int userId, int rewardId) {
    _userRewards
        .firstWhere((element) =>
            element.user.id == userId && element.reward.id == rewardId)
        .unlocked = true;

    updateSharedPrefrences();
    notifyListeners();
  }

  void lockUserReward(int userId, int rewardId) {
    _userRewards
        .firstWhere((element) =>
            element.user.id == userId && element.reward.id == rewardId)
        .unlocked = false;

    updateSharedPrefrences();
    notifyListeners();
  }

  void addUnlockableReward(Reward reward, {UserData? user}) {
    _userRewards.add(
      UserReward(user: user ?? UserData(), reward: reward, unlocked: false),
    );

    updateSharedPrefrences();
    notifyListeners();
  }

  void removeRewardById(int rewardId) {
    _userRewards.removeWhere((element) => element.reward.id == rewardId);

    updateSharedPrefrences();
    notifyListeners();
  }

  // shared preference Methods

  void updateSharedPrefrences() async {
    List<String> userRewardStringList =
        List<String>.from(_userRewards.map((x) => json.encode(x.toJson())));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('userRewards', userRewardStringList);
    notifyListeners();
  }

  Future syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('userRewards');

    if (result != null) {
      _userRewards = List<UserReward>.from(
          result.map((x) => UserReward.fromJson(json.decode(x))));
    }
    for (var reward in _rewards) {
      Reward correspondingReward = _userRewards.firstWhere((userReward) => userReward.reward.id == reward.id, orElse: () => UserReward()).reward;
      if (correspondingReward.id == -1) {
        addUnlockableReward(reward);
        print('add unlockable Reward ${reward.name}');
      }
    }
    notifyListeners();
  }
}
