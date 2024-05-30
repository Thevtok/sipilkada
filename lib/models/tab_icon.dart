
import 'package:flutter/cupertino.dart';

class TabIconData {
  TabIconData({
  
    this.index = 0,
    required this.icon,
    required this.selectedIcon,
    this.isSelected = false,
    this.animationController,
  });

  final IconData icon;
  final IconData selectedIcon;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      icon: CupertinoIcons.house,
      selectedIcon: CupertinoIcons.house_fill,
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    // TabIconData(
    //   imagePath: 'assets/images/tab_2.png',
    //   selectedImagePath: 'assets/images/tab_2s.png',
    //   index: 1,
    //   isSelected: false,
    //   animationController: null,
    // ),
    // TabIconData(
    //   imagePath: 'assets/images/tab_3.png',
    //   selectedImagePath: 'assets/images/tab_3s.png',
    //   index: 2,
    //   isSelected: false,
    //   animationController: null,
    // ),
    TabIconData(
      icon: CupertinoIcons.person,
      selectedIcon: CupertinoIcons.person_fill,
      index: 1,
      isSelected: false,
      animationController: null,
    ),
  ];
}