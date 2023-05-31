import 'package:chewie/chewie.dart';
import 'package:cinemy/tmdb/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MoviePlayer extends StatefulWidget {
  const MoviePlayer({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  State<MoviePlayer> createState() => _MoviePlayerState();
}

class _MoviePlayerState extends State<MoviePlayer> {

  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    // videoPlayerController = VideoPlayerController.asset(widget.movie.videoPath)
    //   ..initialize().then(
    //     (value) => setState(
    //       () {},
    //     ),
    //   );

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}
