import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webm_compatible_video_player/webm_compatible_video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future<WebmCompatibleVideoPlayerController> _initializingController;

  @override
  void initState() {
    super.initState();
    _initializingController = Future.delayed(
      Duration.zero,
      () async {
        final c = WebmCompatibleVideoPlayerController.network(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
          autoPlay: !kIsWeb, // Cannot autoplay on Web due to autoplay permission
        );
        await c.initialize();
        return c;
      },
    );
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await (await _initializingController).dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WebM Player Plugin example app'),
        ),
        body: Center(
            child: FutureBuilder<WebmCompatibleVideoPlayerController>(
          future: _initializingController,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final controller = snapshot.data;
              if (controller != null) {
                return Center(child: WebmCompatibleVideoPlayer(controller: controller));
              } else {
                return const Center(child: Text('No content!'));
              }
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error!'));
            } else {
              return const Center(child: Text('Loading!'));
            }
          },
        )),
      ),
    );
  }
}
