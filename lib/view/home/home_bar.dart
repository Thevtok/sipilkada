// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/profile.dart';
import 'package:flutter_application_1/view/demografi/demografi.dart';
import 'package:flutter_application_1/view/kampanye/kampanye.dart';
import 'package:flutter_application_1/view/statistik/statistik.dart';
import 'package:flutter_application_1/view/web/web.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/theme.dart';
import '../../utils/data_user.dart';
import '../konstituen/konstituen_item.dart';
import '../theme.dart';

class HomeBar extends StatefulWidget {
  const HomeBar({super.key});

  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  final profile = Get.put(ProfileService());
  final ThemeController themeController = Get.put(ThemeController());

  @override
  void initState() {
    super.initState();
    profile.fetchUserFromSharedPreferences();
    // profile.getCakada();
  }

  String capitalize(String s) {
    if (s.isEmpty) {
      return '';
    }
    return s.substring(0, 1).toUpperCase() + s.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final userData = profile.userData.value;
      return Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                getAppBarUI(),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GreetingWidget(
                        nama: capitalize(userData?.name ?? ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 22),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(1), // Border radius
                            child: CachedNetworkImage(
                              height: 140,
                              width: 100,
                              imageUrl: userData?.avatar ?? '',
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey,
                                direction: ShimmerDirection.ltr,
                                child: const Card(
                                  color: Colors.grey,
                                ),
                              ), // Placeholder saat gambar dimuat
                              errorWidget: (context, url, error) => ClipOval(
                                child: Image.asset('assets/images/nopicprof.png'),
                              ), // Widget yang ditampilkan jika terjadi error
                              fit: BoxFit.cover,
                              imageBuilder: (context, imageProvider) => ClipOval(
                                // borderRadius:
                                //     const BorderRadius.all(Radius.circular(10.0)),
                                child: Image(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const KampanyePage(),
                          transition: Transition.rightToLeft);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.1), // Warna bayangan
                            spreadRadius: 5, // Radius penyebaran bayangan
                            blurRadius: 7, // Radius blur bayangan
                            offset: const Offset(
                                0, 3), // Geser bayangan (horizontal, vertical)
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(5), // borde width

                            child: Image.asset("assets/images/icon_program.png",
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width:
                                    MediaQuery.of(context).size.width * 0.15),
                          ),
                          Text('Program Kampanye',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    mainMenuIcon(
                      ontap: () {
                        Get.to(() => DemografiPage(),
                            transition: Transition.rightToLeft);
                      },
                      context: context,
                      src: "assets/images/icon_demografi.png",
                      text: "DEMOGRAFI",
                    ),
                    mainMenuIcon(
                      ontap: () {
                        Get.to(() => KonstituenPage(),
                            transition: Transition.rightToLeft);
                      },
                      context: context,
                      src: "assets/images/icon_konstituen.png",
                      text: "KONSTITUEN",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    mainMenuIcon(
                      ontap: () async {
                        final token = await getTokenFromSharedPreferences();
                        Get.to(
                            () => WebPage(
                                  token: token ?? '',
                                ),
                            transition: Transition.rightToLeft);
                      },
                      context: context,
                      src: "assets/images/icon_dashboard.png",
                      text: "WEB\nDASHBOARD",
                    ),
                    mainMenuIcon(
                      ontap: () {
                        Get.to(() => const StatistikPage(),
                            transition: Transition.rightToLeft);
                      },
                      context: context,
                      src: "assets/images/icon_chart.png",
                      text: "STATISTIK \nPEMENANGAN",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Versi 1.0.3',
                    style: Theme.of(context).textTheme.displayMedium),
              ],
            ),
          ),
        ],
      );
    });
  }

  // Widget getAppBarUI(BuildContext context) {
  //   return Obx(() {
  //     final userData = profile.userData.value;

  //     return Container(
  //       height: MediaQuery.of(context).size.height * 0.22,
  //       decoration: const BoxDecoration(
  //         borderRadius: BorderRadius.only(
  //           bottomLeft: Radius.circular(50),
  //           bottomRight: Radius.circular(50),
  //         ),
  //       ),
  //       child: Column(
  //         children: [
  //           const SizedBox(
  //             height: 20,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(20),
  //             child: Image.asset(
  //               'assets/images/sipp_head2.png',
  //               height: 40,
  //               width: 250,
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(10),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 Column(
  //                   children: [
  //                     const GreetingWidget(),
  //                     const SizedBox(
  //                       height: 5,
  //                     ),
  //                     Text(
  //                       userData?.name ?? '',
  //                       style: const TextStyle(
  //                         fontFamily: AppTheme.fontName,
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.bold,
  //                         color: AppTheme.mainColor,
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //                 CircleAvatar(
  //                   radius: 35,
  //                   backgroundColor: Colors.white,
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(1), // Border radius
  //                     child: CachedNetworkImage(
  //                       height: 140,
  //                       width: 100,
  //                       imageUrl: userData?.avatar ?? '',
  //                       placeholder: (context, url) => Shimmer.fromColors(
  //                         baseColor: Colors.grey.shade300,
  //                         highlightColor: Colors.grey,
  //                         direction: ShimmerDirection.ltr,
  //                         child: const Card(
  //                           color: Colors.grey,
  //                         ),
  //                       ), // Placeholder saat gambar dimuat
  //                       errorWidget: (context, url, error) => ClipOval(
  //                         child: Image.asset('assets/images/nopicprof.png'),
  //                       ), // Widget yang ditampilkan jika terjadi error
  //                       fit: BoxFit.cover,
  //                       imageBuilder: (context, imageProvider) => ClipOval(
  //                         // borderRadius:
  //                         //     const BorderRadius.all(Radius.circular(10.0)),
  //                         child: Image(
  //                           image: imageProvider,
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  // }

  Widget getAppBarUI() {
    return Stack(
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24.0),
              bottomRight: Radius.circular(24.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: AppTheme.grey.withOpacity(0.4),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 8.0),
                          child: CircleAvatar(
                            child: Image.asset('assets/images/sipp_head2.png'),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          top: 25,
          child: IconButton(
            icon: themeController.isDarkMode.value
                ? const Icon(
                    Icons.wb_sunny,
                    size: 30,
                  )
                : const Icon(
                    Icons.nightlight_round,
                    size: 30,
                  ),
            onPressed: () {
              themeController.toggleTheme();
            },
          ),
        )
      ],
    );
  }

  Widget mainMenuIcon(
      {required BuildContext context,
      required String text,
      required String src,
      required VoidCallback ontap}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: ontap,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.17,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).appBarTheme.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1), // Warna bayangan
                spreadRadius: 5, // Radius penyebaran bayangan
                blurRadius: 7, // Radius blur bayangan
                offset:
                    const Offset(0, 3), // Geser bayangan (horizontal, vertical)
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(5), // borde width

                child: Image.asset(src,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.15),
              ),
              const SizedBox(height: 5),
              Text(text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class GreetingWidget extends StatelessWidget {
  final String nama;
  const GreetingWidget({super.key, required this.nama});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan waktu saat ini
    var now = DateTime.now();
    var timeOfDay = now.hour;

    // Menentukan ucapan berdasarkan waktu
    String greeting = '';
    if (timeOfDay >= 0 && timeOfDay < 12) {
      greeting = 'Selamat pagi';
    } else if (timeOfDay >= 12 && timeOfDay < 18) {
      greeting = 'Selamat siang';
    } else {
      greeting = 'Selamat malam';
    }

    return Padding(
      padding: const EdgeInsets.only(left: 22,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(greeting, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(
            height: 3,
          ),
          Text(nama, style: Theme.of(context).textTheme.bodyMedium)
        ],
      ),
    );
  }
}
