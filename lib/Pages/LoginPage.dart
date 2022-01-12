import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/alertBox.dart';
import 'package:flutter_map_marker_animation_example/Pages/Selection.dart';
import 'package:flutter_map_marker_animation_example/home.dart';
import 'package:flutter_map_marker_animation_example/Entities/APIControls.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/RoundedPasswordField.dart';
import 'package:flutter_map_marker_animation_example/Pages/Components/RoundedTextField.dart';
import 'package:flutter_map_marker_animation_example/translations/locale_keys.g.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_map_marker_animation_example/Entities/loginPrefs.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _hidePassword = true;
  LoginSharePref prefs= LoginSharePref();

  String _username;
  String _password;
  TextEditingController usernameCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();


  checkPrefs()async{
    String email = await prefs.getEmail();
    String pass = await prefs.getPass();
    if(email!=null && pass!=null){

      setState(() {
        usernameCont.text=email;
        passwordCont.text=pass;
        _username=email;
        _password=pass;
      });
      await prefs.clearLoginCred();
    }
  }
  getLogOut()async{
    await prefs.clearLoginCred();
  }
  @override
  void initState() {
    super.initState();
    // setState(() {
    //   StaticClass.showTruck=false;
    // });

    checkPrefs();

  }

  @override
  Widget build(BuildContext context) {

    final ProgressDialog pr = ProgressDialog(context);
    pr.style(
        message: LocaleKeys.preparing_your_smart_tracking_dashboard.tr(),
      messageTextStyle: TextStyle(
        color: Colors.black.withOpacity(0.5)
      )
    );

    Future<bool> exitWillPop() {
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(LocaleKeys.confirmation.tr(),
              style: new TextStyle(color: Colors.black, fontSize: 20.0)),
          content: new Text('Do you want to exit'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                // this line exits the app.
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child:
              new Text('Yes', style: new TextStyle(fontSize: 18.0)),
            ),
            new FlatButton(
              onPressed: () => Navigator.pop(context), // this line dismisses the dialog
              child: new Text(LocaleKeys.cancel.tr(), style: new TextStyle(fontSize: 18.0)),
            )
          ],
        ),
      ) ??
          false;
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffefefef),
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: exitWillPop,
        child: Container(

          decoration: BoxDecoration(

              image: DecorationImage(
                alignment: Alignment.bottomRight,

                image: AssetImage('assets/Earth-.png'),
                colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.2), BlendMode.dstATop),
              )
          ),
          child: Stack(
            children: [

              ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 30),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                                width: 33,
                                height: 33,

                                decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(left: 7),
                                    child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 18,))

                            ),
                            Container(
                                height: size.height*0.15,
                                width: size.width*0.7,
                                child: Hero(
                                  tag: 'GIF',
                                    child: Image.asset('assets/trans-anim.gif'))
                            ),
                          ],
                        ),
                        SizedBox(height: size.height*0.06,),
                        Container(
                          height: size.height*0.47,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0,8),
                                    blurRadius: 10,
                                    spreadRadius: 0.01,
                                    color: Colors.green[100]
                                )
                              ]
                          ),
                          child: Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 23.0,right: 23),
                                child: Column(
                                  children: [
                                    SizedBox(height: size.height*0.025,),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 3,),
                                      child: Row(
                                        children: [
                                          Text(LocaleKeys.Username.tr()),
                                        ],
                                      ),
                                    ),
                                    RoundedTextField(
                                      controller: usernameCont,
                                      hintText: LocaleKeys.enter_username.tr(),
                                      onChnaged: (value) {
                                        _username = value;
                                      },
                                    ),
                                    SizedBox(

                                      child:  Padding(
                                        padding: const EdgeInsets.only(top: 15,bottom: 3),
                                        child: Row(
                                          children: [
                                            Text(LocaleKeys.password.tr()),
                                          ],
                                        ),
                                      ),
                                    ),
                                    RoundedPasswordTextField(
                                      controller: passwordCont,
                                      obscuretext: _hidePassword,
                                      hintText: LocaleKeys.enter_password.tr(),
                                      press: () {
                                        setState(() {
                                          _hidePassword = !_hidePassword;
                                        });
                                      },
                                      onChnaged: (value) {
                                        _password = value;
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(LocaleKeys.forgot_password.tr(),style: TextStyle(color: Colors.lightGreen),),
                                    ),
                                    SizedBox(height: size.height*0.08,),
                                    Container(
                                      height: 40,
                                      width: size.width * 0.35,
                                      decoration: BoxDecoration(
                                          color: Color(0xff7EC049),
                                          borderRadius: BorderRadius.circular(8)),
                                      child: TextButton(
                                        onPressed: () async {
                                          print('username----------------$_username');
                                          print('password----------------$_password');
                                          if(_username==null && _password==null)
                                          {
                                            simpleAlertBox(context, Text(LocaleKeys.failed_to_login.tr()),
                                                Text(LocaleKeys.Enter_correct_Username_and_Password.tr()),
                                                    () async {
                                                  Navigator.pop(context);
                                                  pr.hide();
                                                });
                                          }
                                          else{

                                          FocusScope.of(context).unfocus();
                                          await pr.show();
                                          if (_username != null && _password != null) {

                                            String dateTime = DateTime.now().toString();
                                            await logInUser(context: context, username: _username, password: _password, dateTime: dateTime).then((value)async {
                                              if (value == "successful") {
                                                print("Log in successful");
                                                await prefs.setLoginCred(_username, _password);
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                                              } else {
                                                print("Failed to log in");
                                                simpleAlertBox(context, Text(LocaleKeys.failed_to_login.tr()),
                                                    Text(LocaleKeys.Enter_correct_Username_and_Password.tr()),
                                                        () async {
                                                      Navigator.pop(context);
                                                      pr.hide();
                                                    });
                                              }
                                            });
                                          }
                                          }

                                        },
                                        child: Text(
                                          LocaleKeys.login.tr(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
