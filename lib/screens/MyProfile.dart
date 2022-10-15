import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_screen.dart';

class MyProfile extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final UserNameEditingController = new TextEditingController();
  final NameEditingController = new TextEditingController();
  final PasswordEditingController = new TextEditingController();
  final EmailEditingController = new TextEditingController();
  final ContactEditingController = new TextEditingController();
  final String email;
  MyProfile({super.key, required this.email});
  bool isSignupScreen = true;
  bool isMale = true;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> ustream = FirebaseFirestore.instance
        .collection('Users')
        .where("Email", isEqualTo: email)
        .snapshots();
    print(email);
    final List celebdata = [];

    return Scaffold(
      drawer: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .where("Email", isEqualTo: email)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            snapshot.data!.docs.map((DocumentSnapshot e) {
              Map dis = e.data() as Map<String, dynamic>;
              celebdata.add(dis);
            }).toList();

            return Drawer(
              backgroundColor: Colors.grey[850],
              width: 160,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05),
                    child: Container(
                      height: 146,
                      color: Colors.grey[850],
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: CachedNetworkImage(
                                imageUrl: celebdata[0]['ImageURL'],
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  backgroundImage: imageProvider,
                                  radius: 50,
                                ),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              //backgroundImage: doc['ImageURL'],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              celebdata[0]['Name'],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03),
                    child: GestureDetector(
                      child: Container(
                        height: 80,
                        child: Column(
                          children: [
                            Icon(
                              Icons.house,
                              color: Color(0xFFF2F2F2),
                              size: 35,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                color: Color(0xFFF2F2F2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen(email: email)));
                      },
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      height: 80,
                      child: Column(
                        children: [
                          Icon(
                            Icons.hardware_rounded,
                            color: Color(0xFFF2F2F2),
                            size: 35,
                          ),
                          Text(
                            'My Bid',
                            style: TextStyle(
                              color: Color(0xFFF2F2F2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => MyBidPage(email: email)));
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      height: 80,
                      child: Column(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Color(0xFFF2F2F2),
                            size: 35,
                          ),
                          Text(
                            'History',
                            style: TextStyle(
                              color: Color(0xFFF2F2F2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => HistoryPage(email: email)));
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      height: 80,
                      child: Column(
                        children: [
                          Icon(
                            Icons.person,
                            color: Color(0xFFF2F2F2),
                            size: 35,
                          ),
                          Text(
                            'My Profile',
                            style: TextStyle(
                              color: Color(0xFFF2F2F2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => MyProfilePage(email: email)));
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      height: 80,
                      child: Column(
                        children: [
                          Icon(
                            Icons.vpn_key_outlined,
                            color: Color(0xFFF2F2F2),
                            size: 35,
                          ),
                          Text(
                            'Change Password',
                            style: TextStyle(
                              color: Color(0xFFF2F2F2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => ChangePasswordPage(email: email)));
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      height: 80,
                      child: Column(
                        children: [
                          Icon(
                            Icons.power_settings_new_outlined,
                            color: Color(0xFFF2F2F2),
                            size: 35,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Color(0xFFF2F2F2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => signOut()));
                    },
                  ),
                ],
              ),
            );
          }),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.lightBlueAccent,
        leading: Builder(
          builder: (BuildContext context) {
            return ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlueAccent,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(00.0),
                  ),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 20,
                ),
                label: Text(
                  "",
                  style: TextStyle(color: Colors.white, fontSize: 6),
                ));
          },
        ),
        centerTitle: true,
        title: Text("MY PROFILE"),
      ),
      backgroundColor: Colors.blue,
      body: StreamBuilder<QuerySnapshot>(
          stream: ustream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            snapshot.data!.docs.map((DocumentSnapshot e) {
              Map dis = e.data() as Map<String, dynamic>;
              celebdata.add(dis);
            }).toList();

            if (celebdata[0]['Gender'] == "Male")
              isMale = true;
            else
              isMale = false;

            final UserNameField = TextFormField(
              autofocus: false,
              controller: UserNameEditingController,
              keyboardType: TextInputType.text,
              onSaved: (value) {
                UserNameEditingController.text = value!;
              },
              validator: (text) {
                if (text == null || text.isEmpty) {
                  UserNameEditingController.text = celebdata[0]['UserName'];
                  //return 'UserName cannot be empty';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                contentPadding: const EdgeInsets.all(10),
                hintText: celebdata[0]['UserName'],
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            );
            final NameField = TextFormField(
              autofocus: false,
              controller: NameEditingController,
              keyboardType: TextInputType.name,
              onSaved: (value) {
                NameEditingController.text = value!;
              },
              validator: (text) {
                if (text == null || text.isEmpty) {
                  NameEditingController.text = celebdata[0]['Name'];
                  //return 'Name cannot be empty';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                contentPadding: const EdgeInsets.all(10),
                hintText: celebdata[0]['Name'],
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            );
            final EmailField = TextFormField(
              autofocus: false,
              controller: EmailEditingController,
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) {
                EmailEditingController.text = value!;
              },
              validator: (text) {
                if (text == null || text.isEmpty) {
                  EmailEditingController.text = celebdata[0]['Email'];
                  //return 'Email cannot be empty';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                contentPadding: const EdgeInsets.all(10),
                hintText: celebdata[0]['Email'],
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            );
            final ContactField = TextFormField(
              autofocus: false,
              controller: ContactEditingController,
              keyboardType: TextInputType.phone,
              onSaved: (value) {
                ContactEditingController.text = value!;
              },
              validator: (text) {
                if (text == null || text.isEmpty) {
                  ContactEditingController.text = celebdata[0]['Contact'];
                  //return 'Contact Num cannot be empty';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                contentPadding: const EdgeInsets.all(10),
                hintText: celebdata[0]['Contact'],
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            );
            final UpdateButton = Material(
              child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateuser();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Account Updated')),
                    );

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            HomeScreen(email: EmailEditingController.text)));
                  }
                },
                child: Text(
                  'UPDATE PROFILE',
                ),
                style: TextButton.styleFrom(
                    minimumSize: Size(300, 40),
                    primary: Colors.white,
                    backgroundColor: Colors.indigo),
              ),
            );

            return Stack(children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 200,
                  child: CachedNetworkImage(
                    imageUrl: celebdata[0]['ImageURL'],
                    height: MediaQuery.of(context).size.height *
                        0.35,
                    width:
                    MediaQuery.of(context).size.width * 0.5,
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                              // colorFilter:
                              // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                            ),
                          ),
                        ),
                    placeholder: (context, url) =>
                        CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error),
                  ),
                  // child: Container(
                  //   padding: const EdgeInsets.only(top: 90, left: 20),
                  //   color: const Color(0xFF3b5999).withOpacity(.45),
                  // ),
                ),
              ),
              Positioned(
                top: 160,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height*0.45,
                      width: MediaQuery.of(context).size.width - 40.0,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 5),
                          ]),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 20.0,
                              left: 20.0,
                              right: 20.0,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        UserNameField,
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          child: NameField,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          child: EmailField,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          child: ContactField,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                UpdateButton,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]);
          }),
    );
  }

  void setState(Null Function() param0) {}

  Future updateuser() async {
    try {
      print(email);

      FirebaseFirestore.instance
          .collection("Users")
          .doc(UserNameEditingController.text)
          .update({
        "UserName": UserNameEditingController.text,
        "Name": NameEditingController.text,
        "Email": EmailEditingController.text,
        "Contact": ContactEditingController.text,
      });
    } catch (e) {
      print(e);
    }
  }
}
