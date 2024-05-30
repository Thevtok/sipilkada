// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, must_be_immutable

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/agama.dart';
import 'package:flutter_application_1/models/difabel.dart';
import 'package:flutter_application_1/models/pendidikan.dart';
import 'package:flutter_application_1/models/profesi.dart';
import 'package:flutter_application_1/services/add_konstituen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/users.dart';
import '../../models/wilayah.dart';
import '../../utils/lokasi.dart';
import '../home/home_page.dart';
import '../theme.dart';

class AddKonstituenPage extends StatefulWidget {
  const AddKonstituenPage({super.key});

  @override
  State<AddKonstituenPage> createState() => _AddKonstituenPageState();
}

class _AddKonstituenPageState extends State<AddKonstituenPage> {
  final dpt = Get.put(MarkingService());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Obx(() {
      {
        if (dpt.userList.isEmpty) {
          return const Center(
            child: Text('No user data available'),
          );
        } else {
          User? user = dpt.userList.first;
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.all(5),
                child: Text('Tambah Konstituen',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.displayLarge),
              ),
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
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
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 16, top: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const Icon(FontAwesomeIcons.idCard,
                                    size: 20, color: AppTheme.grey),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text('Identitas Konstituen',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium)
                              ]),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        _entryField(
                          'Nomor KK',
                          dpt.kkController,
                          false,
                        ),
                        _entryField(
                          'Nomor NIK',
                          dpt.nikController,
                          false,
                        ),
                        _entryField(
                          'Nama Lengkap',
                          dpt.nameController,
                          true,
                        ),
                        _entryField(
                          'Nomor HP',
                          dpt.phoneController,
                          false,
                        ),
                        _entryField(
                          'Email',
                          dpt.emailController,
                          false,
                        ),
                        _entryField(
                          'Akun Facebook',
                          dpt.fbController,
                          false,
                        ),
                        _entryField(
                          'Akun Instagram',
                          dpt.igController,
                          false,
                        ),
                        _entryField(
                          'Akun Tiktok',
                          dpt.ttController,
                          false,
                        ),
                        _entryField(
                          'Akun Twitter',
                          dpt.xController,
                          false,
                        ),
                        _switchWidget(
                          context,
                          'Jenis Kelamin',
                          ['LAKI-LAKI', 'PEREMPUAN'],
                          ['L', 'P'],
                          'L',
                          (value) {
                            dpt.kelamin.value = value ?? 'L';
                          },
                        ),
                        _entryField(
                          'Tempat Lahir',
                          dpt.tempatController,
                          false,
                        ),
                        _entryFieldTanggal(
                            'Tanggal Lahir', dpt.dateController, true, context),
                        _entryFieldAlamat(
                            'Alamat', dpt.addressController, true),
                        _entryField(
                          'No RT',
                          dpt.rtController,
                          false,
                        ),
                        _entryField(
                          'No RW',
                          dpt.rwController,
                          false,
                        ),
                        _entryField(
                          'Keterangan',
                          dpt.ketController,
                          false,
                        ),
                        _entryField(
                          'TPS',
                          dpt.tpsController,
                          false,
                        ),
                        _switchWidget(
                          context,
                          'Status Pernikahan',
                          ['MENIKAH', 'BELUM MENIKAH', 'CERAI'],
                          ['S', 'B', 'P'],
                          'B',
                          (value) {
                            dpt.nikah.value = value ?? 'B';
                          },
                        ),
                        _dorpMenuAgama(
                          'Agama',
                          dpt.religionList,
                          context,
                          dpt.agamaController,
                        ),
                        _dorpMenuPendidikan(
                          'Pendidkan',
                          dpt.pendidikanList,
                          context,
                          dpt.pendidikanController,
                        ),
                        _dorpMenuDifabel(
                          'Difabel',
                          dpt.difabelList,
                          context,
                          dpt.difabelController,
                        ),
                        _dorpMenuProfesi(
                          'Profesi',
                          dpt.profesiList,
                          context,
                          dpt.difabelController,
                        ),
                        _dorpMenuProv(
                          'Provinsi',
                          dpt.provList,
                          context,
                          dpt.provController,
                        ),
                        _dorpMenuKab(
                          'Kab/Kota',
                          dpt.kabList,
                          context,
                          dpt.kabController,
                        ),
                        _dorpMenuKec(
                          'Kecamatan',
                          dpt.kecList,
                          context,
                          dpt.kecController,
                        ),
                        _dorpMenuKel(
                          'Kel/Desa',
                          dpt.kelList,
                          context,
                          dpt.kelController,
                        ),
                        _switchWidget(
                          context,
                          'KATEGORI',
                          ['TINGGI', 'SEDANG', 'RENDAH'],
                          ['Tinggi', 'Sedang', 'Rendah'],
                          'Rendah',
                          (value) {
                            dpt.kategori.value = value ?? 'Rendah';
                            if (value == 'Tinggi') {
                              dpt.markId.value = '1';
                            } else if (value == 'Sedang') {
                              dpt.markId.value = '2';
                            } else if (value == 'Rendah') {
                              dpt.markId.value = '3';
                            }
                          },
                        ),
                        const SizedBox(height: 30),
                        _submitButton('Submit', () async {
                          _showConfirmationDialogFinal(context, () async {
                            if (!_formKey.currentState!.validate()) {
                              Navigator.of(context).pop();

                              return;
                            }
                            showProcessingDialog(context);
                            Position? position = await DapatkanLokasiPengguna();
                            String latitude = '';
                            String longitude = '';

                            if (position != null) {
                              latitude = position.latitude.toString();
                              longitude = position.longitude.toString();
                            }

                            final berhasil =
                                await dpt.addDpt(user.id, latitude, longitude);
                            if (berhasil) {
                              showCongratulationsDialog(
                                  'Anda telah berhasil menambah data', context);
                            } else {
                              showFailedDialog(
                                  context, dpt.errorKonstituen.value);
                            }
                          });
                        }, AppTheme.mainColor, AppTheme.mainColor, context),
                        const SizedBox(height: 20)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
    });
  }

  Widget _submitButton(String title, VoidCallback onTap, Color color1,
      Color color2, BuildContext context) {
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
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [color1, color2])),
          child: Text(title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))),
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

  Widget _entryField(
    String title,
    TextEditingController controller,
    bool merah,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
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
                      text: title,
                      style: Theme.of(context).textTheme.bodyMedium),
                  merah
                      ? const TextSpan(
                          text: ' *',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 14))
                      : const TextSpan()
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: controller,
            style: Theme.of(context).textTheme.titleSmall,
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
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _entryFieldAlamat(
      String title, TextEditingController controller, bool merah) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
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
                      text: title,
                      style: Theme.of(context).textTheme.bodyMedium),
                  merah
                      ? const TextSpan(
                          text: ' *',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 14))
                      : const TextSpan()
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            style: Theme.of(context).textTheme.titleSmall,
            maxLines: null,
            minLines: 3,
            keyboardType: TextInputType.multiline,
            controller: controller,
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
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _entryFieldTanggal(String title, TextEditingController controller,
      bool merah, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
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
                      text: title,
                      style: Theme.of(context).textTheme.bodyMedium),
                  merah
                      ? const TextSpan(
                          text: ' *',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 14))
                      : const TextSpan()
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            style: Theme.of(context).textTheme.titleSmall,
            onTap: () async {
              //_selectDate();
              final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1960),
                  initialDate: DateTime.now(),
                  lastDate: DateTime(2100));
              if (date != null) {
                dpt.dateController.text = DateFormat('yyyy-MM-dd').format(date);
              }
            },
            controller: controller,
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
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _dorpMenuAgama(
    String title,
    List<Religion> daftar,
    BuildContext context,
    TextEditingController controller,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            style: Theme.of(context).textTheme.titleSmall,
            controller: controller,
            readOnly: true,
            onTap: () {
              openDialogAgama(daftar, context, controller, title);
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
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).indicatorColor,
                )),
          )
        ],
      ),
    );
  }

  void openDialogAgama(List<Religion> daftar, BuildContext context,
      TextEditingController controller, String title) {
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
                          dpt.agamaId.value = item.id;

                          controller.text = item.name;
                          await _showConfirmationDialog(
                              context, item.name, title);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.5,
                                color: AppTheme.gray900,
                              ),
                            ),
                          ),
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

  Widget _dorpMenuDifabel(
    String title,
    List<DifabelList> daftar,
    BuildContext context,
    TextEditingController controller,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            style: Theme.of(context).textTheme.titleSmall,
            controller: controller,
            readOnly: true,
            onTap: () {
              openDialogDifabel(daftar, context, controller, title);
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
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).indicatorColor,
                )),
          )
        ],
      ),
    );
  }

  void openDialogDifabel(List<DifabelList> daftar, BuildContext context,
      TextEditingController controller, String title) {
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
                          dpt.difabelId.value = item.id;

                          controller.text = item.name;
                          await _showConfirmationDialog(
                              context, item.name, title);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.5,
                                color: AppTheme.gray900,
                              ),
                            ),
                          ),
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

  Widget _dorpMenuPendidikan(
    String title,
    List<Pendidikan> daftar,
    BuildContext context,
    TextEditingController controller,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            style: Theme.of(context).textTheme.titleSmall,
            controller: controller,
            readOnly: true,
            onTap: () {
              openDialogPendidikan(daftar, context, controller, title);
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
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).indicatorColor,
                )),
          )
        ],
      ),
    );
  }

  void openDialogPendidikan(List<Pendidikan> daftar, BuildContext context,
      TextEditingController controller, String title) {
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
                          dpt.pendidikanId.value = item.id;

                          controller.text = item.name;
                          await _showConfirmationDialog(
                              context, item.name, title);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.5,
                                color: AppTheme.gray900,
                              ),
                            ),
                          ),
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

  Widget _dorpMenuProfesi(
    String title,
    List<Profesi> daftar,
    BuildContext context,
    TextEditingController controller,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            style: Theme.of(context).textTheme.titleSmall,
            controller: controller,
            readOnly: true,
            onTap: () {
              openDialogProfesi(daftar, context, controller, title);
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
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).indicatorColor,
                )),
          )
        ],
      ),
    );
  }

  void openDialogProfesi(List<Profesi> daftar, BuildContext context,
      TextEditingController controller, String title) {
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
                          dpt.profesiId.value = item.id;

                          controller.text = item.name;
                          await _showConfirmationDialog(
                              context, item.name, title);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.5,
                                color: AppTheme.gray900,
                              ),
                            ),
                          ),
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

  Widget _dorpMenuProv(
    String title,
    List<Provinsi> daftar,
    BuildContext context,
    TextEditingController controller,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            style: Theme.of(context).textTheme.titleSmall,
            controller: controller,
            readOnly: true,
            onTap: () {
              openDialogProv(daftar, context, controller, title);
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
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).indicatorColor,
                )),
          )
        ],
      ),
    );
  }

  void openDialogProv(List<Provinsi> daftar, BuildContext context,
      TextEditingController controller, String title) {
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
                          dpt.provId.value = item.id;

                          controller.text = item.name;
                          await _showConfirmationDialog(
                              context, item.name, title);
                          dpt.kabList.value = [];
                          await dpt.getKabupaten(item.id);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.5,
                                color: AppTheme.gray900,
                              ),
                            ),
                          ),
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

  Widget _dorpMenuKab(
    String title,
    List<Kabupaten> daftar,
    BuildContext context,
    TextEditingController controller,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            style: Theme.of(context).textTheme.titleSmall,
            controller: controller,
            readOnly: true,
            onTap: () async {
              openDialogKab(daftar, context, controller, title);
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
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).indicatorColor,
                )),
          )
        ],
      ),
    );
  }

  void openDialogKab(List<Kabupaten> daftar, BuildContext context,
      TextEditingController controller, String title) {
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
                          dpt.kabId.value = item.id;

                          controller.text = item.name;
                          await _showConfirmationDialog(
                              context, item.name, title);
                          dpt.kecList.value = [];
                          await dpt.getKecamatan(item.id);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.5,
                                color: AppTheme.gray900,
                              ),
                            ),
                          ),
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

  Widget _dorpMenuKec(
    String title,
    List<Kecamatan> daftar,
    BuildContext context,
    TextEditingController controller,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            style: Theme.of(context).textTheme.titleSmall,
            controller: controller,
            readOnly: true,
            onTap: () {
              openDialogKec(daftar, context, controller, title);
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
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).indicatorColor,
                )),
          )
        ],
      ),
    );
  }

  void openDialogKec(List<Kecamatan> daftar, BuildContext context,
      TextEditingController controller, String title) {
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
                          dpt.kecId.value = item.id;

                          controller.text = item.name;
                          await _showConfirmationDialog(
                              context, item.name, title);
                          dpt.kelList.value = [];
                          await dpt.getKelurahan(item.id);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.5,
                                color: AppTheme.gray900,
                              ),
                            ),
                          ),
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

  Widget _dorpMenuKel(
    String title,
    List<Kelurahan> daftar,
    BuildContext context,
    TextEditingController controller,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            style: Theme.of(context).textTheme.titleSmall,
            controller: controller,
            readOnly: true,
            onTap: () {
              openDialogKel(daftar, context, controller, title);
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
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).indicatorColor,
                )),
          )
        ],
      ),
    );
  }

  void openDialogKel(List<Kelurahan> daftar, BuildContext context,
      TextEditingController controller, String title) {
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
                          dpt.kelId.value = item.id;

                          controller.text = item.name;
                          await _showConfirmationDialog(
                              context, item.name, title);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.5,
                                color: AppTheme.gray900,
                              ),
                            ),
                          ),
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

  Future _showConfirmationDialogFinal(
      BuildContext context, VoidCallback ontap) {
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

  Future _showConfirmationDialog(
      BuildContext context, String prov, String tipe) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Konfirmasi',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: Text(
            'Apa anda yakin $tipe $prov sudah benar ?',
          ),
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
