import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realEstate/screen/auth/login.dart';
import 'package:realEstate/screen/homescreen/home.dart';
import 'package:realEstate/widget/custom_shape.dart';
import 'package:realEstate/widget/responsive_ui.dart';
import 'package:realEstate/widget/textformfield.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController xfname = TextEditingController();
  TextEditingController xphone = TextEditingController();
  TextEditingController xlocation = TextEditingController();
  TextEditingController xpassword = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  bool isregistered = false;

  // register(xfname.text,xphone.text,xpassword.text,xlocation.text);

  Future<dynamic> register(
      String fname, String phone, String password, String location) async {
    String myApi = "http://192.168.43.117/homecare/api/register.php/";
    final response = await http.post(myApi, headers: {
      'Accept': 'application/json'
    }, body: {
      "fname": "$fname",
      "phone": "$phone",
      "password": "$password",
      "location": "$location",
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      if (jsonResponse != null && jsonResponse != 404 && jsonResponse != 500) {
        var json = jsonDecode(response.body);
        print(json.map((e) => e['cargo_no']));
        setState(() {
          isregistered = false;
          xfname.text = "";
          xpassword.text = "";
          xfname.text = "";
          xpassword.text = "";
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
        return Fluttertoast.showToast(
            msg: "Account Successfully Created",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white);
      } else if (jsonResponse == 404) {
        setState(() {
          isregistered = false;
        });
        return Fluttertoast.showToast(
            msg: "Phone Number Already Registered",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white);
      } else if (jsonResponse == 500) {
        setState(() {
          isregistered = false;
        });
        return Fluttertoast.showToast(
            msg: "Server Error Please Try Again Later",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white);
      }
    } else {
      print("no data");
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      child: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              welcomeTextRow(),
              signInTextRow(),
              form(),
              forgetPassTextRow(),
              SizedBox(height: _height / 12),
              button(),
              // signUpTextRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 4
                  : (_medium ? _height / 3.75 : _height / 3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 4.5
                  : (_medium ? _height / 4.25 : _height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Color(0xFFa152ff)],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(
              top: _large
                  ? _height / 10
                  : (_medium ? _height / 10 : _height / 10)),
          child: Center(
            child: CircleAvatar(
              radius: _height / 12.0,
              backgroundColor: Colors.white,
              child: Image.asset(
                'assets/images/home_logo.png',
                height: _height / 3.5,
                width: _width / 2.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
      child: Row(
        children: <Widget>[
          Text(
            "Remote Care App",
            style: TextStyle(
              color: Color(0xFFa152ff),
              fontWeight: FontWeight.bold,
              fontSize: _large ? 50 : (_medium ? 40 : 30),
            ),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Get help easy and simple",
            style: TextStyle(
              color: Color(0xFFa152ff),
              fontWeight: FontWeight.w200,
              fontSize: _large ? 12 : (_medium ? 12 : 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 15.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            fnameTextFormField(),
            SizedBox(height: _height / 40.0),
            emailTextFormField(),
            SizedBox(height: _height / 40.0),
            locationTextFormField(),
            SizedBox(height: _height / 40.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      textEditingController: xphone,
      icon: Icons.phone,
      hint: "Phone Number",
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: xpassword,
      icon: Icons.lock,
      obscureText: true,
      hint: "Password",
    );
  }

  Widget fnameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: xfname,
      icon: Icons.person,
      obscureText: true,
      hint: "Full Name",
    );
  }

  Widget locationTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      textEditingController: xlocation,
      icon: Icons.location_city,
      obscureText: true,
      hint: "Location",
    );
  }

  Widget forgetPassTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Already have account?",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text(
              "Login",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.orange[200]),
            ),
          )
        ],
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        print("Register");
        if (xfname.text == "" "" ||
            xphone.text == "" ||
            xpassword.text == "" ||
            xlocation.text == "") {
          () {
            return Fluttertoast.showToast(
                msg: "Please Provied All records",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white);
          }();
        } else {
          register(xfname.text, xphone.text, xpassword.text, xlocation.text);
        }
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Color(0xFFa152ff), Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Register',
                style: TextStyle(
                    fontSize: _large ? 14 : (_medium ? 12 : 10),
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            isregistered
                ? SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account?",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              "Sign up",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.orange[200],
                  fontSize: _large ? 19 : (_medium ? 17 : 15)),
            ),
          )
        ],
      ),
    );
  }
}
