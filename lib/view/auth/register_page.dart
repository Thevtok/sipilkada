// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, avoid_init_to_null, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/users.dart';
import 'package:flutter_application_1/view/auth/role_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/wilayah.dart';
import '../../services/auth.dart';
import '../../utils/auth.dart';
import '../../utils/lokasi.dart';
import '../dialog.dart';
import '../theme.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final api = Get.put(AuthService());

bool _passwordVisible = true;

var kelamin;
var tipeCaleg;

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 6,
        title: Text(
          'Registrasi',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Form(
          key: _formKey,
          child: Obx(() {
            if (api.isLoading.value) {
              _buildShimmerEffect(context);
            }

            if (api.provLsit.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: 56,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(1), // Border radius
                        child: ClipOval(
                            child: Image.asset('assets/images/nopicprof.png')),
                      ),
                    ),
                    _entryField('Nama Lengkap', api.nameController,
                        const Icon(Icons.person)),
                    _entryField('Nomor HP', api.phoneController,
                        const Icon(Icons.phone)),
                    _entryField(
                        'Email', api.emailController, const Icon(Icons.email)),
                    _entryField("Password", api.passController,
                        const Icon(Icons.password),
                        isPassword: true),
                    Padding(
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
                                        text: 'Jenis Kelamin',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    const TextSpan(
                                        text: ' *',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomRadioButton(
                              elevation: 0,
                              unSelectedColor: Theme.of(context).canvasColor,
                              buttonLables: const [
                                'LAKI-LAKI',
                                'PEREMPUAN',
                              ],
                              buttonValues: const ["L", "P"],
                              horizontal: false,
                              defaultSelected: null,
                              buttonTextStyle: ButtonTextStyle(
                                  selectedColor: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.black
                                      : Colors.white,
                                  unSelectedColor:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                  textStyle:
                                      Theme.of(context).textTheme.titleSmall ??
                                          const TextStyle()),
                              radioButtonValue: (value) {
                                setState(() {
                                  kelamin = value;
                                });
                              },
                              selectedColor: AppTheme.mainColor,
                              width: 174,
                              padding: 10,
                              enableShape: true,
                            ),
                          ]),
                    ),
                    if (kelamin == null)
                      Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Jenis kelamin harus diisi',
                                  style: TextStyle(
                                      color: Colors.red[900],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)))),
                    Padding(
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
                                        text: 'Tipe Cakada',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    const TextSpan(
                                        text: ' *',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomRadioButton(
                              elevation: 0,
                              unSelectedColor: Theme.of(context).canvasColor,
                              buttonLables: const [
                                'BUPATI/WALKOT',
                                'GUBERNUR',
                              ],
                              buttonValues: const ["2", "1"],
                              horizontal: false,
                              defaultSelected: null,
                              buttonTextStyle: ButtonTextStyle(
                                  selectedColor: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.black
                                      : Colors.white,
                                  unSelectedColor:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                  textStyle:
                                      Theme.of(context).textTheme.titleSmall ??
                                          const TextStyle()),
                              radioButtonValue: (value) {
                                setState(() {
                                  tipeCaleg = value;
                                });
                              },
                              selectedColor: AppTheme.mainColor,
                              width: 174,
                              padding: 10,
                              enableShape: true,
                            ),
                          ]),
                    ),
                    if (tipeCaleg == null)
                      Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Tipe Caleg harus diisi',
                                  style: TextStyle(
                                      color: Colors.red[900],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)))),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Informasi Caleg dan Wilayah',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CircleAvatar(
                          radius: 56,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(1), // Border radius
                            child: ClipOval(
                                child:
                                    Image.asset('assets/images/nopicprof.png')),
                          ),
                        ),
                        _entryField('Nama Caleg', api.nameController,
                            const Icon(Icons.person)),
                        if (tipeCaleg == '2')
                          _dorpMenuProv('Provinsi', api.provLsit),
                        if (tipeCaleg == '2')
                          _dorpMenuKab('Kab/Kota', api.kabList),
                        if (tipeCaleg == '1')
                          _dorpMenuProv('Provinsi', api.provLsit),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _submitButton('Register', () async {
                      _showConfirmationDialogFinal(context, () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        _formKey.currentState!.save();
                        showProcessingDialog();
                        Position? position = await DapatkanLokasiPengguna();
                        String? errorMessage = await api.register(User(
                            name: api.nameController.text,
                            username: api.phoneController.text,
                            nik: null,
                            address: null,
                            gender: kelamin,
                            email: api.emailController.text,
                            password: api.passController.text,
                            phone: api.phoneController.text,
                            idProvinsi: api.idProv.value,
                            idKabKota:
                                api.idKab.value == 0 ? null : api.idKab.value,
                            lastLat: position?.latitude ?? 0,
                            lastLng: position?.longitude ?? 0,
                            app_version: '1.0.3',
                            level: int.tryParse(tipeCaleg) ?? 0));
                        if (errorMessage == null) {
                          saveAuthentication(true);
                          showSuksesDialog(context, () {
                            api.nameController.clear();
                            api.phoneController.clear();
                            api.emailController.clear();
                            api.passController.clear();
                            api.provController.clear();
                            api.kabController.clear();
                            api.idProv.value = 0;
                            api.idKab.value = 0;

                            api.idKab.value == 0 ? null : api.idKab.value;
                            api.idProv.value == 0 ? null : api.idProv.value;
                            Get.offAll(() => const RolePage());
                          });
                        } else {
                          // Tampilkan pesan error menggunakan snackbar
                          showFailedDialog(context, errorMessage);
                        }
                      });
                    }, AppTheme.mainColor, AppTheme.mainColor),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              );
            } else {
              return _buildShimmerEffect(context);
            }
          })),
    );
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

  void showFailedDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogWidget(message: message);
      },
    );
  }

  void showSuksesDialog(BuildContext context, VoidCallback ontap) {
    showDialog(
      context: context,
      builder: (context) {
        return SuksesDialogWidget(
          text: 'Anda Berhasil Mendaftar',
          ontap: ontap,
        );
      },
    );
  }

  void showProcessingDialog() async {
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

  Widget _entryField(String title, TextEditingController controller, Icon icon,
      {bool isPassword = false}) {
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
                  const TextSpan(
                      text: ' *',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.titleSmall,
            controller: controller,
            initialValue: null,
            validator: (value) {
              if (value!.isEmpty) {
                return '$title harus diisi';
              }
              return null;
            },
            obscureText: isPassword ? _passwordVisible : false,
            decoration: InputDecoration(
                // labelText: title,
                hintText: title,
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppTheme.grey),
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppTheme.grey),
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppTheme.mainColor),
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppTheme.grey,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      )
                    : icon),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _dorpMenuProv(String title, List<Provinsi> daftar) {
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
                const TextSpan(
                    text: ' *',
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
            controller: api.provController,
            readOnly: true,
            onTap: () {
              openDialogProv(daftar);
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

  void openDialogKab(List<Kabupaten> daftar) {
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
                            api.idKab.value = item.id;

                            api.kabController.text = item.name;
                          });

                          await _showConfirmationDialog(
                              context, item.name, 'kab/kota');
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

  Widget _dorpMenuKab(String title, List<Kabupaten> daftar) {
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
                const TextSpan(
                    text: ' *',
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
            controller: api.kabController,
            readOnly: true,
            onTap: () {
              openDialogKab(daftar);
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

  void openDialogProv(List<Provinsi> daftar) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pilih Salah Satu',
              style: Theme.of(context).textTheme.bodyMedium),
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
                            api.idProv.value = item.id;

                            api.provController.text = item.name;
                            api.kabList.value = [];
                          });

                          api.getKabupaten(item.id);

                          await _showConfirmationDialog(
                              context, item.name, 'provinsi');
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
}
