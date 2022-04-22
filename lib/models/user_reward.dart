import 'package:sleepy_head/models/reward.dart';
import 'package:sleepy_head/models/user_data.dart';

class UserReward {
  UserData user = UserData();
  Reward reward = Reward();
  bool unlocked = false;

  UserReward({user, reward, unlocked}){
    this.user = user ?? this.user;
    this.reward = reward ?? this.reward;
    this.unlocked = unlocked ?? this.unlocked;
  }

  Map<String, dynamic> toJson() => {
    'user': user.toJson(),
    'reward': reward.toJson(),
    'unlocked': unlocked,
  };

  UserReward.fromJson(Map<String, dynamic> json)
      : user = UserData.fromJson(json['user'] ?? '{}'),
        reward = Reward.fromJson(json['reward'] ?? '{}'),
        unlocked = json['unlocked'] ?? false
  ;
}
