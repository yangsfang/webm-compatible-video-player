import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class WebmCompatibleVideoPlayerPlatform extends PlatformInterface {
  /// Constructs a WebmCompatibleVideoPlayerPlatform.
  WebmCompatibleVideoPlayerPlatform() : super(token: _token);

  static final Object _token = Object();

  static WebmCompatibleVideoPlayerPlatform _instance = DummyWebmCompatibleVideoPlayer();

  /// The default instance of [WebmCompatibleVideoPlayerPlatform] to use.
  ///
  /// Defaults to [DummyWebmCompatibleVideoPlayer].
  static WebmCompatibleVideoPlayerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WebmCompatibleVideoPlayerPlatform] when
  /// they register themselves.
  static set instance(WebmCompatibleVideoPlayerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  WebmCompatibleVideoPlayerController createController(
    String dataSource, {
    bool autoPlay = true,
    double? forcedAspectRatio,
    double? widgetAspectRatio,
  }) {
    throw UnimplementedError('createController() has not been implemented.');
  }

  WebmCompatibleVideoPlayer createPlayer({
    Key? key,
    required WebmCompatibleVideoPlayerController controller,
  }) {
    throw UnimplementedError('createPlayer() has not been implemented.');
  }
}

class DummyWebmCompatibleVideoPlayer extends WebmCompatibleVideoPlayerPlatform {}

abstract class WebmCompatibleVideoPlayerController {
  WebmCompatibleVideoPlayerController(
    this.dataSource, {
    this.autoPlay = true,
    this.forcedAspectRatio,
    this.widgetAspectRatio,
  });

  static WebmCompatibleVideoPlayerController network(
    String dataSource, {
    bool autoPlay = true,
    double? forcedAspectRatio,
    double? widgetAspectRatio,
  }) {
    return WebmCompatibleVideoPlayerPlatform.instance.createController(
      dataSource,
      autoPlay: autoPlay,
      forcedAspectRatio: forcedAspectRatio,
      widgetAspectRatio: widgetAspectRatio,
    );
  }

  static WebmCompatibleVideoPlayerController file(
    File file, {
    bool autoPlay = true,
    double? forcedAspectRatio,
    double? widgetAspectRatio,
  }) {
    String dataSource = Uri.file(file.absolute.path).toString();
    return WebmCompatibleVideoPlayerPlatform.instance.createController(
      dataSource,
      autoPlay: autoPlay,
      forcedAspectRatio: forcedAspectRatio,
      widgetAspectRatio: widgetAspectRatio,
    );
  }

  Future<void> initialize();

  Future<void> dispose();

  final String dataSource;
  final bool autoPlay;

  /// Video's aspect ratio.
  final double? forcedAspectRatio;

  /// Widget's aspect ratio.
  final double? widgetAspectRatio;
}

abstract class WebmCompatibleVideoPlayer extends StatelessWidget {
  factory WebmCompatibleVideoPlayer({
    Key? key,
    required WebmCompatibleVideoPlayerController controller,
  }) {
    return WebmCompatibleVideoPlayerPlatform.instance.createPlayer(
      key: key,
      controller: controller,
    );
  }

  const WebmCompatibleVideoPlayer.construct({super.key});
}
