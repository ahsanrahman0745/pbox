// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, must_be_immutable

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/assets.dart';

class ProfileAcceptRequestScreen extends StatelessWidget {
  final String artistemail;
  final String fanemail;

  ProfileAcceptRequestScreen({super.key, required this.artistemail, required this.fanemail});

  @override
  List biddata = [];
  List userdata = [];

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _bidamount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(artistemail);
    print(fanemail);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xffff3155),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: width,
                height: height / 14.29,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffff3155),
                      Color(0xffff704c),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () { Navigator.pop(context);},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(height / 32.12),
                              bottomRight: Radius.circular(height / 32.12),
                            ),
                            border: Border.all(color: Colors.white, width: 2)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: width / 65.5,
                              horizontal: height / 80.3),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.keyboard_double_arrow_left,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Back",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text("Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: height / 44.61)),
                    SizedBox(
                      width: width / 7.86,
                    )
                  ],
                ),
              ),
              Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xffff704c),
                            Color(0xffff3155),
                          ],
                        ),
                      ),
                      child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Users')
                                  .where("Email", isEqualTo: fanemail)
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
                              userdata.add(dis);
                              }).toList();

                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: 0,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: height / 3.21,
                                color: Colors.red),
                          ),
                          Positioned(
                            top: height / 20.07,
                              child: CachedNetworkImage(
                                imageUrl: userdata[0]['ImageURL'],
                                height: MediaQuery.of(context).size.height *
                                    0.17,
                                width:
                                MediaQuery.of(context).size.width * 0.4,
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
                            ),
                          Positioned(
                            top: height / 4.015,
                            bottom: height / 80.3,
                            child: SingleChildScrollView(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(height / 80.3),
                                  color: Colors.white,
                                ),
                                width: width / 1.12,
                                child: Padding(
                                  padding: EdgeInsets.all(height / 50.18),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.01 , left:MediaQuery.of(context).size.height*0.01),
                                            child: Text("Name"),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        controller: _name,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0,
                                              horizontal: height / 53.53),
                                          hintText: userdata[0]['Name'],
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                height / 80.3),
                                          ),
                                        ),
                                        onSaved: (value) {
                                          _name.text = userdata[0]['Name'];
                                        },
                                      ),
                                      SizedBox(height: height / 50.9),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.01 , left:MediaQuery.of(context).size.height*0.01),
                                            child: Text("Email"),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        controller: _email,
                                        onSaved: (value) {
                                          _email.text = userdata[0]['Email'];
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0,
                                              horizontal: height / 53.53),
                                          hintText: userdata[0]['Email'],
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                height / 80.3),
                                          ),
                                        ),
                                        validator: (String? text) {
                                          if (text == null || text.isEmpty) {
                                            _email.text = userdata[0]['Email'];
                                          }
                                        },
                                      ),
                                      SizedBox(height: height / 50.9),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.01 , left:MediaQuery.of(context).size.height*0.01),
                                            child: Text("Contact"),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        controller: _contact,
                                        onSaved: (value) {
                                          _contact.text = userdata[0]['Contact'];
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0,
                                              horizontal: height / 53.53),
                                          hintText: userdata[0]['Contact'],
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                height / 80.3),
                                          ),
                                        ),
                                        validator: (String? text) {
                                          if (text == null || text.isEmpty) {
                                            _contact.text = userdata[0]['Contact'];
                                          }
                                        },
                                      ),
                                      SizedBox(height: height / 50.9),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.01 , left:MediaQuery.of(context).size.height*0.01),
                                            child: Text("Bid Amount"),
                                          ),
                                        ],
                                      ),
                                      StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('EnterBid')
                                            .where("Email", isEqualTo: fanemail)
                                            .where("ArtistEmail", isEqualTo: artistemail)
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
                                            biddata.add(dis);
                                            }).toList();
                                            return TextFormField(
                                              controller: _bidamount,
                                              onSaved: (value) {
                                                _bidamount.text = biddata[0]['BidAmount'];
                                              },
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: height / 53.53),
                                                hintText: biddata[0]['BidAmount'],
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(
                                                      height / 80.3),
                                                ),
                                              ),
                                              validator: (String? text) {
                                                if (text == null || text.isEmpty) {
                                                  _bidamount.text = biddata[0]['BidAmount'];
                                                }
                                              },
                                            );
                                        }
                                      ),
                                      SizedBox(height: height / 50.9),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xff40639d),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  height / 80.3)),
                                          fixedSize: Size(double.maxFinite, 50.0),
                                        ),
                                        onPressed: () {
                                          _name.text= userdata[0]['Name'];
                                          _email.text= userdata[0]['Email'];
                                          _bidamount.text= biddata[0]['BidAmount'];
                                          _contact.text= userdata[0]['Contact'];
                                          String amount = biddata[0]['BidAmount'];
                                          AcceptRequest(amount);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Bid Accepted')),
                                          );
                                        },
                                        child: Text(
                                          "ACCEPT REQUEST",
                                          style:
                                              TextStyle(fontSize: height / 44.61),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );}),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
  Future AcceptRequest(String amount) async {
    Map<String, dynamic> AcceptRequest = {
      "name": _name.text,
      "email": _email.text,
      "contact": _contact.text,
      "bidamount": _bidamount.text,
      "FanEmail": this.fanemail,
      "ArtistEmail": this.artistemail,
    };
    await FirebaseFirestore.instance
        .collection("AcceptRequest")
        .doc()
        .set(AcceptRequest)
        .whenComplete(() {
    });

    Map<String, dynamic> History = {
      "email": fanemail,
      "activity": "Your Bid of $amount is accepted.",
    };

    await FirebaseFirestore.instance
        .collection("History")
        .doc()
        .set(History)
        .whenComplete(() {
      print("$fanemail.History created");
    });

      FirebaseFirestore.instance
          .collection("EnterBid")
          .doc(biddata[0]['EventName'])
          .update({
        "Status": "Accepted",
      });
  }
}

