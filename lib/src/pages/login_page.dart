import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spends_app/src/api/google_signin_api.dart';
import 'package:spends_app/src/pages/home_page.dart';
import 'package:spends_app/src/util/dialogs.dart';
import 'package:spends_app/src/widgets/my_btn2.dart';

class LoginPage extends StatefulWidget {
  static final pageName = 'LoginPageRoute';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode _focusNodePassword = FocusNode();
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '';
  bool _isFetching = false;

  @override
  void dispose() {
    _focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final Size size = media.size;
    final EdgeInsets padding = media.padding;

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Container(
                height: size.height - padding.top - padding.bottom,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: Image.asset('assets/pictures/spends.png')),
                    ),

                    Text(
                      'Gastos App',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: Colors.black54),
                    ),
                    // SizedBox(height: 60),
                    ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: 350, minWidth: 200),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // TextFormField(
                              //   decoration: InputDecoration(
                              //       labelText: 'E-mail',
                              //       hintText: 'example@domain.com',
                              //       border: OutlineInputBorder(
                              //           borderRadius: BorderRadius.circular(15)),
                              //       prefixIcon: Container(
                              //           padding: EdgeInsets.all(10),
                              //           width: 10,
                              //           height: 10,
                              //           child: SvgPicture.asset(
                              //             'assets/icons/mail.svg',
                              //             color: Colors.black54,
                              //           ))),
                              //   keyboardType: TextInputType.emailAddress,
                              //   keyboardAppearance: Brightness.light,
                              //   textInputAction: TextInputAction.next,
                              //   validator: _validateEmail,
                              //   onFieldSubmitted: (text) {
                              //     _focusNodePassword.nextFocus();
                              //   },
                              // ),
                              // SizedBox(height: 20),
                              // TextFormField(
                              //   decoration: InputDecoration(
                              //       labelText: 'Password',
                              //       hintText: '**********',
                              //       border: OutlineInputBorder(
                              //           borderRadius: BorderRadius.circular(15)),
                              //       prefixIcon: Container(
                              //           padding: EdgeInsets.all(10),
                              //           width: 10,
                              //           height: 10,
                              //           child: SvgPicture.asset(
                              //             'assets/icons/padlock.svg',
                              //             color: Colors.black54,
                              //           ))),
                              //   obscureText: true,
                              //   keyboardType: TextInputType.text,
                              //   keyboardAppearance: Brightness.light,
                              //   focusNode: _focusNodePassword,
                              //   textInputAction: TextInputAction.send,
                              //   validator: _validatePassword,
                              //   onFieldSubmitted: (text) => _submit(''),
                              // ),
                              // SizedBox(height: 5),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     CupertinoButton(
                              //         padding: EdgeInsets.zero,
                              //         child: Container(
                              //           padding: EdgeInsets.symmetric(vertical: 10),
                              //           margin:
                              //               EdgeInsets.symmetric(horizontal: 10),
                              //           child: Text('Recuperar contraseña'),
                              //           decoration: BoxDecoration(
                              //               border: Border(
                              //                   bottom: BorderSide(
                              //                       color: Colors.blue,
                              //                       width: 1.0))),
                              //         ),
                              //         onPressed: () =>
                              //             print('click en recuperar contraseña'))
                              //   ],
                              // ),
                              // SizedBox(height: 30),
                              // MyBtn2(
                              //   label: 'Login',
                              //   fullWidth: true,
                              //   onPressed: () => _submit(''),
                              //   backgroundColor: Color(0xFF039be5),
                              //   textColor: Colors.white,
                              // ),
                              // SizedBox(height: 30),
                              // Text('O inicia con: '),
                              // SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: MyBtn2(
                                      label: 'Gmail',
                                      fullWidth: true,
                                      onPressed: () => _submit('google'),
                                      backgroundColor: Color(0xFFc62828),
                                      textColor: Colors.white,
                                      icon: FontAwesomeIcons.google,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: MyBtn2(
                                      label: 'Apple',
                                      fullWidth: true,
                                      onPressed: () {
                                        print('call facebook auth');
                                      },
                                      backgroundColor: Colors.white60,
                                      textColor: Colors.black,
                                      icon: FontAwesomeIcons.apple,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
          if (_isFetching) Positioned.fill(child: Container(
            color: Colors.white70,
            child: Center(
              child: CupertinoActivityIndicator(
                radius: 15,
              ),
            ),
          ),)
        ],
      )),
    );
  }

  Future _submit(String authType) async {
    final bool isValid = _formKey.currentState.validate();
    setState(() {
      _isFetching = true;
    });
    switch (authType.toUpperCase()) {
      case 'GOOGLE':
        final resultAuth = await GoogleSignInApi.signInWithGoogle();
        final dynamic parsed = jsonDecode(resultAuth);
        if (resultAuth != null && parsed['ok']) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('wasLoginWith', 'GOOGLE');
          await prefs.setString('token', parsed['token']);
          Navigator.pushNamed(context, HomePage.pageName);
        } else
          await Dialogs.alert(context,
              title: 'Error al autenticarse con Google',
              body:
                  'Se presentó durante la comunicación con Google, finalice la aplicación e inténtelo de nuevo.');

        setState(() => _isFetching = false);
        break;
      case 'APPLE':
        break;
      default:
        if (isValid && _email == '@.' && _password == '123456') {
          // llamada al back
          print('go to backend $_email, $_password');
          // falta hacer la validación en el back
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('wasLoginWith', 'NORMAL');
          Navigator.pushNamed(context, HomePage.pageName);
        } else {
          await Dialogs.alert(
            context,
            title: 'Error al iniciar sesión',
            body: 'credenciales inválidas',
          );
        }
        break;
    }
  }

  // String _validateEmail(String email) {
  //   if (email.isNotEmpty && email.contains('@') && email.contains('.')) {
  //     _email = email;
  //     return null;
  //   }
  //   return 'Email inválido';
  // }

  // String _validatePassword(String password) {
  //   if (password.isNotEmpty && password.length > 4) {
  //     _password = password;
  //     return null;
  //   }
  //   return 'Contraseña inválida';
  // }
}
