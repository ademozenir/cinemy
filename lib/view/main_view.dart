
import 'package:cinemy/view/login/sign_outh_view.dart';
import 'package:cinemy/view/movie/trending_movies_view.dart';
import 'package:cinemy/view/person/trending_people_view.dart';
import 'package:cinemy/view/tv_show/trending_tv_shows_view.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  List pages = [
    const TrendingMoviesView(),
    const TrendingTvShowsView(),
    const TrendingPeopleView(),
    const SignOutView(),
  ];
  int currentIndex=0;
  void onTap(int index){
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          unselectedFontSize: 12,
          selectedFontSize: 12,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 0,
          type:BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.grey.withOpacity(0.9),
          items:const [
            BottomNavigationBarItem(label:"Movies",icon: Icon(Icons.movie)),
            BottomNavigationBarItem(label:"Tv Shows",icon: Icon(Icons.live_tv_outlined)),
            BottomNavigationBarItem(label:"People",icon: Icon(Icons.person)),
            BottomNavigationBarItem(label:"LogIn",icon: Icon(Icons.power_settings_new_outlined)),
          ]
      ),
    );
  }
}
