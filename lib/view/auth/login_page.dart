// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, deprecated_member_use, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/view/auth/register_page.dart';

import 'package:flutter_application_1/view/auth/splash_page.dart';
import 'package:flutter_application_1/view/statistik/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/auth.dart';
import '../dialog.dart';
import '../theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordVisible = true;

  var emailController = TextEditingController();

  var passController = TextEditingController();
  final api = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                _title(),
                _emailPasswordWidget(),
                const SizedBox(height: 10),
                _submitButton('Login', () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  _formKey.currentState!.save();
                  showProcessingDialog();

                  // Lakukan login dan dapatkan pesan error dari respons API jika login gagal
                  String? errorMessage = await api.login(
                    emailController.text,
                    passController.text,
                  );

                  if (errorMessage == null) {
                    saveAuthentication(true);
                    showSuksesDialog(context, () {
                      Get.offAll(() => const SplashPage(
                            isLoggedIn: true,
                          ));
                    });
                  } else {
                    // Tampilkan pesan error menggunakan snackbar
                    showFailedDialog(context, errorMessage);
                  }
                }, AppTheme.mainColor, AppTheme.mainColor),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Versi 1.0.3',
                      style: Theme.of(context).textTheme.displayMedium,
                    )),
                const SizedBox(height: 10),
                _createAccountLabel(),
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
                      onTap: () {
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
                      onTap: () {
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
          )),
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
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircularProgressIndicator(),
                Align(
                  alignment: Alignment.center,
                  child: Text("  Mohon Tunggu..." ,style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _title() {
    return Container(
      height: 150,
      width: 350,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Image.asset('assets/images/sipp_head2.png'),
    );
  }

  Widget _entryField(
      String title, String values, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
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
                  borderSide: const BorderSide(color: AppTheme.utama),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppTheme.grey,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    )
                  : const Icon(
                      Icons.person_outlined,
                    ),
            ),
          )
        ],
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
              // boxShadow: <BoxShadow>[
              //   BoxShadow(
              //       color: Colors.grey.shade200,
              //       offset: const Offset(2, 4),
              //       blurRadius: 5,
              //       spreadRadius: 2)
              // ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [color1, color2])),
          child: Text(title,
               style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.contentColorWhite,
              ),)),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email / Nomor HP", "", emailController),
        _entryField("Password", "", passController, isPassword: true),
      ],
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Get.to(() => const RegisterPage(), transition: Transition.rightToLeft);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(7.5),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Text(
              'Belum memiliki akun ?',
             style: Theme.of(context).textTheme.titleMedium
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
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
          text: 'Anda Berhasil Masuk',
          ontap: ontap,
        );
      },
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
