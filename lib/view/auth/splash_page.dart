// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/auth/role_page.dart';
import 'package:flutter_application_1/view/home/home_page.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  final bool isLoggedIn;

  const SplashPage({
    Key? key,
    required this.isLoggedIn,
  }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Tentukan durasi tampilan berdasarkan status login
    const splashDuration = Duration(seconds: 3);
    Future.delayed(splashDuration, () {
      if (widget.isLoggedIn) {
        // Jika sudah login, navigasi ke halaman home
        Get.off(() => const HomePage());
      } else {
        // Jika belum login, navigasi ke halaman login
        Get.off(() => const RolePage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Scaffold(
          backgroundColor: Colors.white,
        ),
        Center(
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Image.asset("assets/images/body.png"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 50.0, top: 50.0, right: 50.0, bottom: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset("assets/images/header.png",
                    fit: BoxFit.fill, width: 275, height: 275),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset("assets/images/logo_cm.png",
                    width: 75, height: 70),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset("assets/images/logo_kode.png",
                    width: 120, height: 70),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
