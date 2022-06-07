class GlobalVariables {
  static final GlobalVariables _instance = GlobalVariables._internal();

  factory GlobalVariables() => _instance;

  GlobalVariables._internal();

  // static variables

  String get appTitle => 'Sleepy Head';
  String get version => '1.0.0';
  String get buildWellBeingURL => 'https://buildwellbeing.fhstp.ac.at/';

  // initial values

  String get initialRoute => '/intro';
  String get nightRoute => '/night';
  String get homeRoute => '/';
  int get initialHomePageIndex => 0;
}
