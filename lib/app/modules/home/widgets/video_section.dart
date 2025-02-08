import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoSection extends StatelessWidget {
  final YoutubePlayerController youtubePlayerController;
  const VideoSection({super.key, required this.youtubePlayerController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0.sp),
      child: YoutubePlayer(
        controller: youtubePlayerController,
        showVideoProgressIndicator: true,
      ),
    );
  }
}