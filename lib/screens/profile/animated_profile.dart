import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class NestedContorller extends GetxController {
  var _controller = ScrollController().obs;
  var offset = 0.0.obs;
  var counter = 1.obs;
  void incre() => counter++;
  void updateOffset() => offset.value = _controller.value.offset;
}

class AnimatedProfile extends StatefulWidget {
  static const String name = "Animated Avatar";
  static const String route = "/profile/animated_profile";
  AnimatedProfile({Key key}) : super(key: key);

  @override
  _AnimatedProfileState createState() => _AnimatedProfileState();
}

class _AnimatedProfileState extends State<AnimatedProfile> {
  List<Achieve> achievs = [
    Achieve(title: "Ranked #1 in SharifCop", imageUrl: "assets/pics/3.png"),
    Achieve(title: "Best Degree in CE", imageUrl: "assets/pics/3.png"),
    Achieve(title: "Most Compituis Dev", imageUrl: "assets/pics/3.png")
  ];
  double wid, hei;
  final controller = Get.put(NestedContorller());
  @override
  void initState() {
    controller._controller.value.addListener(() {
      controller.updateOffset();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    wid = MediaQuery.of(context).size.width;
    hei = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
              controller: controller._controller.value,
              headerSliverBuilder: (_, boo) => [MyAppBar()],
              body: Container(
                  // padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(00, 13, 40, 1),
                  ),
                  height: hei,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProgressCircle(),
                      SizedBox(
                        height: 20,
                      ),
                      Informations(),
                      Achievements(items: achievs)
                    ],
                  ))),
          Avatar(),
        ],
      ),
    );
  }
}

class Achieve {
  final String title;
  final String imageUrl;
  final String details;

  Achieve({this.title, this.imageUrl, this.details});
}

class Achievements extends StatefulWidget {
  final List<Achieve> items;

  const Achievements({Key key, this.items}) : super(key: key);
  @override
  _AchievementsState createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  List<Achieve> items;
  ScrollController controller1;
  int selected = 0;
  List wids;
  @override
  void initState() {
    controller1 = ScrollController(initialScrollOffset: 330);
    items = widget.items;
    controller1.addListener(() {
      updateIndex();
    });
    super.initState();
  }

  updateIndex() {
    if (controller1.offset == 300) {
      print("PROCESSS");
      var temp = items.first;
      setState(() {
        items.add(temp);

        items.removeAt(0);
      });
    }
    for (int i = 1; i < items.length + 1; i++) {
      // print(
      //     "offset is ${controller1.offset} \n wid is ${MediaQuery.of(context).size.width} \n i is $i ");
      if (MediaQuery.of(context).size.width * i / 2 < controller1.offset &&
          controller1.offset < MediaQuery.of(context).size.width * i) {
        setState(() {
          selected = i - 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Achievements"),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: ListView(
            controller: controller1,
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(
                width: 80,
              ),
              ...items.map((item) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                        color: selected == items.indexOf(item)
                            ? Colors.white.withOpacity(0.4)
                            : Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30)),
                    child: Container(
                      // fit: BoxFit.fitHeight,
                      child: Column(
                        children: [
                          Container(
                              // width: double.infinity,
                              height: 200,
                              margin: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5, bottom: 80),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(item.imageUrl))))
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                width: 80,
              ),
            ],
          ),
        ),
        Row(children: [
          ...items.map((item) => Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected == items.indexOf(item)
                        ? Colors.white
                        : Colors.grey),
              ))
        ]),
      ],
    );
  }
}

class Informations extends StatelessWidget {
  const Informations({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    final hei = MediaQuery.of(context).size.height;
    return Container(
      width: wid * 0.6,
      height: hei * 0.1,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30)),
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Text(
          "data",
        ),
      ),
    );
  }
}

class ProgressCircle extends StatefulWidget {
  ProgressCircle({Key key}) : super(key: key);

  @override
  _ProgressCircleState createState() => _ProgressCircleState();
}

class _ProgressCircleState extends State<ProgressCircle> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("Your Profile is "),
      CircularPercentIndicator(
        // progressColor: Colors.blue[400],
        backgroundWidth: 18,
        linearGradient: LinearGradient(colors: [
          Colors.blue,
          Color.fromRGBO(00, 13, 40, 1),
        ]),
        // arcBackgroundColor: Colors.white,
        radius: 120.0,
        lineWidth: 13.0,
        animation: true,
        percent: 0.7,
        center: new Text(
          "70.0%",
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.white,
              fontFamily: "McLaren"),
        ),
      )
    ]);
  }
}

class Avatar extends StatefulWidget {
  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  final NestedContorller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Positioned(
          top: MediaQuery.of(context).size.height * 0.17 -
              math.max(55 - controller.offset.value * 0.5, 0) -
              math.min(controller.offset.value,
                  MediaQuery.of(context).size.height * 0.17),
          left: MediaQuery.of(context).size.width * 0.08,
          child: controller.offset < MediaQuery.of(context).size.height * 0.1
              ? Container(
                  width: 120,
                  height: math.max(120 - controller.offset.value, 0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                      image: DecorationImage(
                          image: AssetImage("assets/avatars/me.jpg"))),
                )
              : Text(""),
        ));
  }
}

class MyAppBar extends StatefulWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;

    return SliverAppBar(
      expandedHeight: hei * 0.15,
      backgroundColor: Color.fromRGBO(00, 13, 40, 1),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Material(
                // color: Colors.black,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                            MediaQuery.of(context).size.width * 0.2))),
                child: WaveBar()),
          ],
        ),
      ),
    );
  }
}

class WaveBar extends StatefulWidget {
  @override
  _WaveBarState createState() => _WaveBarState();
}

class _WaveBarState extends State<WaveBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RotatedBox(
        quarterTurns: 2,
        child: WaveWidget(
          config: CustomConfig(
            gradients: [
              [
                Colors.blue[300],
                Color.fromRGBO(00, 13, 40, 1),
              ],
              [
                Colors.blue[500],
                Color.fromRGBO(00, 13, 40, 1),
              ],
              [
                Colors.blue[700],
                Color.fromRGBO(00, 13, 40, 1),
              ],
              [
                Colors.blue[900],
                Color.fromRGBO(00, 13, 40, 1),
              ]
            ],
            durations: [35000, 19440, 10800, 6000],
            heightPercentages: [0.26, 0.29, 0.34, 0.39],
            blur: MaskFilter.blur(BlurStyle.solid, 10),
            gradientBegin: Alignment.topLeft,
            gradientEnd: Alignment.bottomRight,
          ),
          waveAmplitude: 0,
          size: Size(
            double.infinity,
            double.infinity,
          ),
        ),
      ),
    );
  }
}
