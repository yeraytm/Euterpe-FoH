import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/cubit/cubits.dart';
import 'package:flutters_of_hamelin/screens/screens.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late BottomNavBarCubit _bottomNavBarCubit;

  @override
  void initState() {
    super.initState();
    _bottomNavBarCubit = BottomNavBarCubit();
  }

  @override
  void dispose() {
    super.dispose();
    _bottomNavBarCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<NavBarItem>(
        stream: _bottomNavBarCubit.itemStream,
        initialData: _bottomNavBarCubit.defaultItem,
        builder: (context, snapshot) {
          switch (snapshot.data) {
            case NavBarItem.home:
              return const Home();
            case NavBarItem.search:
              return const Search();
            case NavBarItem.library:
              return Library();
            default:
              return const Home();
          }
        },
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarCubit.itemStream,
        initialData: _bottomNavBarCubit.defaultItem,
        builder: (context, AsyncSnapshot<NavBarItem> snapshot) {
          return BottomNavigationBar(
            fixedColor: Colors.black,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            currentIndex: snapshot.data!.index,
            onTap: _bottomNavBarCubit.pickItem,
            items: const [
              BottomNavigationBarItem(
                  label: 'Home',
                  activeIcon: Icon(Icons.home),
                  icon: Icon(Icons.home_outlined)),
              BottomNavigationBarItem(
                  label: 'Search',
                  activeIcon: Icon(Icons.explore),
                  icon: Icon(Icons.explore_outlined)),
              BottomNavigationBarItem(
                  label: 'Library',
                  activeIcon: Icon(Icons.library_music),
                  icon: Icon(Icons.library_music_outlined)),
            ],
          );
        },
      ),
    );
  }
}
