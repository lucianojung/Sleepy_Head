import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:sleepy_head/services/user_reward_provider.dart';

class RewardsHomeView extends StatefulWidget {
  RewardsHomeView({Key? key}) : super(key: key);

  @override
  _RewardsHomeViewState createState() => _RewardsHomeViewState();
}

class _RewardsHomeViewState extends State<RewardsHomeView> {
  SMITrigger? _greet;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'Sam_State_Greeting');
    artboard.addController(controller!);
    _greet = controller.findInput<bool>('greeting trigger') as SMITrigger;
  }

  void _hitGreet() => _greet?.fire();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hitGreet,
      child: Stack(
        children: [
          RiveAnimation.asset(
            'assets/Sam_Lit.riv',
            artboard: 'Sam Greeting',
            stateMachines: ['Sam_State_Greeting'],
            alignment: Alignment.topRight,
            fit: BoxFit.fitHeight,
            onInit: _onRiveInit,
          ),
          Consumer<UserRewardProvider>(
            builder: (context, data, _) => ListView.builder(
              itemCount: data.userRewards.length,
              itemBuilder: (context, index) {
                var reward = data.userRewards[index].reward;
                var unlocked = data.userRewards[index].unlocked;
                return ListTile(
                title: Text(reward.name, style: listTileTextStyle(unlocked)),
                subtitle: Text(reward.unlockDescription, style: listTileTextStyle(unlocked)),
                leading: SizedBox(child: Image.asset(reward.imagePath, colorBlendMode: BlendMode.darken, color: unlocked ? Colors.white : Colors.black45,)),
                // onTap: (() => Provider.of<UserRewardProvider>(context, listen: false).addUnlockableReward(Reward(id: -1, name: data.userRewards[index].reward.name))),
                onTap: (() => Provider.of<UserRewardProvider>(context, listen: false).unlockUserReward(-1, reward.id, context)),
              );
              },
            ),
          ),
        ],
      ),
    );
  }

  TextStyle listTileTextStyle(bool unlocked) {
    return unlocked ?
        TextStyle(color: Colors.black) :
        TextStyle(color: Colors.grey);
  }
}
