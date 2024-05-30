// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/demografi.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/demografi.dart';
import '../../models/users.dart';
import '../statistik/app_colors.dart';
import '../theme.dart';

class DemografiPage extends StatelessWidget {
  DemografiPage({super.key});

  final demo = Get.put(DemografiService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title:  Text(
            'Demografi',
            textAlign: TextAlign.left,
             style: Theme.of(context).textTheme.displayLarge
          ),
        ),
        body: Obx(() {
          final progress = demo.progressData.value;
          User? user = demo.userData.value;
          if (demo.isLoading.value) {
            return shimmerLoading(context);
          }
          if (progress != null) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16,top: 16,right: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 8, right: 8, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Column(children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          CachedNetworkImage(
                                            height: 140,
                                            width: 100,
                                            imageUrl: user?.avatar ?? '',
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor: Colors.grey,
                                              direction: ShimmerDirection.ltr,
                                              child: const Card(
                                                color: Colors.grey,
                                              ),
                                            ), // Placeholder saat gambar dimuat
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    'assets/images/nopicprof.png'), // Widget yang ditampilkan jika terjadi error
                                            fit: BoxFit.cover,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10.0)),
                                              child: Image(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          TitleCakada(
                                            name: user?.name,
                                            titile: user?.level_name,
                                            prov: user?.name_provinsi,
                                            kab: user?.name_kab_kota,
                                          )
                                        ],
                                      ),
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,top: 16,right: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
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
                      child: SfCircularChart(
                        tooltipBehavior: TooltipBehavior(
                          enable: true,
                          tooltipPosition: TooltipPosition.auto,
                          duration: 2 * 1000,
                        ),
                        title: ChartTitle(
                            text: 'Pemilih Berdasarkan Jenis Kelamin',
                            textStyle:Theme.of(context).textTheme.displaySmall,
                            alignment: ChartAlignment.center),
                        legend:  Legend(
                          textStyle:   Theme.of(context).textTheme.displaySmall,
                            isVisible: true,
                            iconHeight: 20,
                            iconWidth: 20,
                            isResponsive: true,
                            position: LegendPosition.right),
                        series: _getDefaultPieSeries(context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,top: 16,right: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                       
                      ),
                      child: SfCartesianChart(
                         title: ChartTitle(
                        text: 'Pemilih Disabilitas',
                        textStyle:Theme.of(context).textTheme.displaySmall,
                        alignment: ChartAlignment.center),
                        tooltipBehavior: TooltipBehavior(
                          enable: true,
                          tooltipPosition: TooltipPosition.auto,
                          duration: 2 * 1000,
                        ),
                        legend:  Legend(
                          isVisible: true,
                          iconHeight: 20,
                          iconWidth: 20,
                          isResponsive: true,
                           textStyle:Theme.of(context).textTheme.displaySmall,
                        ),
                        primaryXAxis: CategoryAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                        ),
                        primaryYAxis: NumericAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                        ),
                        series: _getDefaultBarSeries(context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,top: 16,right: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                      
                      ),
                      child: SfCartesianChart(
                         title: ChartTitle(
                        text: 'Pemilih Berdasarkan Usia',
                        textStyle:Theme.of(context).textTheme.displaySmall,
                        alignment: ChartAlignment.center),
                        tooltipBehavior: TooltipBehavior(
                          enable: true,
                          tooltipPosition: TooltipPosition.auto,
                          duration: 2 * 1000,
                        ),
                        legend:  Legend(
                          isVisible: true,
                          iconHeight: 20,
                          iconWidth: 20,
                          isResponsive: true,
                          textStyle: Theme.of(context).textTheme.displaySmall,
                        ),
                        primaryXAxis: CategoryAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                        ),
                        primaryYAxis: NumericAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                        ),
                        series: _getDefaultColumnSeries(context),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('Failed to fetch data');
          }
        }));
  }

  List<PieSeries<Gender, String>> _getDefaultPieSeries(BuildContext context) {
    Demografi? data = demo.progressData.value;

    // Hitung total konstituen keseluruhan
    int totalKonstituen = (data?.total_konstituen_male ?? 0) +
        (data?.total_konstituen_female ?? 0);

    // Hitung persentase untuk male dan female
    double percentMale =
        (data?.total_konstituen_male ?? 0) / totalKonstituen * 100;
    double percentFemale =
        (data?.total_konstituen_female ?? 0) / totalKonstituen * 100;

    return <PieSeries<Gender, String>>[
      PieSeries<Gender, String>(
        enableTooltip: true,
        dataSource: <Gender>[
          Gender(
            x: 'Laki-Laki',
            y: data?.total_konstituen_male,
            text: '${percentMale.toStringAsFixed(0)}%',
          ),
          Gender(
              x: 'Perempuan',
              y: data?.total_konstituen_female,
              text: '${percentFemale.toStringAsFixed(0)}%'),
        ],
        xValueMapper: (Gender data, _) => data.x,
        yValueMapper: (Gender data, _) => data.y,
        dataLabelMapper: (Gender data, _) => data.text,
        pointColorMapper: (Gender data, _) {
          // Menggunakan data untuk menentukan warna
          if (data.x == 'Laki-Laki') {
            return AppColors.contentColorBlue; // Warna biru untuk male
          } else {
            return AppColors.contentColorPink; // Warna merah muda untuk female
          }
        },
        startAngle: 90,
        endAngle: 90,
        dataLabelSettings:  DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.inside,
            textStyle:Theme.of(context).textTheme.bodySmall ),
      ),
    ];
  }

  List<BarSeries<Difabel, String>> _getDefaultBarSeries(BuildContext context) {
    Demografi? data = demo.progressData.value;
    return <BarSeries<Difabel, String>>[
      BarSeries<Difabel, String>(
        isVisibleInLegend: false,
        name: 'Difabel',
        dataSource: <Difabel>[
          Difabel(
            x: 'Tuna Daksa',
            y: data?.total_konstituen_tuna_daksa,
            text: 'Tuna Daksa',
          ),
          Difabel(
              x: 'Tuna Netra',
              y: data?.total_konstituen_tuna_netra,
              text: 'Tuna Netra'),
          Difabel(
            x: 'Tuna Rungu',
            y: data?.total_konstituen_tuna_rungu,
            text: 'Tuna Rungu',
          ),
          Difabel(
              x: 'Tuna Grahita',
              y: data?.total_konstituen_tuna_grahita,
              text: 'Tuna Grahita'),
          Difabel(
            x: 'Tuna Lainya',
            y: data?.total_konstituen_tuna_lainnya,
            text: 'Tuna Lainya',
          ),
        ],
        xValueMapper: (Difabel data, _) => data.x,
        yValueMapper: (Difabel data, _) => data.y,
        dataLabelMapper: (Difabel data, _) => data.y.toString(),
        pointColorMapper: (Difabel data, _) {
          // Menggunakan data untuk menentukan warna
          if (data.x == 'Tuna Daksa') {
            return AppColors.contentColorPink2; // Warna biru untuk male
          }
          if (data.x == 'Tuna Netra') {
            return AppColors.contentColorPink; // Warna biru untuk male
          }
          if (data.x == 'Tuna Rungu') {
            return AppColors.contentColorPink3; // Warna biru untuk male
          }
          if (data.x == 'Tuna Grahita') {
            return AppColors.contentColorPurple; // Warna biru untuk male
          } else {
            return AppColors
                .contentColorPurple2; // Warna merah muda untuk female
          }
        },
        dataLabelSettings:  DataLabelSettings(
            isVisible: true,
            textStyle:Theme.of(context).textTheme.displaySmall,),
      ),
    ];
  }

  List<ColumnSeries<Usia, String>> _getDefaultColumnSeries(BuildContext context) {
    Demografi? data = demo.progressData.value;
    return <ColumnSeries<Usia, String>>[
      ColumnSeries<Usia, String>(
        isVisibleInLegend: false,
        name: 'Usia',
        dataSource: <Usia>[
          Usia(
            x: '17-30',
            y: data?.total_konstituen_usia_17_30,
            text: '17-30',
          ),
          Usia(x: '31-40', y: data?.total_konstituen_usia_31_40, text: '31-40'),
          Usia(
            x: '41-50',
            y: data?.total_konstituen_usia_41_50,
            text: '41-50',
          ),
          Usia(x: '51-60', y: data?.total_konstituen_usia_51_60, text: '51-60'),
          Usia(
            x: '>60',
            y: data?.total_konstituen_usia_lebih_60,
            text: '>60',
          ),
        ],
        xValueMapper: (Usia data, _) => data.x,
        yValueMapper: (Usia data, _) => data.y,
        dataLabelMapper: (Usia data, _) => data.y.toString(),
        pointColorMapper: (Usia data, _) {
          // Menggunakan data untuk menentukan warna
          if (data.x == '17-30') {
            return AppColors.contentColorGreen5; // Warna biru untuk male
          }
          if (data.x == '31-40') {
            return AppColors.contentColorGreen; // Warna biru untuk male
          }
          if (data.x == '41-50') {
            return AppColors.contentColorGreen4; // Warna biru untuk male
          }
          if (data.x == '51-60') {
            return AppColors.contentColorGreen3; // Warna biru untuk male
          } else {
            return AppColors
                .contentColorGreen2; // Warna merah muda untuk female
          }
        },
        dataLabelSettings:  DataLabelSettings(
            isVisible: true,
            textStyle: Theme.of(context).textTheme.displaySmall,),
      ),
    ];
  }

  Widget shimmerLoading(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, left: 8, right: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Column(children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: SizedBox(
                                      height: 140,
                                      width: 100,
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey,
                                        direction: ShimmerDirection.ltr,
                                        child: const Card(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const TitleCakadaSimmer()
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipOval(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: AppTheme.gray100,
                          borderRadius: BorderRadius.circular(
                              100), // Membuat container menjadi bulat
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.grey.withOpacity(0.2),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey,
                          direction: ShimmerDirection.ltr,
                          child: Container(
                            color: Colors.grey, // Warna shimmer
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey,
                            direction: ShimmerDirection.ltr,
                            child: Container(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey,
                            direction: ShimmerDirection.ltr,
                            child: Container(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 60,
                          height: 50,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey,
                            direction: ShimmerDirection.ltr,
                            child: Container(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 220,
                          height: 50,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey,
                            direction: ShimmerDirection.ltr,
                            child: Container(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 140,
                          height: 50,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey,
                            direction: ShimmerDirection.ltr,
                            child: Container(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class NamaDaerah extends StatelessWidget {
  final String text;
  const NamaDaerah({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 3),
      child: SizedBox(
          width: 185,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontFamily: AppTheme.fontName,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppTheme.darkerText,
            ),
          )),
    );
  }
}

class DaerahWidget extends StatelessWidget {
  final String text;
  const DaerahWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 2),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: AppTheme.fontName,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          letterSpacing: -0.1,
          color: AppTheme.grey.withOpacity(0.5),
        ),
      ),
    );
  }
}

class TitleCakada extends StatelessWidget {
  final String? name;
  final String? titile;
  final String? prov;
  final String? kab;
  const TitleCakada({
    super.key,
    this.name,
    this.titile,
    this.prov,
    this.kab,
  });

  String capitalize(String s) {
    if (s.isEmpty) {
      return '';
    }
    return s.substring(0, 1).toUpperCase() + s.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Padding(
            padding: const EdgeInsets.only(left: 4, ),
            child: Text(
              'Nama',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyLarge
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, ),
            child: SizedBox(
                width: 185,
                child: Text(capitalize(name ?? ''),
                    style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.contentColorRed,
                  fontStyle: FontStyle.italic),)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, ),
            child: Text(
              'Calon Kepala Daerah',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyLarge
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, ),
            child: SizedBox(
                width: 185,
                child: Text(titile ?? '',
                    style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.contentColorRed,
                  fontStyle: FontStyle.italic))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, ),
            child: Text(
              'Provinsi',
              textAlign: TextAlign.left,
              style:Theme.of(context).textTheme.bodyLarge
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, ),
            child: SizedBox(
                width: 185,
                child: Text(capitalize(prov ?? ''),
                    style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.contentColorRed,
                  fontStyle: FontStyle.italic))),
          ),
          if (titile == 'Wali Kota / Bupati')
            Padding(
              padding: const EdgeInsets.only(left: 4, ),
              child: Text(
                'Kab/Kota',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyLarge
              ),
            ),
          if (titile == 'Wali Kota / Bupati')
            Padding(
              padding: const EdgeInsets.only(left: 4, ),
              child: SizedBox(
                  width: 185,
                  child: Text(capitalize(kab ?? ''),
                      style:GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.contentColorRed,
                  fontStyle: FontStyle.italic))),
            ),
        ],
      ),
    );
  }
}

class TitleCakadaSimmer extends StatelessWidget {
  const TitleCakadaSimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 2),
            child: SizedBox(
              width: 150,
              height: 20,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey,
                direction: ShimmerDirection.ltr,
                child: const Card(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 2),
            child: SizedBox(
              width: 150,
              height: 20,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey,
                direction: ShimmerDirection.ltr,
                child: const Card(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 2),
            child: SizedBox(
              width: 150,
              height: 20,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey,
                direction: ShimmerDirection.ltr,
                child: const Card(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 2),
            child: SizedBox(
              width: 150,
              height: 20,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey,
                direction: ShimmerDirection.ltr,
                child: const Card(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 2),
            child: SizedBox(
              width: 150,
              height: 20,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey,
                direction: ShimmerDirection.ltr,
                child: const Card(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 2),
            child: SizedBox(
              width: 150,
              height: 20,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey,
                direction: ShimmerDirection.ltr,
                child: const Card(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 2),
            child: SizedBox(
              width: 150,
              height: 20,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey,
                direction: ShimmerDirection.ltr,
                child: const Card(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
