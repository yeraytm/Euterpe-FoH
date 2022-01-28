import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/models/models.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const historyLength = 5;

  final List<String> _searchHistory = [
    'Stay',
    'Imagine Dragons',
    'Future Nostalgia',
    'Sucker',
    'Levitating',
  ];

  late List<String> filteredSearchHistory;
  String selectedTerm = '';

  List<String> filterSearchTerms({
    required String filter,
  }) {
    if (filter.isNotEmpty) {
      return _searchHistory.reversed
          .where(
              (term) => term.startsWith(RegExp(filter, caseSensitive: false)))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    if (term != "") {
      _searchHistory.add(term);
      if (_searchHistory.length > historyLength) {
        _searchHistory.removeRange(0, _searchHistory.length - historyLength);
      }

      filteredSearchHistory = filterSearchTerms(filter: "");
    }
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: "");
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term); // deletes the term wherever it is
    addSearchTerm(term); // adds the term at the end of our history
  }

  late FloatingSearchBarController controller;

  @override
  void initState() {
    filteredSearchHistory = filterSearchTerms(filter: "");
    controller = FloatingSearchBarController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar(
        controller: controller,
        body: FloatingSearchBarScrollNotifier(
          child: SearchResultsListView(
            searchTerm: selectedTerm,
          ),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: const BouncingScrollPhysics(),
        title: Text(
          selectedTerm == '' ? 'Start your search' : selectedTerm,
          style: Theme.of(context).textTheme.headline6,
        ),
        hint: 'Seach in our music libraries...',
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) {
          setState(() {
            filteredSearchHistory = filterSearchTerms(filter: query);
          });
        },
        onSubmitted: (query) {
          setState(() {
            addSearchTerm(query);
            selectedTerm = query;
          });
          controller.close();
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4,
              child: Builder(
                builder: (context) {
                  if (filteredSearchHistory.isEmpty &&
                      controller.query.isEmpty) {
                    return Container(
                      height: 56,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Start searching',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  } else if (filteredSearchHistory.isEmpty) {
                    return ListTile(
                      title: Text(controller.query),
                      leading: const Icon(Icons.search),
                      onTap: () {
                        setState(() {
                          addSearchTerm(controller.query);
                          selectedTerm = controller.query;
                        });
                        controller.close();
                      },
                    );
                  } else {
                    // Listview produces some errors and a Column solves them:
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: filteredSearchHistory
                          .map(
                            (term) => ListTile(
                              title: Text(
                                term,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: const Icon(Icons.history),
                              trailing: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    deleteSearchTerm(term);
                                  });
                                },
                              ),
                              onTap: () {
                                setState(() {
                                  putSearchTermFirst(term);
                                  selectedTerm = term;
                                });
                                controller.close();
                              },
                            ),
                          )
                          .toList(),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class SearchResultsListView extends StatelessWidget {
  final String searchTerm;
  const SearchResultsListView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == "") {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search, size: 64),
            Text('Start searching',
                style: Theme.of(context).textTheme.headline5)
          ],
        ),
      );
    }

    final db = FirebaseFirestore.instance;
    final floatingSB = FloatingSearchBar.of(context);
    if (floatingSB != null) {
      return FutureBuilder(
        future: db
            .collection("Songs")
            .where('name', isGreaterThan: searchTerm)
            .where('name', isLessThanOrEqualTo: searchTerm + '\uf7ff')
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return ErrorWidget(snapshot.error!);
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              Song song = Song.fromMap(data);
              return Container(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: ListTile(
                  leading: const Icon(Icons.ac_unit),
                  title: Text(song.name),
                ),
              );
            }).toList(),
          );
        },
      );
    } else {
      return const Center(
        child: Text('SOME ERRORS OCCURRED'),
      );
    }
  }
}

// class SongResult extends StatelessWidget {
//   const SongResult({
//     Key? key,
//     required this.floatingSB,
//     required this.searchTerm,
//   }) : super(key: key);

//   final FloatingSearchBarState? floatingSB;
//   final String searchTerm;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: EdgeInsets.only(
//           top: floatingSB!.style.height + floatingSB!.style.margins.vertical),
//       itemCount: 10,
//       itemBuilder: (context, index) {
//         return ListTile(

//         )
//       },
//     );
//   }
// }
