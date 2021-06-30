import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realEstate/screen/homescreen/callhistory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  final String phonenumber;

  Profile({this.phonenumber});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int counter = 0;
  var value;

  @override
  void initState() {
    getdata();
    print("dato# ${widget.phonenumber}");
    if (widget.phonenumber == null ||
        widget.phonenumber == "" ||
        widget.phonenumber != null) {
      getPatientPage();
    } else {
      getPatientPage();
    }
    super.initState();
  }

  Future<dynamic> getDoctorName(String doctorId) async {
    String myApi = "http://192.168.1.55/homecare/api/get_doctor_phone.php";
    final response = await http.post(myApi, headers: {
      'Accept': 'application/json'
    }, body: {
      "doctor_id": "$doctorId",
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse != null && jsonResponse != 404 && jsonResponse != 500) {
        var json = jsonDecode(response.body);
        print("data# $json");
        return json;
      } else if (jsonResponse == 404) {
      } else if (jsonResponse == 500) {}
    } else {
      print("no data");
    }
  }

  Future<dynamic> getPatientPage() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'phone';
    final value = prefs.get(key) ?? 0;

    String myApi = "http://192.168.1.55/homecare/api/getpatient.php";
    final response = await http.post(myApi, headers: {
      'Accept': 'application/json'
    }, body: {
      "patient_id": "$value",
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      // print(jsonResponse);
      if (jsonResponse != null && jsonResponse != 404 && jsonResponse != 500) {
        var json = jsonDecode(response.body);
        return json;
      } else if (jsonResponse == 404) {
      } else if (jsonResponse == 500) {}
    } else {
      print("no data");
    }
  }

  Future<dynamic> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'phone';
    final value = prefs.get(key) ?? 0;

    String myApi = "http://192.168.1.55/homecare/api/getpatient.php";
    final response = await http.post(myApi, headers: {
      'Accept': 'application/json'
    }, body: {
      "patient_id": "${widget.phonenumber}",
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      // print(jsonResponse);
      if (jsonResponse != null && jsonResponse != 404 && jsonResponse != 500) {
        var json = jsonDecode(response.body);
        print("data# $json");
        return json;
      } else if (jsonResponse == 404) {
      } else if (jsonResponse == 500) {}
    } else {
      print("no data");
    }
  }

  getdata() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'myinfo';
    value = prefs.get(key) ?? 0;
    print("myinfo jamani $value");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => CallHistory()),
        //     );
        //   },
        //   child: Container(
        //     width: 60,
        //     height: 60,
        //     child: Icon(Icons.phone),
        //     decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         gradient: LinearGradient(
        //           colors: [Colors.deepPurple[800], Colors.deepPurpleAccent],
        //         )),
        //   ),
        // ),
        body: FutureBuilder(
      future: getPatientPage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                print("myrede ${snapshot.data}");
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurple[800],
                            Colors.deepPurpleAccent
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          SizedBox(
                            height: 110.0,
                          ),
                          CircleAvatar(
                            radius: 65.0,
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text('${snapshot.data[index]['fname']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Patient',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          )
                        ]),
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      child: Center(
                          child: Card(
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              child: Container(
                                  width: 310.0,
                                  height: 290.0,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Information",
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey[300],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.call,
                                              color: Colors.blueAccent[400],
                                              size: 35,
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Phone Number",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                Text(
                                                  "+255 ${snapshot.data[index]['phone']}",
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.grey[400],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.map,
                                              color: Colors.yellowAccent[400],
                                              size: 35,
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Location",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                Text(
                                                  "${snapshot.data[index]['location']}",
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.grey[400],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.ac_unit,
                                              color: Colors.yellowAccent[400],
                                              size: 35,
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Age",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                Text(
                                                  "${snapshot.data[index]['age']}",
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.grey[400],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: Colors.yellowAccent[400],
                                              size: 35,
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Doctor Name",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                FutureBuilder(
                                                    future: getDoctorName(
                                                        snapshot.data[index]
                                                            ['doctor_id']),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .done) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            snapshot.data[index]
                                                                        [
                                                                        'fname'] ==
                                                                    null
                                                                ? "No Doctor Assigned"
                                                                : "${snapshot.data[index]['fname']}",
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: Colors
                                                                  .grey[400],
                                                            ),
                                                          );
                                                        } else {
                                                          return SizedBox();
                                                        }
                                                      } else {
                                                        return SizedBox();
                                                      }
                                                    }
                                                    // child: Text(
                                                    //   "${snapshot.data[index]['age']}",
                                                    //   style: TextStyle(
                                                    //     fontSize: 12.0,
                                                    //     color: Colors.grey[400],
                                                    //   ),
                                                    // ),
                                                    )
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )))),
                    )
                  ],
                );
              },
            );
          } else {
            return Center(
              child: Text('No Data Found'),
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ));
  }
}
