import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/statistik.dart';
import 'package:flutter_application_1/services/statistik.dart';
import 'package:flutter_application_1/view/statistik/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../models/users.dart';
import '../demografi/demografi.dart';
import '../theme.dart';

class StatistikPage extends StatefulWidget {
  const StatistikPage({super.key});

  @override
  State<StatistikPage> createState() => _StatistikPageState();
}

class _StatistikPageState extends State<StatistikPage> {
  final statistik = Get.put(StatistikService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('Statistik',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.displayLarge),
        ),
        body: Obx(() {
          final progress = statistik.progressData.value;

          User? user = statistik.userData.value;
          if (statistik.isLoading.value) {
            return shimmerLoading(context);
          }
          if (progress != null) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Icon(FontAwesomeIcons.solidChartBar,
                              size: 20, color: AppTheme.grey),
                          const SizedBox(
                            width: 10,
                          ),
                          Text('Informasi Dapil',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge)
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2.6,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                          ),
                          child: Column(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, top: 8),
                              child: Text('Jumlah TPS',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '\n',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(progress.total_tps.toString(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyLarge),
                            )
                          ]),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.6,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                          ),
                          child: Column(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, top: 8),
                              child: Text('Jumlah DPT',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '\n',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(progress.totalKonstituen.toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge),
                            Text("Pemilih",
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.bodyLarge)
                          ]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Icon(FontAwesomeIcons.list,
                              size: 20, color: AppTheme.grey),
                          const SizedBox(
                            width: 10,
                          ),
                          Text('Daerah Pemilih',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge)
                        ]),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          if (user?.level_name == 'Gubernur')
                            DaerahWidget(
                              daerah: 'Kabupaten/Kota',
                              jumlah: progress.total_kab_kota.toString(),
                            ),
                          DaerahWidget(
                            daerah: 'Kecamatan',
                            jumlah: progress.total_kecamatan.toString(),
                          ),
                          DaerahWidget(
                            daerah: 'Kelurahan',
                            jumlah: progress.total_desa_kel.toString(),
                          ),
                          DaerahWidget(
                            daerah: 'TPS',
                            jumlah: progress.total_tps.toString(),
                          ),
                          DaerahWidget(
                            daerah: 'Pemilih',
                            jumlah: progress.totalKonstituen.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Icon(FontAwesomeIcons.chartPie,
                              size: 20, color: AppTheme.grey),
                          const SizedBox(
                            width: 10,
                          ),
                          Text('Progres Pemenangan',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge)
                        ]),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SfRadialGauge(
                            title: GaugeTitle(
                                alignment: GaugeAlignment.center,
                                text: 'Progres Marking',
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge),
                            axes: <RadialAxis>[
                              RadialAxis(
                                showLabels: false,
                                showAxisLine: false,
                                showTicks: false,
                                minimum: 0,
                                maximum: 100,
                                startAngle: 180,
                                endAngle: 0,
                                canScaleToFit: true,
                                ranges: <GaugeRange>[
                                  GaugeRange(
                                      labelStyle: const GaugeTextStyle(
                                          fontSize: 14, color: Colors.white),
                                      startValue: 0,
                                      endValue: 100,
                                      gradient: const SweepGradient(
                                        colors: [
                                          AppColors.contentColorRed,
                                          AppColors.contentColorOrange,
                                          AppColors.contentColorGreen
                                        ],
                                      ),
                                      sizeUnit: GaugeSizeUnit.factor,
                                      startWidth: 0.5,
                                      endWidth: 0.5),
                                ],
                                pointers: <GaugePointer>[
                                  NeedlePointer(
                                    value: progress.grandTotal
                                        .toDouble(), // Ubah persentase sesuai kebutuhan Anda
                                    enableAnimation: true,
                                    animationDuration: 3000,
                                    needleStartWidth: 1,
                                    needleEndWidth: 3,
                                  ),
                                ],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                    angle: 0,
                                    verticalAlignment: GaugeAlignment.near,
                                    horizontalAlignment: GaugeAlignment.near,
                                    positionFactor: 0.7,
                                    widget: Text(
                                      'Max',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                  GaugeAnnotation(
                                    angle: 90,
                                    horizontalAlignment: GaugeAlignment.center,
                                    positionFactor: 0.2,
                                    widget: Text('${progress.grandTotal}%',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  ),
                                  GaugeAnnotation(
                                    angle: 180,
                                    verticalAlignment: GaugeAlignment.near,
                                    horizontalAlignment: GaugeAlignment.far,
                                    positionFactor: 0.7,
                                    widget: Text('Min',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // BarChartSample7(
                          //   dataList: [
                          //     BarData(AppColors.contentColorRed,
                          //         progress.potensiRendah.toDouble(), 'Rendah'),
                          //     BarData(AppColors.contentColorOrange,
                          //         progress.potensiSedang.toDouble(), 'Sedang'),
                          //     BarData(AppColors.contentColorGreen,
                          //         progress.potensiTinggi.toDouble(), 'Tinggi'),
                          //   ],
                          //   data: [
                          //     progress.potensiRendah.toDouble(),
                          //     progress.potensiSedang.toDouble(),
                          //     progress.potensiTinggi.toDouble()
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                      ),
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
                          enableAxisAnimation: true,
                          title: ChartTitle(
                              text: 'Hasil Marking',
                              alignment: ChartAlignment.center,
                              textStyle: Theme.of(context).textTheme.displaySmall),
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                            tooltipPosition: TooltipPosition.auto,
                            duration: 4 * 1000,
                          ),
                          legend:  Legend(
                            textStyle: Theme.of(context).textTheme.displaySmall,
                              alignment: ChartAlignment.center,
                              isVisible: true,
                              iconHeight: 20,
                              iconWidth: 20,
                              isResponsive: true,
                              position: LegendPosition.top,
                              padding: 10),
                          primaryXAxis: CategoryAxis(
                            labelStyle: Theme.of(context).textTheme.bodyLarge,
                            majorGridLines: const MajorGridLines(width: 0),
                          ),
                          primaryYAxis: NumericAxis(
                            majorGridLines: const MajorGridLines(width: 0),
                          ),
                          series: _getDefaultColumnSeries(),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color: AppColors.contentColorYellow,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: AppTheme.nearlyBlack
                                                  .withOpacity(0.7),
                                              offset: const Offset(1.8, 0.7),
                                              blurRadius: 5.0),
                                        ],
                                      ),
                                      child: Column(children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, top: 8),
                                          child: Text('Target Suara',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 8, bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Text(
                                              progress.targetSuara.toString(),
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                        )
                                      ]),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color: AppColors.contentColorBlue,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: AppTheme.nearlyBlack
                                                  .withOpacity(0.7),
                                              offset: const Offset(1.8, 0.7),
                                              blurRadius: 5.0),
                                        ],
                                      ),
                                      child: Column(children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4, top: 8),
                                          child: Text('% Progress',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 8, bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Text(
                                              '${progress.grandTotal.toString()}%',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                        )
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  LevelPendukung(
                                    color: AppColors.contentColorRed,
                                    color2: AppColors.contentColorRed,
                                    level: 'Rendah',
                                    nilai: progress.potensiRendah.toString(),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  LevelPendukung(
                                    color: AppColors.contentColorOrange,
                                    color2: AppColors.contentColorOrange,
                                    level: 'Sedang',
                                    nilai: progress.potensiSedang.toString(),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  LevelPendukung(
                                    color: AppColors.contentColorGreen,
                                    color2: AppColors.contentColorGreen,
                                    level: 'Tinggi',
                                    nilai: progress.potensiTinggi.toString(),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      )),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 2,
                        height: MediaQuery.of(context).size.height * 0.6,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                         
                        ),
                        child: SfCartesianChart(
                          enableAxisAnimation: true,
                          title: ChartTitle(
                              text: 'Marking Per Wilayah',
                              alignment: ChartAlignment.near,
                              textStyle: Theme.of(context).textTheme.displaySmall),
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                            tooltipPosition: TooltipPosition.auto,
                            duration: 4 * 1000,
                          ),
                          legend:  Legend(
                            textStyle: Theme.of(context).textTheme.displaySmall,
                              alignment: ChartAlignment.near,
                              isVisible: true,
                              iconHeight: 20,
                              iconWidth: 20,
                              isResponsive: true,
                              position: LegendPosition.top,
                              padding: 10),
                          primaryXAxis: CategoryAxis(
                            labelStyle: const TextStyle(fontSize: 10),
                            majorGridLines: const MajorGridLines(width: 0),
                          ),
                          primaryYAxis: NumericAxis(
                            majorGridLines: const MajorGridLines(width: 0),
                          ),
                          series: _getColumnSeriesList(),
                          // loadMoreIndicatorBuilder: (BuildContext context,
                          //     ChartSwipeDirection direction) {
                          //       return getLoadMoreViewBuilder(context, direction)
                          //     }
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return shimmerLoading(context);
          }
        }));
  }

  List<ColumnSeries<WilayahProgres, String>> _getDefaultColumnSeries() {
    StatistikProgress? data = statistik.progressData.value;
    return <ColumnSeries<WilayahProgres, String>>[
      ColumnSeries<WilayahProgres, String>(
        isVisibleInLegend: false,
        name: 'Hasil Marking',
        dataSource: <WilayahProgres>[
          WilayahProgres(
            x: 'Rendah',
            y: data?.potensiRendah,
            text: 'Rendah',
          ),
          WilayahProgres(x: 'Sedang', y: data?.potensiSedang, text: 'Sedang'),
          WilayahProgres(
            x: 'Tinggi',
            y: data?.potensiTinggi,
            text: 'Tinggi',
          ),
        ],
        xValueMapper: (WilayahProgres data, _) => data.x,
        yValueMapper: (WilayahProgres data, _) => data.y,
        dataLabelMapper: (WilayahProgres data, _) => data.y.toString(),
        pointColorMapper: (WilayahProgres data, _) {
          // Menggunakan data untuk menentukan warna
          if (data.x == 'Rendah') {
            return AppColors.contentColorRed; // Warna biru untuk male
          }
          if (data.x == 'Sedang') {
            return AppColors.contentColorOrange; // Warna biru untuk male
          } else {
            return AppColors.contentColorGreen; // Warna merah muda untuk female
          }
        },
        dataLabelSettings:  DataLabelSettings(
          labelPosition: ChartDataLabelPosition.inside,
            isVisible: true,
            textStyle: Theme.of(context).textTheme.displaySmall),
      ),
    ];
  }

  List<ColumnSeries<WilayahData, String>> _getColumnSeriesList() {
    return <ColumnSeries<WilayahData, String>>[
      ColumnSeries<WilayahData, String>(
        dataSource: statistik.progresList,
        color: AppColors.contentColorGreen,
        xValueMapper: (WilayahData sales, _) => sales.namaKabupaten,
        yValueMapper: (WilayahData sales, _) => sales.tinggi,
        name: 'Tinggi',
        dataLabelSettings:  DataLabelSettings(
          isVisible: true,
          textStyle: Theme.of(context).textTheme.displaySmall
        ),
      ),
      ColumnSeries<WilayahData, String>(
        dataSource: statistik.progresList,
        color: AppColors.contentColorOrange,
        xValueMapper: (WilayahData sales, _) => sales.namaKabupaten,
        yValueMapper: (WilayahData sales, _) => sales.sedang,
        name: 'Sedang',
        dataLabelSettings:  DataLabelSettings(
          isVisible: true,
          textStyle: Theme.of(context).textTheme.displaySmall
        ),
      ),
      ColumnSeries<WilayahData, String>(
        dataSource: statistik.progresList,
        color: AppColors.contentColorRed,
        xValueMapper: (WilayahData sales, _) => sales.namaKabupaten,
        yValueMapper: (WilayahData sales, _) => sales.rendah,
        name: 'Rendah',
        dataLabelSettings:  DataLabelSettings(
          isVisible: true,
          textStyle: Theme.of(context).textTheme.displaySmall
        ),
      )
    ];
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: AppTheme.white,
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
              SizedBox(
                height: MediaQuery.of(Get.context!).padding.top,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      height: AppBar().preferredSize.height,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                          onTap: () {
                            Navigator.pop(Get.context!);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 0.0),
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'Statistik',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: AppTheme.fontName,
                            fontWeight: FontWeight.w700,
                            fontSize: 22 + 6 - 6,
                            letterSpacing: 1.2,
                            color: AppTheme.mainColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
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
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 77,
                  decoration: BoxDecoration(
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
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey,
                    direction: ShimmerDirection.ltr,
                    child: const Card(
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 77,
                  decoration: BoxDecoration(
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
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey,
                    direction: ShimmerDirection.ltr,
                    child: const Card(
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.6,
                  height: 100,
                  decoration: BoxDecoration(
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
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey,
                    direction: ShimmerDirection.ltr,
                    child: const Card(
                      color: Colors.grey,
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
            padding: const EdgeInsets.all(12),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
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
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
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
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey,
                  direction: ShimmerDirection.ltr,
                  child: const Card(
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
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
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey,
                  direction: ShimmerDirection.ltr,
                  child: const Card(
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
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
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey,
                  direction: ShimmerDirection.ltr,
                  child: const Card(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LevelPendukung extends StatelessWidget {
  final String level;
  final String nilai;
  final Color color;
  final Color color2;

  const LevelPendukung({
    super.key,
    required this.level,
    required this.nilai,
    required this.color,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width / 3.7,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color2], // Warna gradien dari merah ke biru
          begin: Alignment.topCenter, // Awal gradien di sudut kiri atas
          end: Alignment.bottomCenter, // Akhir gradien di sudut kanan bawah
        ),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: AppTheme.nearlyBlack.withOpacity(0.7),
              offset: const Offset(1.8, 0.7),
              blurRadius: 5),
        ],
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(level,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(nilai,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall),
        )
      ]),
    );
  }
}

class DaerahWidget extends StatelessWidget {
  final String daerah;
  final String jumlah;
  const DaerahWidget({
    super.key,
    required this.daerah,
    required this.jumlah,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 2),
                        child: Text(daerah,
                            style: Theme.of(context).textTheme.bodyLarge),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4, right: 4),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 2),
                        child: Text(jumlah,
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.bodyLarge),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
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
