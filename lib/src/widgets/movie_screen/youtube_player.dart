import 'package:flutter/material.dart';
import 'package:movie_app/src/bloc/movies_bloc.dart';
import 'package:movie_app/src/bloc/movies_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeWidget extends StatefulWidget {
  final int id;
  final MoviesBloc bloc;
  YouTubeWidget(this.id, this.bloc);
  @override
  _YouTubeWidgetState createState() => _YouTubeWidgetState();
}

class _YouTubeWidgetState extends State<YouTubeWidget> {
  YoutubePlayerController _controller;

  double _opacity = 0;
  double _height = 0;
  String _src;

  @override
  void initState() {
    super.initState();
    _setSource();
  }

  void _setSource() async {
    _src = await widget.bloc.movieTrailerFuture(widget.id);
    //loading data about video ID (YouTube), on which next depends the view of this widget
    if (_src != null) {
      setState(() {
        _height = MediaQuery.of(context).size.width * 9 / 16;
      });
    }
    // this webView YouTube widget takes to much time to render so in order to make
    // transition to the movie page smoother - added time for completing transition
    await Future.delayed(Duration(milliseconds: 130));
    if (mounted) {
      setState(() {
        if (_src != null) {
          _controller = YoutubePlayerController(
            initialVideoId: _src,
            flags: YoutubePlayerFlags(
              mute: false,
              autoPlay: false,
              enableCaption: false,
              hideThumbnail: true,
            ),
          );
        }
      });
    }
  }

  @override
  void deactivate() {
    _controller?.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      decoration: BoxDecoration(
        color: Colors.black,
        image: _src == null
            ? null
            : DecorationImage(
                image:
                    Image.network("http://i1.ytimg.com/vi/$_src/mqdefault.jpg")
                        .image,
                fit: BoxFit.cover),
      ),
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(milliseconds: 100),
        child: _controller == null
            ? Container()
            : YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () {
                  if (mounted) {
                    setState(() => _opacity = 1.0);
                  }
                },
              ),
      ),
    );
  }
}
