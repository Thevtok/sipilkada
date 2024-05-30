// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home/home_bar.dart';
import 'package:flutter_application_1/view/konstituen/add_konstituen.dart';
import 'package:flutter_application_1/view/profile/profile_page.dart';
import 'package:get/get.dart';

import '../../models/tab_icon.dart';
import '../bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  Widget tabBody = const HomeBar();

  @override
  void initState() {
    super.initState();
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          tabBody,
          bottomBar(),
        ],
      ),
    );
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            Get.to(() => const AddKonstituenPage());
          },
          changeIndex: (int index) {
            if (index == 0) {
              setState(() {
                tabBody = const HomeBar();
              });
            } else if (index == 1) {
              setState(() {
                tabBody = const ProfilePage();
              });
            }
            // else if (index == 2) {
            //   setState(() {

            //     tabBody = const HomeBar();
            //   });
            // } else if (index == 3) {
            //   setState(() {

            //     tabBody = const ProfilePage();
            //   });
            // }
          },
        ),
      ],
    );
  }
}
