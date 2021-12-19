import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/cubit/BottomNavigationCubit.dart';
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
            case NavBarItem.HOME:
              return const Home();
            case NavBarItem.SEARCH:
              return const Search();
            case NavBarItem.LIBRARY:
              return const Library();
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
            fixedColor: Colors.blueAccent,
            currentIndex: snapshot.data!.index,
            onTap: _bottomNavBarCubit.pickItem,
            items: const [
              BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: 'Search', icon: Icon(Icons.search)),
              BottomNavigationBarItem(
                  label: 'Library', icon: Icon(Icons.library_music)),
            ],
          );
        },
      ),
    );
  }
}
