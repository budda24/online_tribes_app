// Package imports:
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_viewer/video_viewer.dart';

// Project imports:
import '../../../helpers/main_constants.dart';
import '../../../helpers/theme/app_colors.dart';

enum VideoAsset { network, local }

class CustomVideoPlayer extends StatelessWidget {
  const CustomVideoPlayer.network({
    Key? key,
    required this.videoSrc,
    required this.videoController,
    this.type = VideoAsset.network,
  })  : videoFile = null,
        super(key: key);
  const CustomVideoPlayer.local({
    Key? key,
    required this.videoController,
    required this.videoFile,
    this.type = VideoAsset.local,
  })  : videoSrc = '',
        super(key: key);

  final String? videoSrc;
  final VideoViewerController videoController;
  final VideoAsset type;
  final File? videoFile;

  @override
  Widget build(BuildContext context) {
    print(videoController);
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
          loading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              spinkit,
              const SizedBox(height: 20),
              const Text('Loading'),
            ],
          ),
          volumeBarStyle: VolumeBarStyle(
              bar: BarStyle.volume(background: AppColors.actionColor)),
          playAndPauseStyle:
              PlayAndPauseWidgetStyle(background: AppColors.actionColor),
        ),
        controller: videoController,
        source: type == VideoAsset.network
            ? {
                "SubRip Text": VideoSource(
                  video: VideoPlayerController.network(videoSrc!),
                ),
              }
            : {
                "SubRip Text": VideoSource(
                  video: VideoPlayerController.file(videoFile!),
                ),
              });
  }
}
