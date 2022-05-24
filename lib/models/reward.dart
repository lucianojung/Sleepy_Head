class Reward {
  var id = -1;
  var name = 'Default';
  var rewardDescription = '';
  String imagePath = 'assets/images/day-night.png';
  var unlockDescription = '';

  Reward({id, name, rewardDescription, imagePath, unlockDescription}) {
    this.id = id ?? this.id;
    this.name = name ?? this.name;
    this.rewardDescription = rewardDescription ?? this.rewardDescription;
    this.imagePath = imagePath ?? this.imagePath;
    this.unlockDescription = unlockDescription ?? this.unlockDescription;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'rewardDescription': rewardDescription,
        'imagePath': imagePath,
        'unlockDescription': unlockDescription,
      };

  Reward.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? -1,
        name = json['name'] ?? '',
        rewardDescription = json['rewardDescription'] ?? '',
        imagePath = json['imagePath'],
        unlockDescription = json['unlockDescription'] ?? '';
}

List<Reward> rewards = [
  Reward(
    id: 4,
    name: 'Newbie',
    unlockDescription: 'Enter your sleep data for the first time.',
    rewardDescription: 'You entered your sleep data for the first time.',
  ),
  Reward(
    id: 1,
    name: 'Be one with the App',
    unlockDescription: 'You have to use the app your whole life',
    rewardDescription: 'You love the app!',
  ),
  Reward(
    id: 2,
    name: 'Be who you are',
    unlockDescription: 'Be who you are!',
    rewardDescription: 'You did it!',
  ),
];

Reward getRewardByName(String name) {
  return rewards.firstWhere((element) => element.name.toLowerCase().contains(name.toLowerCase()));
}
