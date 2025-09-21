import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/controller/auth_provider.dart';
import 'package:task/view/home.dart';
import 'package:task/view/loginPage.dart';


class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    await auth.loadFromPrefs();
    await Future.delayed(Duration(milliseconds: 600));
    if (auth.currentEmail != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(
        'Social App',
         style: TextStyle(
          fontSize: 28, 
          fontWeight: FontWeight.bold
          )
        )
      ),
    );
  }
}
