import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppInfoView extends StatelessWidget {
  const AppInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Information"),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0,bottom: 10),
            child: SvgPicture.asset(width: 120, height: 120, "assets/images/tmdb.svg"),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 40,bottom: 10),
            child: Text("ABOUT CINEMY MOVIE APP",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30.0, right: 25),
            child: Text(
                "This is a movie mobile application, with integrating api from The Movie Database (TMDB).Cinemy movie app made in Flutter "
                "with clean architecture using Cubit, Firebase Service and TMDB api. "
                "I would like to say that I will work on this application a little more, add new functions and improve this application!"),
          ),
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Text("Features: search feature, now playing video movies, trending movies and details, "
                "trending tv shows and details, trending people and details"),
          ),
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Text("For your comments and suggestions, you can contact me with my email address:\n\n"
                "ademozenir@gmail.com"),
          ),
        ],
      ),
    );
  }
}
