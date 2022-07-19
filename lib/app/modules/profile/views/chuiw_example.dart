/* import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'theme.dart';

class ChewieDemo extends StatefulWidget {
  const ChewieDemo({
    Key? key,
    this.title = 'Chewie Demo',
  }) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  String srcs =
      "https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4";

  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        VideoPlayerController.network(srcs[currPlayIndex]);
    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      looping: true,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: toggleVideo,
            iconData: Icons.live_tv_sharp,
            title: 'Toggle Video Src',
          ),
        ];
      },
      subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ),
      hideControlsTimer: const Duration(seconds: 1),
    );
  }

  int currPlayIndex = 0;

  Future<void> toggleVideo() async {
    await _videoPlayerController1.pause();
    currPlayIndex += 1;
    if (currPlayIndex >= srcs.length) {
      currPlayIndex = 0;
    }
    await initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: AppTheme.light.copyWith(
        platform: _platform ?? Theme.of(context).platform,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: _chewieController != null &&
                        _chewieController!
                            .videoPlayerController.value.isInitialized
                    ? Chewie(
                        controller: _chewieController!,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text('Loading'),
                        ],
                      ),
              ),
            ),
            TextButton(
              onPressed: () {
                _chewieController?.enterFullScreen();
              },
              child: const Text('Fullscreen'),
            ),
           /*  Expanded(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _platform = TargetPlatform.android;
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("Android controls"),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _platform = TargetPlatform.iOS;
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("iOS controls"),
                ),
              ),
            ) */,
          ],
        ),
      ),
    );
  }
}
 */
/* {
   "life_motto":"Be Happy",
   "profile_photo":"http://10.0.2.2:9199/v0/b/online-tribes-6a28c.appspot.com/o/7AZPLdsjsuWoAPm9yo9biYj1QrQr%2Fprofile%2FprofileVideo.mp4?alt=media&token=4ce95f46-772a-4fe3-992f-be056a0d2358",
   "time_to_invest":4,
   "description":"description",
   "requested_tribe":{
      "tgjh":"jghjkg"
   },
   "userId":"7AZPLdsjsuWoAPm9yo9biYj1QrQr",
   "attended_tribe":null,
   "intro_video_url":"http://10.0.2.2:9199/v0/b/online-tribes-6a28c.appspot.com/o/7AZPLdsjsuWoAPm9yo9biYj1QrQr%2Fprofile%2FprofileVideo.mp4?alt=media&token=4ce95f46-772a-4fe3-992f-be056a0d2358",
   "createdAt":"Timestamp(seconds=1658158688, nanoseconds=603000000)",
   "hobbies":{
      "hobby1":"meditation",
      "hobby":"photography"
   },
   "name":null,
   "phone_number":null,
   "profile_notification":[
      123,
      "Timestamp(seconds=1658160995, nanoseconds=784000000)"
   ],
   "email":"franek@online-tribes.com"
} */