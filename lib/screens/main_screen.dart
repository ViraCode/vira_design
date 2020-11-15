import 'package:flutter/material.dart';
import 'package:vira_design/screens/animation_ui/flight_survey.dart';
import 'package:vira_design/screens/chat/simple_chat.dart';
import 'package:vira_design/screens/about/card_about.dart';
import 'package:vira_design/screens/animation_ui/drawer_2d.dart';
import 'package:vira_design/screens/backdrop/backdrop_sample.dart';
// import 'package:vira_design/screens/backdrop/custom_backdrop.dart';
import 'package:vira_design/screens/bottom_navigation_bars/convex_bottom_navigation_bar.dart';
import 'package:vira_design/screens/buttons/buttons.dart';
import 'package:vira_design/screens/customs/blur_image.dart';
import 'package:vira_design/screens/dialog_box/custom_dialog_box.dart';
import 'package:vira_design/screens/product_page/sliver_product.dart';
import 'package:vira_design/screens/product_page/sliver_stacked_product.dart';
import 'package:vira_design/screens/profile/animated_profile.dart';
import 'package:vira_design/screens/settings/sectioned_settings_with_profile.dart';
import 'dart:core';
import 'package:flutter/cupertino.dart';

import 'animation_ui/drawer_3d.dart';
import 'customs/team_task_management.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class Weed {
  final String name;
  final String route;

  Weed({this.name, this.route});
}

class _MainScreenState extends State<MainScreen> {
  var textcon = new TextEditingController();
  Map<String, List> pages = {
    "Animations": [
      Weed(name: Drawer2d.name, route: Drawer2d.route),
      Weed(name: Drawer3d.name, route: Drawer3d.route),
      Weed(name: FlightSurvey.name, route: FlightSurvey.route)
    ],
    "Custom Screens": [
      Weed(name: TeamTaskManagement.name, route: TeamTaskManagement.route),
      Weed(name: BlurImage.name, route: BlurImage.route)
    ],
    "Profile Page": [
      Weed(name: AnimatedProfile.name, route: AnimatedProfile.route)
    ],
    "Shopping": [
      Weed(name: SliverProductPage.name, route: SliverProductPage.route),
      Weed(name: SliverStackedProduct.name, route: SliverStackedProduct.route),
    ],
    "Components": [
      Weed(name: ButtonPage.name, route: ButtonPage.route),
      Weed(
          name: ConvexBottomNavigationBar.name,
          route: ConvexBottomNavigationBar.route),
      Weed(name: BackDropSmaple.name, route: BackDropSmaple.route),
      Weed(name: CustomDialogBox.name, route: CustomDialogBox.route)
    ],
    "About": [
      Weed(name: CardAbout.name, route: CardAbout.route),
    ],
    "Settings": [
      Weed(
          name: SectionedSettinsWithProfile.name,
          route: SectionedSettinsWithProfile.route)
    ],
    "Chat Screens": [
      Weed(name: SimpleChat.name, route: SimpleChat.route),
    ],
  };

  @override
  void initState() {
    print(pages["Chat Screens"][0].name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(00, 13, 40, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(00, 13, 40, 1),
        title: Text("VIRA Design",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Open Sans",
              fontWeight: FontWeight.w800,
            )),
      ),
      body: InteractiveViewer(
          constrained: false,
          // scaleEnabled: false,
          minScale: 0.1,
          maxScale: 40,
          child: Table(
            columnWidths: <int, TableColumnWidth>{
              for (int column = 0; column < 20; column += 1)
                column: const FixedColumnWidth(200.0),
            },
            children: [
              TableRow(children: [
                ...pages.entries.map((entry) => KeyBuilder(value: entry.key))
              ]),
              for (int i = 0; i < 15; i++)
                TableRow(children: [
                  ...pages.entries.map((entry) => entry.value.length > i
                      ? ItemBuilder(
                          value: entry.value[i],
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.all(10),
                        ))
                ])
            ],
          )),
    );
  }
}

class KeyBuilder extends StatefulWidget {
  final value;

  KeyBuilder({Key key, this.value}) : super(key: key);
  @override
  _KeyBuilderState createState() => _KeyBuilderState();
}

class _KeyBuilderState extends State<KeyBuilder> {
  var value;
  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1),
          boxShadow: [
            BoxShadow(blurRadius: 5, spreadRadius: 1, color: Colors.white)
          ],
          color: Colors.white,
        ),
        child: Text(
          value,
        ));
  }
}

class ItemBuilder extends StatefulWidget {
  final value;

  ItemBuilder({Key key, this.value}) : super(key: key);
  @override
  _ItemBuilderState createState() => _ItemBuilderState();
}

class _ItemBuilderState extends State<ItemBuilder>
    with SingleTickerProviderStateMixin {
  var value;
  Animation anim;
  double spread = 10;

  AnimationController controller;
  @override
  void initState() {
    value = widget.value;
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    anim = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    onInit();
  }

  onInit() {
    setState(() {
      controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedBuilder(
        animation: anim,
        builder: (_, child) => Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              border: Border.all(color: Colors.black, width: 1),
              boxShadow: [
                BoxShadow(
                    blurRadius: spread * controller.value + 3,
                    spreadRadius: 1 + spread * controller.value,
                    color: Colors.blue)
              ],
              color: Colors.white,
            ),
            child: child),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Text(
            value.name,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTapCancel: () {
        setState(() {
          controller.reverse();
        });
      },
      onTapUp: (_) {
        Navigator.pushNamed(context, "${value.route}");
        setState(() {
          controller.reverse();
        });
      },
      onTapDown: (T) {
        setState(() {
          controller.forward();
        });
      },
    );
  }
}
