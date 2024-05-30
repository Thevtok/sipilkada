// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/kampanye.dart';
import 'package:flutter_application_1/view/home/home_page.dart';
import 'package:flutter_application_1/view/kampanye/kampanye_list.dart.dart';
import 'package:flutter_application_1/view/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../models/kampanye.dart';

class KampanyePage extends StatefulWidget {
  const KampanyePage({super.key});

  @override
  State<KampanyePage> createState() => _KampanyePageState();
}

class _KampanyePageState extends State<KampanyePage> {
  final kampanye = Get.put(KampanyeService());
  DateTime _selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('Program Kampanye',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.displayLarge),
              centerTitle: true,
         
        ),
        body: Obx(() {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: SfDateRangePicker(
                    onSelectionChanged:
                        (DateRangePickerSelectionChangedArgs args) {
                      if (args.value is DateTime) {
                        _selectedDate = args.value as DateTime;
                        setState(() {
                          kampanye.dateController.text = formattedDate;
                        });

                        // Lakukan sesuatu dengan tanggal terpilih di sini
                      }
                    },
                    headerHeight: 60,
                    headerStyle: DateRangePickerHeaderStyle(
                        backgroundColor:
                            Theme.of(context).appBarTheme.backgroundColor,
                        textAlign: TextAlign.center,
                        textStyle: Theme.of(context).textTheme.bodyMedium),
                    monthViewSettings: const DateRangePickerMonthViewSettings(
                        dayFormat: 'EEE'),
                    monthCellStyle: const DateRangePickerMonthCellStyle(
                        leadingDatesTextStyle: TextStyle(
                            fontSize: 15, fontFamily: AppTheme.fontName),
                        weekendTextStyle: TextStyle(color: AppTheme.red),
                        textStyle: TextStyle(
                            fontSize: 15, fontFamily: AppTheme.fontName)),
                    showNavigationArrow: true,
                    backgroundColor:
                        Theme.of(context).appBarTheme.backgroundColor,
                    selectionMode: DateRangePickerSelectionMode.single,
                    initialSelectedDate: _selectedDate,
                    selectionShape: DateRangePickerSelectionShape.rectangle,
                    selectionColor: AppTheme.mainColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          kampanye.dateController.text = formattedDate;
                        });

                        _showFormDialog(
                          context,
                        );
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.mainColor,
                        ),
                        child: const Center(
                          child: Icon(
                            size: 45,
                            Icons.add,
                            color: AppTheme.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        child: Text(
                          'Events',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: AppTheme.fontName,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            letterSpacing: 0.5,
                            color: AppTheme.mainColor,
                          ),
                        ),
                      ),
                      InkWell(
                        highlightColor: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        onTap: () {
                          Get.to(() => KampanyeListPage(),
                              transition: Transition.rightToLeft);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Lihat Semua',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  letterSpacing: 0.5,
                                  color: AppTheme.mainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (kampanye.isLoading.value) _buildShimmerEffect(context),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: kampanye.campaignList.length,
                  itemBuilder: (context, index) {
                    final campaign = kampanye.campaignList[index];

                    final day = DateFormat('dd');
                    final month = DateFormat('MMMM');
                    final String days = day.format(campaign.date);
                    final String months = month.format(campaign.date);

                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CampaignDetailDialog(campaign: campaign);
                          },
                        );
                      },
                      child: EventCard(
                          day: days,
                          month: months,
                          color: AppTheme.mainColor,
                          title: campaign.name,
                          subTitile: campaign.description),
                    );
                  },
                ),
              ],
            ),
          );
        }));
  }

  Widget _buildShimmerEffect(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              3,
              (index) => Container(
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

  _showFormDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          title: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), // Sesuaikan radius sesuai kebutuhan
              topRight:
                  Radius.circular(10), // Sesuaikan radius sesuai kebutuhan
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.symmetric(vertical: 15),
              color: AppTheme.mainColor,
              child: const Center(
                child: Text(
                  'Create Event',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          contentPadding: EdgeInsets.zero,
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  searchWidget(
                      'Title', kampanye.titileController, TextInputType.text),
                  searchWidget2('Deskripsi', kampanye.subTitileController,
                      TextInputType.text),
                  searchWidget2(
                      'Alamat', kampanye.addressContoler, TextInputType.text),
                  searchWidget('Budget', kampanye.budgetController,
                      TextInputType.number),
                  _dorpMenuDate(
                    kampanye.dateController,
                    'Tanggal',
                  ),
                  _dorpMenuJam(
                    kampanye.jamController,
                    'Jam',
                  ),
                  _dorpMenuWilayah(
                    kampanye.provList,
                    kampanye.provId.value,
                    kampanye.provController,
                    kampanye.getKabupaten,
                    'Provinsi',
                    () {
                      setState(() {
                        // Perbarui state lokal dengan list baru
                        kampanye.kabList.value = [];
                      });
                    },
                  ),
                  _dorpMenuWilayah(
                    kampanye.kabList,
                    kampanye.kabId.value,
                    kampanye.kabController,
                    kampanye.getKecamatan,
                    'Kab/Kota',
                    () {
                      setState(() {
                        // Perbarui state lokal dengan list baru
                        kampanye.kecList.value = [];
                      });
                    },
                  ),
                  _dorpMenuWilayah(
                    kampanye.kecList,
                    kampanye.kecId.value,
                    kampanye.kecController,
                    kampanye.getKelurahan,
                    'Kecamatan',
                    () {
                      setState(() {
                        // Perbarui state lokal dengan list baru
                        kampanye.kelList.value = [];
                      });
                    },
                  ),
                  _dorpMenuWilayah(
                    kampanye.kelList,
                    kampanye.kelId.value,
                    kampanye.kelController,
                    kampanye.getKelurahan,
                    'Kelurahan/Desa',
                    () {
                      setState(() {
                        // Perbarui state lokal dengan list baru
                        kampanye.kelList.value = [];
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        kampanye.titileController.clear();
                        kampanye.subTitileController.clear();
                        kampanye.provController.clear();
                        kampanye.kabController.clear();
                        kampanye.kecController.clear();
                        kampanye.kelController.clear();
                        kampanye.dateController.clear();
                        kampanye.budgetController.clear();
                        kampanye.jamController.clear();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.035,
                        width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                            color: AppTheme.mainColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.background,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        _showConfirmationDialog(context, () async {
                          showProcessingDialog(context);
                          final berhasil = await kampanye.addKampanye();
                          if (berhasil) {
                            showCongratulationsDialog(
                                'Anda telah berhasil menambah data', context);
                          } else {
                            showFailedDialog(
                                context, kampanye.errorKonstituen.value);
                          }
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.035,
                        width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                            color: AppTheme.mainColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                          child: Text(
                            'Save',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.background,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }

  searchWidget(nik, controller, keyboard) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(nik,
                style: Theme.of(context).textTheme.bodyMedium,),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: TextFormField(
            style: Theme.of(context).textTheme.titleSmall,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$nik harus diisi';
              }
              return null;
            },
            keyboardType: keyboard,
            controller: controller,
            decoration:  InputDecoration(
              hintStyle: Theme.of(context).textTheme.titleSmall,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.grey),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.grey),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.mainColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  searchWidget2(nik, controller, keyboard) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(nik,
                style: Theme.of(context).textTheme.bodyMedium,),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: TextFormField(
            maxLines: 3,
            style: Theme.of(context).textTheme.titleSmall,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$nik harus diisi';
              }
              return null;
            },
            keyboardType: keyboard,
            controller: controller,
            decoration:  InputDecoration(
              hintStyle: Theme.of(context).textTheme.titleSmall,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.grey),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.grey),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.mainColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dorpMenuJam(
    TextEditingController controller,
    String title,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: title,
                   style: Theme.of(context).textTheme.bodyMedium,),
                const TextSpan(
                    text: '',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.titleSmall,
            controller: controller,
            readOnly: true,
            onTap: () async {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (pickedTime != null) {
                String formattedTime =
                    '${pickedTime.hour}:${pickedTime.minute.toString().padLeft(2, '0')}';

                setState(() {
                  controller.text = formattedTime;
                });
              }
            },
            // initialValue: values,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$title harus diisi';
              }
              return null;
            },
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                // labelText: title,
                hintText: title,
                hintStyle: Theme.of(context).textTheme.titleSmall,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.grey),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.mainColor),
                ),
                suffixIcon:  Icon(Icons.arrow_drop_down, color: Theme.of(context).indicatorColor,)),
          )
        ],
      ),
    );
  }

  Widget _dorpMenuDate(
    TextEditingController controller,
    String title,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: title,
                   style: Theme.of(context).textTheme.bodyMedium,),
                const TextSpan(
                    text: '',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.titleSmall,
            controller: controller,
            readOnly: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$title harus diisi';
              }
              return null;
            },
            decoration: InputDecoration(hintText: title,

              hintStyle: Theme.of(context).textTheme.titleSmall,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
              // labelText: title,

              border: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.grey),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.grey),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.mainColor),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _dorpMenuWilayah(
      List<dynamic> daftar,
      int idWilayah,
      TextEditingController controller,
      Future<void> Function(int) getKabupatenCallback,
      String title,
      void Function() updateBawahnyaCallback) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: title, style: Theme.of(context).textTheme.bodyMedium),
                const TextSpan(
                    text: '',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.titleSmall,
            controller: controller,
            readOnly: true,
            onTap: () {
              openDialogProv(daftar, idWilayah, controller,
                  getKabupatenCallback, title, updateBawahnyaCallback);
            },
            // initialValue: values,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$title harus diisi';
              }
              return null;
            },
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                // labelText: title,
                hintText: title,
                hintStyle: Theme.of(context).textTheme.titleSmall,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.grey),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.mainColor),
                ),
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).indicatorColor,
                )),
          )
        ],
      ),
    );
  }

  void openDialogProv(
      List<dynamic> daftar,
      int idWilayah,
      TextEditingController controller,
      Future<void> Function(int) getKabupatenCallback,
      String title,
      void Function() updateBawahnyaCallback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Pilih Salah Satu',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: daftar.length,
                    itemBuilder: (context, index) {
                      var item = daftar[index];
                      return InkWell(
                        onTap: () async {
                          setState(() {
                            idWilayah = item.id;

                            controller.text = item.name;
                          });
                          updateBawahnyaCallback();

                          getKabupatenCallback(item.id);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5, color: AppTheme.gray900))),
                          child: Text(item.name,
                              style: Theme.of(context).textTheme.titleSmall),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  Future _showConfirmationDialog(BuildContext context, VoidCallback ontap) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Konfirmasi',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: const Text('Apa anda yakin semua data sudah benar ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                ontap();
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
          title: Text("Gagal", style: Theme.of(context).textTheme.bodyMedium),
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

class EventCard extends StatelessWidget {
  final Color color;
  final String title;
  final String subTitile;
  final day;
  final month;
  const EventCard(
      {super.key,
      required this.color,
      required this.title,
      required this.subTitile,
      this.day,
      this.month});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.15,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.82,
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor),
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(subTitile,
                          style: Theme.of(context).textTheme.labelMedium)
                    ],
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 70,
                  width: 65,
                  color: color,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day,
                        style: const TextStyle(
                            color: AppTheme.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(month,
                          style: const TextStyle(
                              color: AppTheme.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class CampaignDetailDialog extends StatelessWidget {
  final Campaign campaign;

  const CampaignDetailDialog({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(campaign.date);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Atur radius sesuai kebutuhan
      ),
      elevation: 0,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      content: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 30.0, // Sesuaikan jarak antara ikon dan judul
              left: 10.0,
              right: 10.0,
              bottom: 10.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0), // Atur radius sesuai kebutuhan
                topRight: Radius.circular(20.0), // Atur radius sesuai kebutuhan
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  campaign.name,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.mainColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Tanggal: $formattedDate',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Jam: ${campaign.clock}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Lokasi: ${campaign.namaProvinsi}, ${campaign.namaKabupaten}, ${campaign.namaKecamatan}, ${campaign.namaKelurahan}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Deskripsi: ${campaign.description}',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
          const Positioned(
            top: -50.0, // Atur jarak ikon dari bagian atas
            child: Icon(
              Icons.info,
              color:
                  AppTheme.mainColor, // Sesuaikan warna ikon sesuai kebutuhan
              size: 60.0, // Atur ukuran ikon sesuai kebutuhan
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Tutup',
            style: TextStyle(
              color: AppTheme.mainColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
