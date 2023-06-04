

import 'package:cinemy/view/search/search_view.dart';
import 'package:flutter/material.dart';

class MainSearchBar extends AppBar {
  MainSearchBar(String title, {super.key})
      : super(
    title: Text(title),
    actions: <Widget>[
      Builder(
        builder: (BuildContext context) => IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchView()));
          },
        ),
      ),
    ],
  );
}
