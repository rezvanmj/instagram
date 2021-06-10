import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/controllers/user-controller.dart';

class SearchForUsersAppbar extends StatefulWidget {
  @override
  _SearchForUsersAppbarState createState() => _SearchForUsersAppbarState();
}

class _SearchForUsersAppbarState extends State<SearchForUsersAppbar> {
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'search...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white54),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onSubmitted: (searchString) {
        return searchString.isEmpty
            ? _userController.getUserData()
            : _userController.search(searchString);
      },
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              _userController.getUserData();
              Get.back();
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      title: _isSearching
          ? _buildSearchField()
          : Center(child: Text('search for users')),
      actions: _buildActions(),
    );
  }

  UserController get _userController {
    return Get.find<UserController>();
  }
}
