class AppConfig {
  var userId = -1;
  var homeIndex = 0;
  var lastUpdate = DateTime.fromMillisecondsSinceEpoch(0);

  AppConfig({userId, initialRoute, homeIndex, lastUpdate}){
    this.userId = userId ?? this.userId;
    this.homeIndex = homeIndex ?? this.homeIndex;
    this.lastUpdate = lastUpdate ?? this.lastUpdate;
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'homeIndex': homeIndex,
    'lastUpdate': lastUpdate.millisecondsSinceEpoch,
  };

  AppConfig.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] ?? -1,
        homeIndex = json['homeIndex'] ?? 1,
        lastUpdate = DateTime.fromMillisecondsSinceEpoch(json['lastUpdate'] ?? 0)
  ;
}
