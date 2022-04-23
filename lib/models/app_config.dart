class AppConfig {
  var userId = -1;
  var initialRoute = '';
  var homeIndex = 1;
  var lastUpdate = DateTime.fromMillisecondsSinceEpoch(0);

  AppConfig({userId, initialRoute, homeIndex, lastUpdate}){
    this.userId = userId ?? this.userId;
    this.initialRoute = initialRoute ?? this.initialRoute;
    this.homeIndex = homeIndex ?? this.homeIndex;
    this.lastUpdate = lastUpdate ?? this.lastUpdate;
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'initialRoute': initialRoute,
    'homeIndex': homeIndex,
    'lastUpdate': lastUpdate.millisecondsSinceEpoch,
  };

  AppConfig.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] ?? -1,
        initialRoute = json['initialRoute'] ?? '',
        homeIndex = json['homeIndex'] ?? 1,
        lastUpdate = DateTime.fromMillisecondsSinceEpoch(json['lastUpdate'] ?? 0)
  ;
}
