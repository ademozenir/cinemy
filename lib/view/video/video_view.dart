import 'package:chewie/chewie.dart';
import 'package:cinemy/bloc/detail_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/movie_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

class VideoView extends StatelessWidget {
  VideoView(this.id, this.videoCubit, {Key? key}) : super(key: key) {
    videoCubit.getVideos(id);
  }

  final int id;
  final VideoCubit videoCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Trailers"),
      ),
      body: BlocBuilder<VideoCubit, List<Video>>(
        bloc: videoCubit,
        builder: (_, videos) {
          return ListView(
            children: videos
                .map(
                  (video) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Card(
                      key: Key(video.id),
                      child: Column(children: [
                        SizedBox(height: 250, child: YoutubeVideo(video.key)),
                        ListTile(
                          title: Text(video.name),
                        ),
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
  const YoutubeVideo(this._key, {Key? key}) : super(key: key);

  final String _key;

  @override
  State<YoutubeVideo> createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  _YoutubeVideoState();

  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  String? _thumbnailUrl;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  Future<void> _loadVideo() async {
    var youtubeExplode = getIt.get<yt.YoutubeExplode>();
    var video = await youtubeExplode.videos.get(widget._key);
    _thumbnailUrl = video.thumbnails.standardResUrl;

    var manifest = await youtubeExplode.videos.streamsClient.getManifest(widget._key);
    var videoUrl = manifest.muxed.bestQuality.url.toString();

    _videoPlayerController = VideoPlayerController.network(videoUrl);
    _chewieController = ChewieController(
      autoInitialize: true,
      materialProgressColors: ChewieProgressColors(
          backgroundColor: Colors.white70,
          bufferedColor: Colors.white10,
          playedColor: Colors.amber,
          handleColor: Colors.amber),
      allowFullScreen: true,
      aspectRatio: 16 / 9,
      videoPlayerController: _videoPlayerController!,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_thumbnailUrl == null) {
      return const Text("video loading");
    }
    if (!_isPlaying) {
      return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(_thumbnailUrl!),
            ),
          ),
        ),
        onTap: () {
          _isPlaying = true;
          _chewieController!.play();
          setState(() {});
        },
      );
    }
    return Chewie(controller: _chewieController!);
  }
}
