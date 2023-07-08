import 'package:flutter/widgets.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import 'package:webm_compatible_video_player_platform_interface/webm_compatible_video_player_platform_interface.dart';

/// An implementation of [WebmCompatibleVideoPlayerPlatform] for Ios that uses flutter_vlc_player.
class IosWebmCompatibleVideoPlayerPlatform extends WebmCompatibleVideoPlayerPlatform {
  static void registerWith() {
    WebmCompatibleVideoPlayerPlatform.instance = IosWebmCompatibleVideoPlayerPlatform();
  }

  @override
  WebmCompatibleVideoPlayerController createController(
    String dataSource, {
    bool autoPlay = true,
    double? forcedAspectRatio,
    double? widgetAspectRatio,
  }) {
    return WebmCompatibleVideoPlayerControllerIos(
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
    return WebmCompatiblewVideoPlayerIos(
      key: key,
      controller: controller as WebmCompatibleVideoPlayerControllerIos,
    );
  }
}

class WebmCompatibleVideoPlayerControllerIos extends WebmCompatibleVideoPlayerController {
  WebmCompatibleVideoPlayerControllerIos(
    super.dataSource, {
    super.autoPlay,
    super.forcedAspectRatio,
    super.widgetAspectRatio,
  }) : _controller = VlcPlayerController.network(
          dataSource,
          autoPlay: autoPlay,
          hwAcc: HwAcc.full,
        );

  final VlcPlayerController _controller;

  VlcPlayerController get controller => _controller;

  @override
  Future<void> initialize() async {
    // Should not call VlcPlayerController.initialize because it throws if the view is not built yet
  }

  @override
  Future<void> dispose() async {
    return _controller.dispose();
  }
}

class WebmCompatiblewVideoPlayerIos extends WebmCompatibleVideoPlayer {
  const WebmCompatiblewVideoPlayerIos({
    super.key,
    required this.controller,
  }) : super.construct();

  final WebmCompatibleVideoPlayerControllerIos controller;

  @override
  Widget build(BuildContext context) {
    return VlcPlayer(
      controller: controller.controller,
      aspectRatio: controller.widgetAspectRatio ?? 1,
    );
  }
}
