import 'package:chewie/chewie.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart' show Registrar;
import 'package:video_player/video_player.dart';

import 'package:webm_compatible_video_player_platform_interface/webm_compatible_video_player_platform_interface.dart';

/// An implementation of [WebmCompatibleVideoPlayerPlatform] for Web.
class WebmCompatibleVideoPlayerPlatformWeb extends WebmCompatibleVideoPlayerPlatform {
  static void registerWith(Registrar registrar) {
    WebmCompatibleVideoPlayerPlatform.instance = WebmCompatibleVideoPlayerPlatformWeb();
  }

  @override
  WebmCompatibleVideoPlayerController createController(
    String dataSource, {
    bool autoPlay = true,
    double? forcedAspectRatio,
    double? widgetAspectRatio,
  }) {
    return WebmCompatibleVideoPlayerControllerWeb(
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
    return WebmCompatiblewVideoPlayerWeb(
      key: key,
      controller: controller as WebmCompatibleVideoPlayerControllerWeb,
    );
  }
}

class WebmCompatibleVideoPlayerControllerWeb extends WebmCompatibleVideoPlayerController {
  WebmCompatibleVideoPlayerControllerWeb(
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

class WebmCompatiblewVideoPlayerWeb extends WebmCompatibleVideoPlayer {
  const WebmCompatiblewVideoPlayerWeb({
    super.key,
    required this.controller,
  }) : super.construct();

  final WebmCompatibleVideoPlayerControllerWeb controller;

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: controller.controller);
  }
}
