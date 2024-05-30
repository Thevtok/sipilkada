import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/auth/login_page.dart';
import 'package:flutter_application_1/view/auth/login_timses.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../statistik/app_colors.dart';
import '../theme.dart';

class RolePage extends StatefulWidget {
  const RolePage({super.key});

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            _title(),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            _submitButton('CAKADA', () {
              Get.to(() => const LoginPage());
            }, AppTheme.mainColor, AppTheme.mainColor),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 1.0, // Ketebalan garis
                  width: MediaQuery.of(context).size.width * 0.3,
                  color:
                      AppTheme.deactivatedText.withOpacity(0.5), // Warna garis
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "atau",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                Container(
                  height: 1.0, // Ketebalan garis
                  width: MediaQuery.of(context).size.width * 0.3,
                  color:
                      AppTheme.deactivatedText.withOpacity(0.5), // Warna garis
                ),
              ],
            ),
            const SizedBox(height: 10),
            _submitButton('TIMSES', () {
              Get.to(() => const LoginTimses());
            }, AppTheme.utama, AppTheme.utama),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0),
              padding: const EdgeInsets.all(2.5),
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Versi 1.0.3',
                        style: Theme.of(context).textTheme.displayMedium,
                      )),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Dengan menggunakan aplikasi ini, anda setuju atas ',
                          style: Theme.of(context).textTheme.titleMedium)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () async {
                          openBowser(
                              "http://sipp2024.id/tcpp/terms-and-conditions-sippilkada-2024.html");
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Syarat, Ketentuan",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue[600]),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                       Text(' dan ',
                          style: Theme.of(context).textTheme.titleMedium),
                      InkWell(
                        onTap: () async {
                          openBowser(
                              "http://sipp2024.id/tcpp/privacy-policy-sippilkada-2024.html");
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Kebijakan Privasi",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue[600]),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _submitButton(
      String title, VoidCallback onTap, Color color1, Color color2) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 15),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                  Radius.circular(AppTheme.borderRadius)),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color1, color2])),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.contentColorWhite,
              ),
            ),
          )),
    );
  }

  Widget _title() {
    return SizedBox(
      height: 100,
      width: 300,
      child: Image.asset('assets/images/sipp_head2.png'),
    );
  }
}

openBowser(String url) async {
  // ignore: deprecated_member_use
  if (await canLaunch((url))) {
    // ignore: deprecated_member_use
    await launch(url, forceWebView: false, enableJavaScript: true);
  } else {
    throw 'Could not launch $url';
  }
}
