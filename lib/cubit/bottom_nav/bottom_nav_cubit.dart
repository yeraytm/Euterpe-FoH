import 'dart:async';

enum NavBarItem { home, search, upload, library }

class BottomNavBarCubit {
  final StreamController<NavBarItem> _navBarController =
      StreamController<NavBarItem>.broadcast();
  NavBarItem defaultItem = NavBarItem.home;
  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.home);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.search);
        break;
      case 2:
        _navBarController.sink.add(NavBarItem.upload);
        break;
      case 3:
        _navBarController.sink.add(NavBarItem.library);
        break;
    }
  }

  close() {
    _navBarController.close();
  }
}
