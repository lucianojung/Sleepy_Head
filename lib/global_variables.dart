class GlobalVariables {
  static final GlobalVariables _instance = GlobalVariables._internal();

  factory GlobalVariables() => _instance;

  GlobalVariables._internal();

  // static variables

  String get appTitle => 'Sleepy Head';
  String get version => '1.0.0';

  // initial values

  String get initialRoute => '/intro';
  int get initialHomePageIndex => 1;
}
