import 'dart:math' as math;

import 'package:flutter/material.dart';

class BlurImage extends StatefulWidget {
  static const String route = "/custom/blue_image";
  static const String name = "Animated Image Blur";
  @override
  _BlurImageState createState() => _BlurImageState();
}

class _BlurImageState extends State<BlurImage>
    with SingleTickerProviderStateMixin {
  final ScrollController controller = ScrollController();
  // Animation _anim;
  // AnimationController _animController;
  @override
  void initState() {
    // _animController =
    //     AnimationController(vsync: this, duration: Duration(seconds: 5));
    // _anim = CurvedAnimation(parent: _animController, curve: Curves.easeInOut);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blur Image"),
      ),
      body: AvatarStack(
        controller: controller,
        top: 500,
        left: 200,
        // reverse: true,
        // expandTimes: 0.1,
        child: ListView(
          controller: controller,
          children: [
            ...[
              Colors.red,
              Colors.blue,
              Colors.blueGrey,
              Colors.deepPurple,
              Colors.green,
              Colors.amber,
              Colors.black,
              Colors.purple,
              Colors.yellow,
              Colors.brown
            ].map((e) => Container(width: 450, height: 200, color: e))
          ],
        ),
      ),
    );
  }
}

class AvatarStack extends StatefulWidget {
  final ScrollController controller;
  final double top;
  final double left;
  final double expandTimes;
  final Widget child;
  final bool reverse;
  final BoxBorder border;
  final ImageProvider image;

  const AvatarStack(
      {Key key,
      this.controller,
      this.top,
      this.left,
      this.reverse = false,
      this.expandTimes = 1,
      this.child,
      this.border,
      this.image})
      : super(key: key);

  @override
  _AvatarStackState createState() => _AvatarStackState();
}

class _AvatarStackState extends State<AvatarStack> {
  ScrollController controller;
  double offset = 0;
  @override
  void initState() {
    controller = widget.controller;
    controller.addListener(() {
      updater();
    });
    super.initState();
  }

  updater() {
    print("off set is tthis  :::  $offset");
    setState(() {
      offset = widget.reverse ? controller.offset * -1 : controller.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          top: widget.top == null
              ? MediaQuery.of(context).size.height * 0.1 -
                  offset * widget.expandTimes
              : widget.top - offset * widget.expandTimes,
          left: widget.left == null
              ? MediaQuery.of(context).size.width * 0.08
              : widget.left,
          child: offset < MediaQuery.of(context).size.height * 0.1
              ? Container(
                  width: 120,
                  height: widget.reverse
                      ? math.max(offset + 120, 0)
                      : math.max(120 - offset, 0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: widget.border == null
                          ? Border.all(color: Colors.white, width: 1)
                          : widget.border,
                      image: DecorationImage(
                          image: widget.image == null
                              ? AssetImage("assets/avatars/me.jpg")
                              : widget.image)),
                )
              : Text(""),
        ),
      ],
    );
  }
}
