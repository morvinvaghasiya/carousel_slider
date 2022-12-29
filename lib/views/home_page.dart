import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> videolist = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://firebasestorage.googleapis.com/v0/b/demoproject-27229.appspot.com/o/videos%2FCaterpillar%20-%202104.mp4?alt=media&token=42de251c-4ab1-4fb9-a9e3-5b759e6622f0",
    "https://firebasestorage.googleapis.com/v0/b/demoproject-27229.appspot.com/o/videos%2FBee%20-%2039116.mp4?alt=media&token=dcb22e7e-8f05-48fc-9975-590854bb9c28",
    "https://firebasestorage.googleapis.com/v0/b/demoproject-27229.appspot.com/o/videos%2FRobin%20-%2021723.mp4?alt=media&token=b6363e2b-809e-421c-a749-634ac2e292cc",
    "https://firebasestorage.googleapis.com/v0/b/demoproject-27229.appspot.com/o/videos%2FOwl%20-%2018244.mp4?alt=media&token=b4072177-21a5-4b93-aeed-1a243ac7a94a",
  ];
  List<VideoPlayerController> videoController = [];

  List details = [
    "The prevailing view assumed lorem ipsum was born as a nonsense text.",
    "The prevailing view assumed lorem ipsum was born as a nonsense text.",
    "The prevailing view assumed lorem ipsum was born as a nonsense text.",
    "The prevailing view assumed lorem ipsum was born as a nonsense text.",
    "The prevailing view assumed lorem ipsum was born as a nonsense text.",
    "The prevailing view assumed lorem ipsum was born as a nonsense text.",
  ];

  @override
  void initState() {
    for (int i = 0; i < videolist.length; i++) {
      videoController.add(VideoPlayerController.network(videolist[i])
        ..initialize().then((_) {
          videoController[0].play();
          videoController[0].setLooping(true);
          setState(() {});
        }));
    }
    super.initState();
  }

  @override
  void dispose() {
    videoController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: videolist.map((e) {
                int index = videolist.indexWhere((element) => element == e);
                return videoController[index].value.isInitialized
                    ? Center(
                        child: AspectRatio(
                          aspectRatio: 1 / 2,
                          child: VideoPlayer(videoController[index]),
                        ),
                      )
                    : Container();
              }).toList(),
              options: CarouselOptions(
                  height: size.height,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(seconds: 5),
                  initialPage: 0,
                  onPageChanged: (int index, CarouselPageChangedReason data) {
                    debugPrint(
                        "data index => $index => ${videoController.length - 1}");
                    if (index != 0) {
                      if (index > (index - 1)) {
                        debugPrint("data in between 1 index => $index");
                        videoController[index - 1].pause();
                        // videoController[index].
                        videoController[index].play();
                      } else {
                        debugPrint("data in between index => $index");
                        videoController[index + 1].pause();
                        videoController[index].play();
                      }
                    } else {
                      debugPrint("data in last index => $index");
                      videoController[videoController.length - 1].pause();
                      videoController[0].play();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
