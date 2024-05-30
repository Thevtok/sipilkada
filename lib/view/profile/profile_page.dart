// ignore_for_file: avoid_print, use_build_context_synchronously, unused_element

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/profile.dart';

import 'package:flutter_application_1/view/auth/splash_page.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/theme.dart';
import '../../utils/auth.dart';
import '../home/home_page.dart';
import '../statistik/app_colors.dart';
import '../theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final profile = Get.put(ProfileService());
  final ThemeController themeController = Get.put(ThemeController());

  @override
  void initState() {
    super.initState();
    profile.fetchUserFromSharedPreferences();
  }

  String capitalize(String s) {
    if (s.isEmpty) {
      return '';
    }
    return s.substring(0, 1).toUpperCase() + s.substring(1).toLowerCase();
  }
// final user = profile.userData.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.fromLTRB(10, 85, 10, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 56,
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(1), // Border radius
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      profile.userData.value?.avatar ?? '',
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey,
                                    direction: ShimmerDirection.ltr,
                                    child: const Card(
                                      color: Colors.grey,
                                    ),
                                  ), // Placeholder saat gambar dimuat
                                  errorWidget: (context, url, error) => Image.asset(
                                      'assets/images/nopicprof.png'), // Widget yang ditampilkan jika terjadi error
                                  fit: BoxFit.cover,
                                  imageBuilder: (context, imageProvider) =>
                                      ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    child: Image(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Positioned(
                          //     top: 66,
                          //     right: 16,
                          //     child: InkWell(
                          //       onTap: () {
                          //         // _showImagePickerBottomSheet();
                          //       },
                          //       borderRadius: const BorderRadius.all(
                          //         Radius.circular(32.0),
                          //       ),
                          //       child: Container(
                          //         decoration: const BoxDecoration(
                          //           color: AppTheme.nearlyBlue,
                          //           borderRadius: BorderRadius.all(
                          //               Radius.circular(20.0)),
                          //         ),
                          //         child: const Padding(
                          //           padding: EdgeInsets.all(8.0),
                          //           child: Icon(
                          //             Icons.edit,
                          //             color: AppTheme.nearlyWhite,
                          //           ),
                          //         ),
                          //       ),
                          //     ))
                        ],
                      ),
                      Text(capitalize(profile.userData.value?.name ?? ''),
                          style: Theme.of(context).textTheme.displayLarge),
                      const SizedBox(height: 4),
                      Text(profile.userData.value?.email ?? '',
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          )),
                      const SizedBox(height: 10),
                      Center(
                          child: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: AppTheme.mainColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                // boxShadow: <BoxShadow>[
                                //   BoxShadow(
                                //       color: Colors.grey.shade200,
                                //       offset: const Offset(2, 4),
                                //       blurRadius: 5,
                                //       spreadRadius: 2)
                                // ],
                              ),
                              child: Text(
                                  capitalize(
                                      profile.userData.value?.subscription ??
                                          ''),
                                  style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.contentColorWhite,
                                  )))),
                      const SizedBox(height: 5.0),
                      buildCustomContainer(
                          context: context,
                          title: 'Ulas Aplikasi',
                          onTap: () {
                            openBrowser(
                                'https://play.google.com/store/apps/details?id=com.sippilkada2024&pli=1');
                          }),
                      const SizedBox(height: 5.0),
                      buildCustomContainer(
                          context: context,
                          title: 'Syarat & Ketentuan',
                          onTap: () {
                            openBrowser(
                                "http://sipp2024.id/tcpp/terms-and-conditions-sippilkada-2024.html");
                          }),
                      const SizedBox(height: 5.0),
                      // buildCustomContainer(
                      //     context: context, title: 'Panduan', onTap: () {}),
                      // const SizedBox(height: 5.0),
                      buildCustomContainer(
                          context: context,
                          title: 'Kebijakan Privasi',
                          onTap: () {
                            openBrowser(
                                "http://sipp2024.id/tcpp/privacy-policy-sippilkada-2024.html");
                          }),
                      const SizedBox(height: 5.0),
                      buildCustomContainer(
                          context: context,
                          title: 'Kontak',
                          onTap: () {
                            openBrowser('https://wa.me/628174908009');
                          }),
                      const SizedBox(height: 30),
                      // buildCustomContainer(
                      //     context: context,
                      //     title: 'Layanan Aplikasi',
                      //     onTap: () {}),

                      // const Align(
                      //   alignment: Alignment.topLeft,
                      //   child: Padding(
                      //     padding: EdgeInsets.only(
                      //         left: 7.5, top: 0.0, right: 10.0, bottom: 5.0),
                      //     child: Text(
                      //       "Versi 1.0.3",
                      //       style: TextStyle(fontWeight: FontWeight.w500),
                      //     ),
                      //   ),
                      // ),
                      Container(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5.0, top: 10.0, bottom: 5.0),
                          child: Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                color: AppTheme.mainColor,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: AppTheme.grey.withOpacity(0.3),
                                      offset: const Offset(1.1, 1.1),
                                      blurRadius: 7.5),
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 15,
                                        bottom: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () async {
                                                saveAuthentication(false);
                                                // await removeUserFromSharedPreferences();
                                                // ref
                                                //     .read(
                                                //         pageIndexProvider
                                                //             .notifier)
                                                //     .setPageIndex(0);
                                                profile.userData.value = null;
                                                Get.offAll(
                                                    () => const SplashPage(
                                                          isLoggedIn: false,
                                                        ));
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Keluar",
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors
                                                        .contentColorWhite,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ])),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        getAppBarUI(),
      ],
    ));
  }

  openBrowser(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch((url))) {
      // ignore: deprecated_member_use
      await launch(url, forceWebView: false, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  _showConfirmationDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Konfirmasi',
            style: TextStyle(
              fontFamily: AppTheme.fontName,
              fontWeight: FontWeight.w700,
              fontSize: 22,
              letterSpacing: 1.2,
              color: AppTheme.mainColor,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Apakah Anda yakin ingin mengganti foto profile?'),
                const SizedBox(height: 20),
                if (profile.fotoProfile.value != null)
                  Image.file(profile.fotoProfile.value!),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () async {
                Navigator.of(context).pop();
                showProcessingDialog(context);
                final berhasil = await profile.addFoto();
                if (berhasil) {
                  showCongratulationsDialog(
                      'Anda telah berhasil menambah data');
                } else {
                  showFailedDialog(profile.errorFoto.value);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showFailedDialog(
    String message,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Gagal"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                message,
                style: const TextStyle(
                    fontSize: 18,
                    fontFamily: AppTheme.fontName,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();

                // Lakukan navigasi atau tindakan lain jika diperlukan.
              },
              child: const Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  void showCongratulationsDialog(
    String message,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text("Selamat"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: AppTheme.fontName,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Get.offAll(const HomePage());
                },
                child: const Text("Tutup"),
              ),
            ]);
      },
    );
  }

  void showProcessingDialog(BuildContext context) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          content: Container(
            width: 250.0,
            height: 100.0,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircularProgressIndicator(),
                Align(
                  alignment: Alignment.center,
                  child: Text("  Mohon Tunggu..."),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showImagePickerBottomSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Kamera'),
              onTap: () {
                Navigator.pop(context); // Tutup bottom sheet
                _getImageFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeri'),
              onTap: () {
                Navigator.pop(context); // Tutup bottom sheet
                _getImageFromGallery();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File selectedImage = File(pickedFile.path);
      int pickedFileSize = await selectedImage.length();
      print('Ukuran pickedFile: $pickedFileSize bytes');

      final result = await FlutterImageCompress.compressAndGetFile(
        selectedImage.absolute.path,
        '${selectedImage.path}compressed.jpg',
        quality: 90,
        minHeight: 1920,
        minWidth: 1080,
      );

      int compressedFileSize = await result!.length();
      print('Ukuran compressed result: $compressedFileSize bytes');

      final last = File(result.path);
      setState(() {
        profile.fotoProfile.value = last;
      });

      _showConfirmationDialog();
    } else {
      // Tidak ada gambar yang dipilih
    }
  }

  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File selectedImage = File(pickedFile.path);

      int pickedFileSize = await selectedImage.length();
      print('Ukuran pickedFile: $pickedFileSize bytes');

      final result = await FlutterImageCompress.compressAndGetFile(
        selectedImage.absolute.path,
        '${selectedImage.path}compressed.jpg',
        quality: 90,
        minHeight: 1920,
        minWidth: 1080,
      );

      int compressedFileSize = await result!.length();
      print('Ukuran compressed result: $compressedFileSize bytes');

      final last = File(result.path);
      setState(() {
        profile.fotoProfile.value = last;
      });

      _showConfirmationDialog();
    } else {
      // Tidak ada gambar yang dipilih
    }
  }

  Widget _buildShimmerEffect() {
    return Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              10,
              (index) => Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 16, bottom: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 25.0,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey,
                                    direction: ShimmerDirection.ltr,
                                    child: const Card(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Row(children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 90.0,
                                            height: 20.0,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor: Colors.grey,
                                              direction: ShimmerDirection.ltr,
                                              child: const Card(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 110.0,
                                            height: 25.0,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor: Colors.grey,
                                              direction: ShimmerDirection.ltr,
                                              child: const Card(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.9,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 90.0,
                                            height: 20.0,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor: Colors.grey,
                                              direction: ShimmerDirection.ltr,
                                              child: const Card(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 110.0,
                                            height: 25.0,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor: Colors.grey,
                                              direction: ShimmerDirection.ltr,
                                              child: const Card(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ]),
                                  )
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

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

  Widget buildCustomContainer({
    required BuildContext context,
    required String title,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(
            left: 5.0, right: 5.0, top: 10.0, bottom: 2.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: Theme.of(context).appBarTheme.backgroundColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppTheme.grey.withOpacity(0.3),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 7.5,
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.70,
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  title,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.13,
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.chevron_right,
                                color:Theme.of(context).indicatorColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
