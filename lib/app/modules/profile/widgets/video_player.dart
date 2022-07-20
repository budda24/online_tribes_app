import 'package:flutter/material.dart';

import 'package:video_viewer/video_viewer.dart';

import '../../../helpers/const.dart';
import '../../../helpers/theme/app_colors.dart';

class CustomVideoPlayer extends StatelessWidget {
  const CustomVideoPlayer(
      {Key? key, required this.videoSrc, required this.videoController})
      : super(key: key);

  final String videoSrc;
  final VideoViewerController videoController;

  @override
  Widget build(BuildContext context) {
    return VideoViewer(
        enableVerticalSwapingGesture: false,
        enableHorizontalSwapingGesture: false,
        style: VideoViewerStyle(
          progressBarStyle: ProgressBarStyle(
              backgroundColor: AppColors.actionColor,
              bar: BarStyle.progress(
                color: AppColors.actionColor,
                height: 1,
              )),
              
          loading: spinkit,
          volumeBarStyle: VolumeBarStyle(
              bar: BarStyle.volume(background: AppColors.actionColor)),
          playAndPauseStyle:
              PlayAndPauseWidgetStyle(background: AppColors.actionColor),
        ),
        controller: videoController,
        source: {
          "SubRip Text": VideoSource(
            video: VideoPlayerController.network(videoSrc),
          ),
        });
  }
}
