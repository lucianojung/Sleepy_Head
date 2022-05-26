import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepy_head/services/user_reward_provider.dart';
import 'package:sleepy_head/theme_config.dart';

class RewardsHomeView extends StatefulWidget {
  RewardsHomeView({Key? key}) : super(key: key);

  @override
  _RewardsHomeViewState createState() => _RewardsHomeViewState();
}

class _RewardsHomeViewState extends State<RewardsHomeView> {

  @override
  Widget build(BuildContext context) {
    return Consumer<UserRewardProvider>(
      builder: (context, data, _) => ListView.builder(
        itemCount: data.userRewards.length,
        itemBuilder: (context, index) {
          var reward = data.userRewards[index].reward;
          var unlocked = data.userRewards[index].unlocked;
          return ListTile(
          title: Text(reward.name, style: listTileTextStyle(unlocked)),
          subtitle: Text(unlocked ? reward.rewardDescription : reward.unlockDescription, style: listTileTextStyle(unlocked)),
          leading: SizedBox(child: Image.asset(reward.imagePath, colorBlendMode: BlendMode.darken, color: unlocked ? Colors.white : Colors.black45,)),
          // onTap: (() => Provider.of<UserRewardProvider>(context, listen: false).addUnlockableReward(Reward(id: -1, name: data.userRewards[index].reward.name))),
          onTap: (() => Provider.of<UserRewardProvider>(context, listen: false).unlockUserReward(-1, reward.id, context)),
        );
        },
      ),
    );
  }

  TextStyle listTileTextStyle(bool unlocked) {
    return unlocked ?
        textStyle18:
        textStyle18.copyWith(color: Colors.grey);
  }
}
