# webm_compatible_video_player

A video player that plays WebM video files.

The Android and web implementation uses [`video_player`](https://pub.dev/packages/video_player). The iOS implementation uses [`flutter_vlc_player`](https://pub.dev/packages/flutter_vlc_player).

## Installation

Add this git repository to [your pubspec.yaml](https://flutter.dev/using-packages/).

```
dependencies:
  webm_compatible_video_player:
    git:
      url: https://github.com/yangsfang/webm-compatible-video-player.git
      path: webm-compatible-video-player
```

### Android

Follow setup instruction for `video_player`. Add `INTERNET` permission to manifest.

### iOS 

Follow setup instruction for `flutter_vlc_player`.
