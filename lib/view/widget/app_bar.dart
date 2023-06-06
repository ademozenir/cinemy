import 'package:cinemy/bloc/auth_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/user.dart';
import 'package:cinemy/view/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            BlocBuilder<AuthCubit, User>(
              bloc: getIt.get<AuthCubit>(),
              builder: (_, user) {
                return PopupMenuButton(
                  icon: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      child: Image.network(user.photoUrl)),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('Log out'),
                        onTap: () => getIt.get<AuthCubit>().signOut(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
}
