import 'package:chewie/chewie.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ProfileController extends GetxController {
  RxInt actualIndex = 0.obs;

  bool isShrinkWrap = true;


  /* TargetPlatform? _platform; */
  late VideoPlayerController _videoPlayerController1;
  ChewieController? chewieController;
  String srcs =
      "https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4";

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(srcs);
    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    _createChewieController();
    update();
  }

  void _createChewieController() {
    chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      looping: true,
      hideControlsTimer: const Duration(seconds: 1),

      /* additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: toggleVideo,
            iconData: Icons.live_tv_sharp,
            title: 'Toggle Video Src',
          ),
        ];
      }, */
      /* subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ), */
    );
  }

  @override
  void onInit() async {
    await initializePlayer();
    super.onInit();
  }

  @override
  void onClose() {
    _videoPlayerController1.dispose();
    chewieController?.dispose();
    super.onClose();
  }
}
