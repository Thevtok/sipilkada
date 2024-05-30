// ignore_for_file: no_leading_underscores_for_local_identifiers, must_be_immutable, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/konstituen.dart';
import 'package:flutter_application_1/services/update_dpt.dart';
import 'package:flutter_application_1/view/home/home_page.dart';
import 'package:flutter_application_1/view/konstituen/detail_konstituen.dart';
import 'package:flutter_application_1/view/konstituen/search_konstituen.dart';
import 'package:flutter_application_1/view/statistik/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';

class KonstituenPage extends StatelessWidget {
  KonstituenPage({super.key});
  Color warnakategori = Colors.transparent;
  String markName = '';
  final dptService = Get.put(DPTService());
  final dpt = Get.put(UpdateMarkingService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Konstituen',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.displayLarge),
              IconButton(
                onPressed: () {
                  Get.to(() => const SearchKonstituenPage(),
                      transition: Transition.rightToLeft);
                },
                icon: const Icon(FontAwesomeIcons.filter, size: 15),
              )
            ],
          ),
        ),
        body: Obx(() {
          final konstituenList = dptService.konstituenList;

          return Stack(
            children: [
              ListView.builder(
                controller: dptService.scrollController,
                itemCount: konstituenList.length,
                itemBuilder: (context, index) {
                  final konstituen = konstituenList[index];
                  if (konstituen.markId == 1) {
                    warnakategori = AppColors.contentColorGreen;
                    markName = 'Tinggi';
                  } else if (konstituen.markId == 2) {
                    warnakategori = AppColors.contentColorOrange;
                    markName = 'Sedang';
                  } else if (konstituen.markId == 3) {
                    warnakategori = AppColors.contentColorRed;
                    markName = 'Rendah';
                  }

                  return Container(
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, top: 5.0, bottom: 5.0),
                      child: SingleChildScrollView(
                          child: Column(children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(24.0),
                                    topRight: Radius.circular(24.0),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(CupertinoIcons.eye),
                                      title: const Text(
                                        'Lihat Detail Data Konstituen',
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        dpt.kkController.text =
                                            konstituen.nkk ?? '';
                                        dpt.nikController.text =
                                            konstituen.nik ?? '';
                                        dpt.nameController.text =
                                            konstituen.nama ?? '';
                                        dpt.phoneController.text =
                                            konstituen.handphone ?? '';
                                        dpt.emailController.text =
                                            konstituen.email ?? '';
                                        dpt.igController.text =
                                            konstituen.akunInstagram ?? '';
                                        dpt.ttController.text =
                                            konstituen.akunTiktok ?? '';
                                        dpt.fbController.text =
                                            konstituen.akunFacebook ?? '';
                                        dpt.xController.text =
                                            konstituen.akunTwitter ?? '';
                                        dpt.tempatController.text =
                                            konstituen.tempatLahir ?? '';
                                        dpt.dateController.text =
                                            konstituen.tanggalLahir ?? '';
                                        dpt.addressController.text =
                                            konstituen.alamat ?? '';
                                        dpt.rtController.text =
                                            konstituen.noRt ?? '';
                                        dpt.rwController.text =
                                            konstituen.noRw ?? '';
                                        dpt.ketController.text =
                                            konstituen.ket ?? '';
                                        dpt.tpsController.text =
                                            konstituen.tps ?? '';
                                        dpt.provController.text =
                                            konstituen.namaProvinsi ?? '';
                                        dpt.kabController.text =
                                            konstituen.namaKabupaten ?? '';
                                        dpt.kecController.text =
                                            konstituen.namaKecamatan ?? '';
                                        dpt.kelController.text =
                                            konstituen.namaKelurahan ?? '';

                                        dpt.agamaController.text =
                                            konstituen.agamaName ?? '';
                                        dpt.difabelController.text =
                                            konstituen.difabelName ?? '';
                                        dpt.pendidikanController.text =
                                            konstituen.pendidikanName ?? '';

                                        // final defaultKawin =
                                        //     konstituen.kawin ?? 'B';
                                        // final defaultKelamin =
                                        //     konstituen.jenisKelamin ?? 'L';
                                        // final defaultKategori =
                                        //     konstituen.markName ??
                                        //         'RENDAH';
                                        dpt.agamaId.value =
                                            konstituen.agamaId ?? 1;
                                        dpt.profesiId.value =
                                            konstituen.profesiId ?? 1;
                                        dpt.pendidikanId.value =
                                            konstituen.pendidikanId ?? 1;
                                        dpt.difabelId.value =
                                            konstituen.difabelId ?? 1;

                                        // dpt.provId.value =
                                        //     int.tryParse(konstituen.idProvinsi)??33;
                                        // dpt.kabId.value =
                                        //     konstituen.idKabupaten;
                                        // dpt.kecId.value =
                                        //     konstituen.idKecamatan;
                                        // dpt.kelId.value =
                                        //     konstituen.idKelurahan;

                                        Future.delayed(Duration.zero, () {
                                          // dpt.nikah.value = defaultKawin;
                                          // dpt.kelamin.value = defaultKelamin;
                                          // dpt.kategori.value = defaultKategori;
                                        });
                                        Get.to(() =>
                                            DetailKonstituenPage(konstituen));
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                          CupertinoIcons.person_fill),
                                      title: const Text(
                                        'Jadikan Tinggi',
                                      ),
                                      onTap: () {
                                        _showConfirmationDialog(
                                            context, 'Tinggi', () async {
                                          showProcessingDialog(context);
                                          final berhasil = await dptService
                                              .marking(1, konstituen.nik!);
                                          if (berhasil) {
                                            showCongratulationsDialog(
                                                'Anda telah berhasil memarking data',
                                                context);
                                          } else {
                                            showFailedDialog(context,
                                                dptService.errorMarking.value);
                                          }
                                        });
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                          CupertinoIcons.person_fill),
                                      title: const Text(
                                        'Jadikan Sedang',
                                      ),
                                      onTap: () {
                                        _showConfirmationDialog(
                                            context, 'Sedang', () async {
                                          showProcessingDialog(context);
                                          final berhasil = await dptService
                                              .marking(2, konstituen.nik!);
                                          if (berhasil) {
                                            showCongratulationsDialog(
                                                'Anda telah berhasil memarking data',
                                                context);
                                          } else {
                                            showFailedDialog(context,
                                                dptService.errorMarking.value);
                                          }
                                        });
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                          CupertinoIcons.person_fill),
                                      title: const Text(
                                        'Jadikan Rendah',
                                      ),
                                      onTap: () {
                                        _showConfirmationDialog(
                                            context, 'Rendah', () async {
                                          showProcessingDialog(context);

                                          final berhasil = await dptService
                                              .marking(3, konstituen.nik!);
                                          if (berhasil) {
                                            showCongratulationsDialog(
                                                'Anda telah berhasil memarking data',
                                                context);
                                          } else {
                                            showFailedDialog(context,
                                                dptService.errorMarking.value);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).appBarTheme.backgroundColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppTheme.grey.withOpacity(0.3),
                                    offset: const Offset(1.1, 1.1),
                                    blurRadius: 2.0),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.5,
                                      right: 12.5,
                                      top: 12.5,
                                      bottom: 12.5),
                                  child: Row(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Container(
                                            height: 50,
                                            width: 50,
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/nopicprof.png"),
                                              ),
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  offset:
                                                      const Offset(1.1, 1.1),
                                                  blurRadius: 2,
                                                ),
                                              ],
                                            ),
                                            child: const CircleAvatar(
                                              radius: 35,
                                              backgroundImage: AssetImage(
                                                  "assets/images/nopicprof.png"),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                konstituen.nama ?? '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                konstituen.alamat ?? '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                            if (konstituen.markId != null)
                                              const SizedBox(height: 10),
                                            if (konstituen.markId != null)
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                    width: 150,
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: warnakategori,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  20)),
                                                    ),
                                                    child: Text(markName,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall)),
                                              ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      // IconButton(
                                      //   onPressed: () async {
                                      //     double latitudeD =
                                      //         double.parse(konstituen.LATITUDE);
                                      //     double longitudeD =
                                      //         double.parse(konstituen.LONGITUDE);
                                      //     openGoogleMaps(latitudeD, longitudeD);
                                      //   },
                                      //   icon: const Icon(Icons.location_history),
                                      //   iconSize: 35,
                                      // ),
                                      // InkWell(
                                      //   onTap: () {
                                      //     openWhatsApp(
                                      //         konstituen.handphone??'');
                                      //   },
                                      //   child: Container(
                                      //     height: 35,
                                      //     width: 35,
                                      //     decoration: const BoxDecoration(
                                      //         image: DecorationImage(
                                      //             image: AssetImage(
                                      //                 'assets/images/wa.png'))),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ])));
                },
              ),
              if (dptService.isLoading.value && dptService.currentPage > 1)
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: CircularProgressIndicator(
                    color: AppTheme.mainColor,
                  ),
                ),
              // // ShimmerEffect saat memuat data pertama kali
              if (dptService.isLoading.value && dptService.currentPage == 1)
                _buildShimmerEffect(context),
              if (konstituenList.isEmpty) _buildShimmerEffect(context),
            ],
          );
        }));
  }

  openWhatsApp(String url) async {
    String formattedPhoneNumber =
        url.startsWith('0') ? '62${url.substring(1)}' : url;

    // Menyusun URL WhatsApp
    String whatsappUrl = 'https://wa.me/$formattedPhoneNumber';
    // ignore: deprecated_member_use
    if (await canLaunch((whatsappUrl))) {
      // ignore: deprecated_member_use
      await launch(url, forceWebView: false, enableJavaScript: true);
    } else {
      return Get.defaultDialog(
          title: 'Gagal',
          titleStyle: const TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: AppColors.contentColorRed,
              fontWeight: FontWeight.w500),
          middleText: 'No tidak terdaftar',
          middleTextStyle: const TextStyle(
            fontSize: 18,
          ));
    }
  }

  Widget _buildShimmerEffect(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              10,
              (index) => Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
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

  Future _showConfirmationDialog(
      BuildContext context, String kategori, VoidCallback ontap) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Konfirmasi',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: Text(
            'Apa anda yakin kategori $kategori sudah benar ?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Tidak',
              ),
            ),
            TextButton(
              onPressed: () {
                ontap();
                // Navigator.of(context).pop();
                // Navigator.of(context).pop();
              },
              child: const Text(
                'Ya',
              ),
            ),
          ],
        );
      },
    );
  }

  void showFailedDialog(
    BuildContext context,
    String message,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Gagal",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(message, style: Theme.of(context).textTheme.displayMedium),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
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

  void showCongratulationsDialog(String message, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title:
                Text("Selamat", style: Theme.of(context).textTheme.bodyMedium),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(message, style: Theme.of(context).textTheme.displayMedium),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircularProgressIndicator(),
                Align(
                  alignment: Alignment.center,
                  child: Text("  Mohon Tunggu...",
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
