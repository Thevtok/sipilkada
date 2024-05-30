import 'package:flutter/material.dart';

import '../theme.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}
bool _passwordVisible = true;
final nameController = TextEditingController();
final phoneController = TextEditingController();
final emailController = TextEditingController();
final passController = TextEditingController();
final provController = TextEditingController();
class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                 SizedBox(height:MediaQuery.of(context).size.height*0.13),
                CircleAvatar(
                  radius: 56,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(1), // Border radius
                    child: ClipOval(
                        child: Image.asset('assets/images/nopicprof.png')),
                  ),
                ),
                const SizedBox(height: 30,),
                _entryField('Nama Lengkap','Muhammad Fikri Alfarizi', nameController),
                 _entryField('Nomor HP','089877675545', phoneController),
                  _entryField('Email','alfarizi@gmail.com', emailController),
                  _entryField('Password',passController.text, passController,isPassword: true),

              ],
            ),
          ),getAppBarUI(context)
        ],
      ),
    );
  } 
 Widget getAppBarUI(BuildContext context) {
    return Column(
      children: <Widget>[
      Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                ),
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
                        Navigator.pop(context);
                  
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
                      child:
                    Text(
                      'Edit Profile',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w700,
                        fontSize: 22 ,
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
      )
         
      ],
    );
  }
  Widget _entryField(String title,String nama, TextEditingController controller,
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
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
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
          TextField(
            controller: controller,
           
            obscureText: isPassword ? _passwordVisible : false,
            decoration: InputDecoration(
                // labelText: title,
                hintText: nama,
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
                    : const SizedBox()),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

