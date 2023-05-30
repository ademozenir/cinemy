
import 'package:cinemy/view/trending_tv_shows_view.dart';
import 'package:cinemy/view/trending_movies_view.dart';
import 'package:cinemy/view/trending_people_view.dart';
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
    const TrendingPeopleView()
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
          unselectedFontSize: 0,
          selectedFontSize: 0,
          type:BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.yellow[700],
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 0,
          items:const [
            BottomNavigationBarItem(label:"Movies",icon: Icon(Icons.movie)),
            BottomNavigationBarItem(label:"Tv Shows",icon: Icon(Icons.live_tv_outlined)),
            BottomNavigationBarItem(label:"People",icon: Icon(Icons.person)),
          ]
      ),
    );
  }
}
