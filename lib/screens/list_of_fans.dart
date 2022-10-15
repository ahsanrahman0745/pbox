import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pbox/screens/loginscreen.dart';
import 'package:pbox/screens/profile_accept_request_screen.dart';
import 'package:pbox/screens/upload_emoji.dart';
import 'dart:ui' as ui;
import 'dart:ui' as ui show Image;

import '../utils/assets.dart';
import '../widgets/responsive.dart';
import 'ArtistProfile.dart';
import 'MyProfile.dart';

class FanList extends StatelessWidget {
  final String artistemail;
  FanList({super.key, required this.artistemail});
  late String ImageURL;
  late String star;
  bool isButtonPressed = false;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    print(artistemail);
    final Stream<QuerySnapshot> fstream = FirebaseFirestore.instance
        .collection('Users')
        .where("Role", isEqualTo: "Fan")
        .snapshots();
    final Stream<QuerySnapshot> ustream = FirebaseFirestore.instance
        .collection('Users')
        .where("Email", isEqualTo: artistemail)
        .snapshots();
    final List celebdata = [];
    final List biddata = [];


    return Scaffold(
        drawer: StreamBuilder<QuerySnapshot>(
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
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05),
                        child: Container(
                          height: 80,
                          child: Column(
                            children: [
                              Icon(
                                Icons.house_sharp,
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
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                FanList(artistemail: artistemail)));
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
                              'Profile',
                              style: TextStyle(
                                color: Color(0xFFF2F2F2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ArtistProfile(artistemail: artistemail)));
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        height: 80,
                        child: Column(
                          children: [
                            Icon(
                              Icons.emoji_emotions_outlined,
                              color: Color(0xFFF2F2F2),
                              size: 35,
                            ),
                            Text(
                              'Emoji',
                              style: TextStyle(
                                color: Color(0xFFF2F2F2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => UploadEmoji(artistemail: artistemail)));
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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                    ),
                  ],
                ),
              );
            }),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          leading: Builder(builder: (BuildContext context) {
            return ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(0.0),
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
          }),
          centerTitle: true,
          title: Text("LIST OF FANS"),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: fstream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width *
                        0.5 /
                        (MediaQuery.of(context).size.height * 0.35 / 1)),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  return Row(
                    children: [
                      if (ResponsiveWidget.isSmallScreen(context))
                        GestureDetector(
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: doc['ImageURL'],
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
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.3),
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('EnterBid')
                                            .where("Email", isEqualTo: doc['Email'])
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

                                          return Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.013),
                                                child: Text(
                                                  "BID AMOUNT",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.02),
                                              ),
                                              Text(
                                                "\$"+biddata[0]['BidAmount'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.044),
                                              ),
                                              Stack(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.027,
                                                        top: 10),
                                                    child: CustomPaint(
                                                      size: Size(
                                                          30,
                                                          (MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                              0.1 *
                                                              0.925)
                                                              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                                                      painter: RPSCustomPainter(),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.05,
                                                        top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.023),
                                                    child: Icon(Icons.arrow_forward,
                                                        color: Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.06),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        }
                                    ),
                                 )
                                ],
                              )),
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => ProfileAcceptRequestScreen(artistemail: artistemail , fanemail: doc['Email'])));
                          },
                        ),
                      if (ResponsiveWidget.isMediumScreen(context))
                        GestureDetector(
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: doc['ImageURL'],
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
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                        MediaQuery.of(context).size.height *
                                            0.3),
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('EnterBid')
                                            .where("Email", isEqualTo: doc['Email'])
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

                                          return Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.013),
                                                child: Text(
                                                  "BID AMOUNT",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.02),
                                              ),
                                              Text(
                                                "\$"+doc['BidAmount'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.044),
                                              ),
                                              Stack(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.023,
                                                        top: 10),
                                                    child: CustomPaint(
                                                      size: Size(
                                                          30,
                                                          (MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                              0.1 *
                                                              0.925)
                                                              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                                                      painter: RPSCustomPainter(),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.054,
                                                        top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.025),
                                                    child: Icon(Icons.arrow_forward,
                                                        color: Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.05),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        }
                                    ),
                                  )
                                ],
                              )),
                          onTap: () {
                            String fanemail = doc['email'];
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => ProfileAcceptRequestScreen(artistemail: artistemail , fanemail: fanemail)));
                          },
                        ),
                      if (ResponsiveWidget.isLargeScreen(context))
                        GestureDetector(
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: doc['ImageURL'],
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
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                        MediaQuery.of(context).size.height *
                                            0.3),
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('EnterBid')
                                            .where("Email", isEqualTo: doc['Email'])
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

                                          return Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.013),
                                                child: Text(
                                                  "BID AMOUNT",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.02),
                                              ),
                                              Text(
                                                "\$"+doc['BidAmount'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.044),
                                              ),
                                              Stack(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.023,
                                                        top: 10),
                                                    child: CustomPaint(
                                                      size: Size(
                                                          30,
                                                          (MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                              0.1 *
                                                              0.925)
                                                              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                                                      painter: RPSCustomPainter(),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.054,
                                                        top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.025),
                                                    child: Icon(Icons.arrow_forward,
                                                        color: Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.05),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        }
                                    ),
                                  )
                                ],
                              )),
                          onTap: () {
                            String fanemail = doc['email'];
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => ProfileAcceptRequestScreen(artistemail: artistemail , fanemail: fanemail)));
                          },
                        ),
                    ],
                  );
                },
              );
            }));
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    @override

        // final double height = 100;
        // final double width = 100;
        Paint paint = Paint();

    Path mainBackground = Path();
    //mainBackground.addRect(Rect.fromLTRB(0,0,width,height));
    paint.color = Colors.blue;
    canvas.drawPath(mainBackground, paint);

    Path path0 = Path();
    path0.moveTo(size.width * 0.9912500, size.height * 0.0060000);
    path0.lineTo(size.width * 0.9937500, size.height * 0.9940000);
    path0.lineTo(size.width * 0.0012500, size.height * 0.9880000);
    path0.lineTo(size.width * 0.9912500, size.height * 0.0060000);
    path0.close();

    paint.color = Colors.blue;

    canvas.drawPath(path0, paint);

    @override
    bool shouldrepaint(CustomPainter oldDelegate) {
      return oldDelegate != this;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
