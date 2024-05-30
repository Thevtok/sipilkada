// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/konstituen.dart';
import 'package:flutter_application_1/services/search.dart';
import 'package:flutter_application_1/view/konstituen/detail_konstituen.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/update_dpt.dart';
import '../home/home_page.dart';
import '../statistik/app_colors.dart';
import '../theme.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({
    super.key,
  });

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  final dpt = Get.put(DPTService());

  final search = Get.put(SearchService());

  Color warnakategori = Colors.transparent;

  String markName = '';

  final updateDpt = Get.put(UpdateMarkingService());
  @override
  void initState() {
    super.initState();
    search.getDptSearch(
        search.nikController.text,
        search.kelamin.value,
        search.provController.text,
        search.kabController.text,
        search.kecController.text,
        search.kelController.text,
        search.nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            icon: const Icon(CupertinoIcons.clear)),
        elevation: 0,
        title: Text('Konstituen',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.displayLarge),
      ),
      body: Obx(() {
        final konstituens = search.konstituenListSearch;
        if (search.isLoading.value) {
          return _buildShimmerEffect(context);
        } else if (konstituens.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                'Anda belum memiliki data',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          );
        }

        return Stack(
          children: [
            ListView.builder(
              itemCount: konstituens.length,
              itemBuilder: (context, index) {
                final konstituen = konstituens[index];
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
                                    leading: const Icon(
                                        Icons.remove_red_eye_outlined),
                                    title: const Text(
                                        'Lihat Detail Data Konstituen',
                                        style: TextStyle(
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.w600)),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      updateDpt.kkController.text =
                                          konstituen.nkk ?? '';
                                      updateDpt.nikController.text =
                                          konstituen.nik ?? '';
                                      updateDpt.nameController.text =
                                          konstituen.nama ?? '';
                                      updateDpt.phoneController.text =
                                          konstituen.handphone ?? '';
                                      updateDpt.emailController.text =
                                          konstituen.email ?? '';
                                      updateDpt.igController.text =
                                          konstituen.akunInstagram ?? '';
                                      updateDpt.ttController.text =
                                          konstituen.akunTiktok ?? '';
                                      updateDpt.fbController.text =
                                          konstituen.akunFacebook ?? '';
                                      updateDpt.xController.text =
                                          konstituen.akunTwitter ?? '';
                                      updateDpt.tempatController.text =
                                          konstituen.tempatLahir ?? '';
                                      updateDpt.dateController.text =
                                          konstituen.tanggalLahir ?? '';
                                      updateDpt.addressController.text =
                                          konstituen.alamat ?? '';
                                      updateDpt.rtController.text =
                                          konstituen.noRt ?? '';
                                      updateDpt.rwController.text =
                                          konstituen.noRw ?? '';
                                      updateDpt.ketController.text =
                                          konstituen.ket ?? '';
                                      updateDpt.tpsController.text =
                                          konstituen.tps ?? '';
                                      updateDpt.provController.text =
                                          konstituen.namaProvinsi ?? '';
                                      updateDpt.kabController.text =
                                          konstituen.namaKabupaten ?? '';
                                      updateDpt.kecController.text =
                                          konstituen.namaKecamatan ?? '';
                                      updateDpt.kelController.text =
                                          konstituen.namaKelurahan ?? '';

                                      updateDpt.agamaController.text =
                                          konstituen.agamaName ?? '';
                                      updateDpt.difabelController.text =
                                          konstituen.difabelName ?? '';
                                      updateDpt.pendidikanController.text =
                                          konstituen.pendidikanName ?? '';

                                      final defaultKawin =
                                          konstituen.kawin ?? 'B';
                                      final defaultKelamin =
                                          konstituen.jenisKelamin ?? 'L';
                                      final defaultKategori =
                                          konstituen.markName ??
                                              'Keluarga Saksi';
                                      updateDpt.agamaId.value =
                                          konstituen.agamaId ?? 1;
                                      updateDpt.profesiId.value =
                                          konstituen.profesiId ?? 1;
                                      updateDpt.pendidikanId.value =
                                          konstituen.pendidikanId ?? 1;
                                      updateDpt.difabelId.value =
                                          konstituen.difabelId ?? 1;

// Membuat Future.delayed untuk menunda pemanggilan setState
                                      Future.delayed(Duration.zero, () {
                                        // Memperbarui state dengan nilai defaultKawin
                                        updateDpt.nikah.value = defaultKawin;
                                        updateDpt.kelamin.value =
                                            defaultKelamin;
                                        updateDpt.kategori.value =
                                            defaultKategori;
                                      });
                                      Get.to(() =>
                                          DetailKonstituenPage(konstituen));
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.people),
                                    title: const Text('Jadikan Tinggi',
                                        style: TextStyle(fontSize: 14.5)),
                                    onTap: () {
                                      _showConfirmationDialog(context, 'Tinggi',
                                          () async {
                                        showProcessingDialog(context);
                                        final berhasil = await dpt.marking(
                                            1, konstituen.nik!);
                                        if (berhasil) {
                                          showCongratulationsDialog(
                                              'Anda telah berhasil memarking data',
                                              context);
                                        } else {
                                          showFailedDialog(
                                              context, dpt.errorMarking.value);
                                        }
                                      });
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.people),
                                    title: const Text('Jadikan Sedang',
                                        style: TextStyle(fontSize: 14.5)),
                                    onTap: () {
                                      _showConfirmationDialog(context, 'Sedang',
                                          () async {
                                        showProcessingDialog(context);
                                        final berhasil = await dpt.marking(
                                            2, konstituen.nik!);
                                        if (berhasil) {
                                          showCongratulationsDialog(
                                              'Anda telah berhasil memarking data',
                                              context);
                                        } else {
                                          showFailedDialog(
                                              context, dpt.errorMarking.value);
                                        }
                                      });
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.people),
                                    title: const Text('Jadikan Rendah',
                                        style: TextStyle(fontSize: 14.5)),
                                    onTap: () {
                                      _showConfirmationDialog(context, 'Rendah',
                                          () async {
                                        showProcessingDialog(context);

                                        final berhasil = await dpt.marking(
                                            3, konstituen.nik!);
                                        if (berhasil) {
                                          showCongratulationsDialog(
                                              'Anda telah berhasil memarking data',
                                              context);
                                        } else {
                                          showFailedDialog(
                                              context, dpt.errorMarking.value);
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
                                                offset: const Offset(1.1, 1.1),
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
                                      width: MediaQuery.of(context).size.width *
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
                                                        const BorderRadius.all(
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
                                    //     openWhatsApp(konstituen.NO_HP);
                                    //   },
                                    //   child: Container(
                                    //     height: 35,
                                    //     width: 35,
                                    //     decoration: const BoxDecoration(
                                    //         image: DecorationImage(
                                    //             image:
                                    //                 AssetImage('assets/images/wa.png'))),
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

            // // ShimmerEffect saat memuat data pertama kali
          ],
        );
      }),
    );
  }

  Widget _buildShimmerEffect(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              8,
              (index) => Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
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
          title: const Text('Konfirmasi'),
          content: Text('Apa anda yakin kategori $kategori sudah benar ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                ontap();
                // Navigator.of(context).pop();
                // Navigator.of(context).pop();
              },
              child: const Text('Ya'),
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
          title: const Text("Gagal"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
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
}
