class Routes {
  Routes._();
  static const home = (path: '/home', name: 'home');
  static const auth = (path: '/auth', name: 'auth');
  static const splash = (path: '/splash', name: 'splash');
  static const settings = (path: '/settings', name: 'settings');
  static const fixtures = (path: '/fixtures', name: 'fixtures');
  static const standings = (path: '/standings', name: 'standings');
  static const fixtureDetails = (
    path: '/fixture-details',
    name: 'fixture_details',
  );

  static int currentIndex(String location) {
    return switch (location) {
      '/fixtures' => 1,
      '/standings' => 2,
      '/settings' => 3,
      _ => 0,
    };
  }
}
