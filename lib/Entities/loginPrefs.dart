

import 'package:shared_preferences/shared_preferences.dart';

class LoginSharePref
{
///email1 and pass1 is for changing pages from loading screen
  Future setLoginCred(String email,String pass)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('pass', pass);
    await prefs.setString('email1', email);
    await prefs.setString('pass1', pass);
  }

  Future clearLoginCred()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('email', null);
    // await prefs.setString('pass', null);
    await prefs.remove('email1');
    await prefs.remove('pass1');
  }

  Future<String> getEmail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    if(email==null){
      return null;
    }
    else{
      return email;
    }
  }


  Future<String> getPass()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pass = prefs.getString('pass');
    if(pass==null){
      return null;
    }
    else{
      return pass;
    }
  }

  Future<String> getEmailOne()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email1');
    if(email==null){
      return null;
    }
    else{
      return email;
    }
  }


  Future<String> getPassOne()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pass = prefs.getString('pass1');
    if(pass==null){
      return null;
    }
    else{
      return pass;
    }
  }
}