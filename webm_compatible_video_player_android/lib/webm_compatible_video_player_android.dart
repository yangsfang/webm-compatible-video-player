import 'package:chewie/chewie.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

import 'package:webm_compatible_video_player_platform_interface/webm_compatible_video_player_platform_interface.dart';

/// An implementation of [WebmCompatibleVideoPlayerPlatform] for Android that uses video_player.
class AndroidWebmCompatibleVideoPlayerPlatform extends WebmCompatibleVideoPlayerPlatform {
  static void registerWith() {
    WebmCompatibleVideoPlayerPlatform.instance = AndroidWebmCompatibleVideoPlayerPlatform();
  }

  @override
  WebmCompatibleVideoPlayerController createController(
    String dataSource, {
    bool autoPlay = true,
    double? forcedAspectRatio,
    double? widgetAspectRatio,
  }) {
    return WebmCompatibleVideoPlayerControllerAndroid(
      dataSource,
      autoPlay: autoPlay,
      forcedAspectRatio: forcedAspectRatio,
      widgetAspectRatio: widgetAspectRatio,
    );
  }

  @override
  WebmCompatibleVideoPlayer createPlayer({
    Key? key,
    required WebmCompatibleVideoPlayerController controller,
  }) {
    return WebmCompatiblewVideoPlayerAndroid(
      key: key,
      controller: controller as WebmCompatibleVideoPlayerControllerAndroid,
    );
  }
}

class WebmCompatibleVideoPlayerControllerAndroid extends WebmCompatibleVideoPlayerController {
  WebmCompatibleVideoPlayerControllerAndroid(
    super.dataSource, {
    super.autoPlay,
    super.forcedAspectRatio,
    super.widgetAspectRatio,
  }) : _chewieController = ChewieController(
          videoPlayerController: VideoPlayerController.network(dataSource),
          autoPlay: autoPlay,
        );

  final ChewieController _chewieController;

  ChewieController get controller => _chewieController;

  @override
  Future<void> initialize() async {
    if (_chewieController.videoPlayerController.value.isInitialized) {
      return;
    }
    return _chewieController.videoPlayerController.initialize();
  }

  @override
  Future<void> dispose() async {
    final videoController = _chewieController.videoPlayerController;
    _chewieController.dispose();
    return videoController.dispose();
  }
}

class WebmCompatiblewVideoPlayerAndroid extends WebmCompatibleVideoPlayer {
  const WebmCompatiblewVideoPlayerAndroid({
    super.key,
    required this.controller,
  }) : super.construct();

  final WebmCompatibleVideoPlayerControllerAndroid controller;

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: controller.controller);
  }
}
