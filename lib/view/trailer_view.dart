import 'package:chewie/chewie.dart';
import 'package:cinemy/bloc/movie_detail_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/movie_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

class TrailerView extends StatelessWidget {
  TrailerView(this.movieId, {Key? key}) : super(key: key) {
    getIt.get<MovieVideoCubit>().getMovieVideos(movieId);
  }

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Text("Trailers"),
      ),
      body: BlocBuilder<MovieVideoCubit, List<Video>>(
        bloc: getIt.get<MovieVideoCubit>(),
        builder: (_, videos) {
          return ListView(
            children: videos
                .map(
                  (video) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Card(
                      key: Key(video.id),
                      child: Column(children: [
                        ListTile(
                          title: Text(video.name),
                        ),
                        SizedBox(height: 250, child: YoutubeVideo(video.key)),
                      ]),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}

class YoutubeVideo extends StatefulWidget {
  YoutubeVideo(this._key, {Key? key}) : super(key: key);

  final String _key;

  @override
  State<YoutubeVideo> createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  _YoutubeVideoState();

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    var youtubeExplode = getIt.get<yt.YoutubeExplode>();
    youtubeExplode.videos.streamsClient.getManifest(widget._key).then((manifest) {
      _videoPlayerController = VideoPlayerController.network(manifest.muxed.bestQuality.url.toString());
      _chewieController = ChewieController(videoPlayerController: _videoPlayerController);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController == null
        ? const Text("video loading")
        : Chewie(
            controller: _chewieController!,
          );
  }
}
