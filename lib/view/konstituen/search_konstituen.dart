import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/search.dart';
import 'package:flutter_application_1/view/konstituen/search_result.dart';
import 'package:flutter_application_1/view/statistik/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

class SearchKonstituenPage extends StatefulWidget {
  const SearchKonstituenPage({super.key});

  @override
  State<SearchKonstituenPage> createState() => _SearchKonstituenPageState();
}

class _SearchKonstituenPageState extends State<SearchKonstituenPage> {
  final search = Get.put(SearchService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('Pencarian',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.displayLarge),
        ),
        body: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                searchWidget('Nama', 'Cari Nama', search.nameController),
                searchWidget('NIK', 'Cari NIK', search.nikController),
                _dorpMenuWilayah(
                  search.provList,
                  search.provId.value,
                  search.provController,
                  search.getKabupaten,
                  'Provinsi',
                  () {
                    setState(() {
                      // Perbarui state lokal dengan list baru
                      search.kabList.value = [];
                    });
                  },
                ),
                _dorpMenuWilayah(
                  search.kabList,
                  search.kabId.value,
                  search.kabController,
                  search.getKecamatan,
                  'Kab/Kota',
                  () {
                    setState(() {
                      // Perbarui state lokal dengan list baru
                      search.kecList.value = [];
                    });
                  },
                ),
                _dorpMenuWilayah(
                  search.kecList,
                  search.kecId.value,
                  search.kecController,
                  search.getKelurahan,
                  'Kecamatan',
                  () {
                    setState(() {
                      // Perbarui state lokal dengan list baru
                      search.kelList.value = [];
                    });
                  },
                ),
                _dorpMenuWilayah(
                  search.kelList,
                  search.kelId.value,
                  search.kelController,
                  search.getKelurahan,
                  'Kelurahan/Desa',
                  () {
                    setState(() {
                      // Perbarui state lokal dengan list baru
                      search.kelList.value = [];
                    });
                  },
                ),
                _switchWidget(
                  context,
                  'Jenis Kelamin',
                  ['LAKI-LAKI', 'PEREMPUAN'],
                  ['L', 'P'],
                  'L',
                  (value) {
                    search.kelamin.value = value ?? 'L';
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                _submitButton('Cari', () async {
                  Get.to(() => const SearchResultPage(),
                      transition: Transition.rightToLeft);
                }, AppTheme.mainColor, AppTheme.mainColor),
                  const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        }));
  }

  Widget _submitButton(
      String title, VoidCallback onTap, Color color1, Color color2) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 15),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                  Radius.circular(AppTheme.borderRadius)),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [color1, color2])),
          child: Text(
            title,
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.contentColorWhite,
            ),
          )),
    );
  }

  Widget _switchWidget(
    BuildContext context,
    String label,
    List<String> buttonLabels,
    List<String> buttonValues,
    String value,
    void Function(String?) onButtonPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: label,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          CustomRadioButton(
            elevation: 0,
            unSelectedColor: Theme.of(context).canvasColor,
            buttonLables: buttonLabels,
            buttonValues: buttonValues,
            horizontal: false,
            defaultSelected: value,
            buttonTextStyle: ButtonTextStyle(
                selectedColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white,
                unSelectedColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                textStyle: Theme.of(context).textTheme.titleSmall ??
                    const TextStyle()),
            radioButtonValue: onButtonPressed,
            selectedColor: AppTheme.mainColor,
            width: 174,
            padding: 10,
            enableShape: true,
          ),
        ],
      ),
    );
  }

  searchWidget(nik, hint, controller) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(nik, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: TextFormField(
            controller: controller,
            style: Theme.of(context).textTheme.titleSmall,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.titleSmall,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppTheme.grey),
                  borderRadius: BorderRadius.circular(25.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppTheme.grey),
                  borderRadius: BorderRadius.circular(25.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppTheme.mainColor),
                  borderRadius: BorderRadius.circular(25.0)),
              suffixIcon: Icon(
                Icons.search,
                color: Theme.of(context).indicatorColor,
              ),
            ),
          ),
        ),
      ],
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
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
              if (value!.isEmpty) {
                return '$title harus diisi';
              }
              return null;
            },
            decoration: InputDecoration(
                // labelText: title,
                hintText: title,
                hintStyle: Theme.of(context).textTheme.titleSmall,
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppTheme.grey),
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppTheme.grey),
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppTheme.mainColor),
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
                suffixIcon: const Icon(Icons.arrow_drop_down)),
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

                          await _showConfirmationDialog(
                              context, item.name, title);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5, color: AppTheme.gray900))),
                          child: Text(
                            item.name,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
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

  Future _showConfirmationDialog(
      BuildContext context, String prov, String tipe) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: Text('Apa anda yakin $tipe $prov sudah benar ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}
