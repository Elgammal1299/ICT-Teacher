import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonVideoPlayer extends StatefulWidget {
  final String? videoUrl;

  const LessonVideoPlayer({
    super.key,
    required this.videoUrl,
  });

  @override
  State<LessonVideoPlayer> createState() => _LessonVideoPlayerState();
}

class _LessonVideoPlayerState extends State<LessonVideoPlayer> {
  YoutubePlayerController? _controller;

  String? _videoId;

  bool _isPlayerStarted = false;

  @override
  void initState() {
    super.initState();

    _extractVideoId();
  }

  void _extractVideoId() {
    final url = widget.videoUrl?.trim();

    if (url == null || url.isEmpty) {
      return;
    }

    _videoId = YoutubePlayer.convertUrlToId(url);

    debugPrint('YouTube URL: $url');
    debugPrint('YouTube ID: $_videoId');
  }

  void _startPlayer() {
    if (_videoId == null || _videoId!.isEmpty) {
      return;
    }

    _controller = YoutubePlayerController(
      initialVideoId: _videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
      ),
    );

    setState(() {
      _isPlayerStarted = true;
    });
  }

  @override
  void didUpdateWidget(covariant LessonVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller?.dispose();

      _controller = null;
      _videoId = null;
      _isPlayerStarted = false;

      _extractVideoId();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_videoId == null || _videoId!.isEmpty) {
      return _invalidVideoWidget(context);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: _isPlayerStarted && _controller != null
            ? _buildPlayer()
            : _buildThumbnail(),
      ),
    );
  }

  Widget _buildThumbnail() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://img.youtube.com/vi/$_videoId/hqdefault.jpg',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return Container(
              color: Colors.black12,
            );
          },
        ),

        // طبقة خفيفة فوق الصورة
        Container(
          color: Colors.black.withValues(
            alpha: 0.18,
          ),
        ),

        // زر التشغيل
        Center(
          child: InkWell(
            onTap: _startPlayer,
            borderRadius: BorderRadius.circular(50.r),
            child: Container(
              width: 70.w,
              height: 70.w,
              decoration: BoxDecoration(
                color: Colors.black.withValues(
                  alpha: 0.75,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 45.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayer() {
    return YoutubePlayer(
      controller: _controller!,
      aspectRatio: 16 / 9,
      showVideoProgressIndicator: true,
    );
  }

  Widget _invalidVideoWidget(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        color: Theme.of(context)
            .hintColor
            .withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.r),
      ),
      alignment: Alignment.center,
      child: const Text(
        'رابط الفيديو غير صالح',
      ),
    );
  }
}