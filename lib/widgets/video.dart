import 'package:flutter/material.dart';
import 'package:shippi/styles/fonts.dart';
import 'package:shippi/styles/styles.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPopup extends StatefulWidget {
  final String videoId;

  const VideoPopup({required this.videoId});

  @override
  _VideoPopupState createState() => _VideoPopupState();
}

class _VideoPopupState extends State<VideoPopup> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: false,
      params: YoutubePlayerParams(
        showFullscreenButton: true,
        showControls: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Styles.brandBackgroundColor,
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 800,
        height: 450,
        child: YoutubePlayer(
          controller: _controller,
          aspectRatio: 16 / 9,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Close', style: AppTextStyles.regular),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
