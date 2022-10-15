// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pbox/widgets/responsive.dart';

import 'MyProfile.dart';
import 'artist_profile.dart';
import 'change_password.dart';
import 'history_screen.dart';
import 'loginscreen.dart';
import 'my_bid_screen.dart';

class HomeScreen extends StatelessWidget {
  final String email;
  HomeScreen({super.key, required this.email});
  late String ImageURL;
  late String star;
  bool isButtonPressed = false;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String getImageURL(ImageURL) {
    return this.ImageURL = ImageURL;
  }

  String getstar(star) {
    return this.star = star;
  }

  @override
  Widget build(BuildContext context) {
    String artistemail;
    print(email);
    final Stream<QuerySnapshot> fstream = FirebaseFirestore.instance
        .collection('Users')
        .where("Role", isEqualTo: "Celebrity")
        .snapshots();
    final Stream<QuerySnapshot> ustream = FirebaseFirestore.instance
        .collection('Users')
        .where("Email", isEqualTo: email)
        .snapshots();
    final List celebdata = [];

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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => MyBidScreen(email: email)));
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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => HistoryScreen(email: email)));
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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => MyProfile(email: email)));
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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ChangePassword(email: email)));
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
          leading: Builder(
            builder: (BuildContext context) {
              return ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(00.0),
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
          title: Text("Home"),
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
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.013),
                                          child: Text(
                                            "POPULARITY",
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
                                                      .height *
                                                  0.005),
                                        ),
                                        for (int i = 1; i <= doc['star']; i++)
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 12,
                                          ),

                                        //count = celebdata[0]['star'],
                                        if (doc['star'] == 0)
                                          for (int i = 0; i < 5; i++)
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 12,
                                            ),

                                        if (doc['star'] == 1)
                                          for (int i = 2; i <= 5; i++)
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 12,
                                            ),

                                        if (doc['star'] == 2)
                                          for (int i = 3; i <= 5; i++)
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 12,
                                            ),

                                        if (doc['star'] == 3)
                                          for (int i = 4; i <= 5; i++)
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 12,
                                            ),

                                        if (doc['star'] == 4)
                                          for (int i = 5; i <= 5; i++)
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 12,
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
                                    ),
                                  ),
                                ],
                              )),
                          onTap: () {
                            artistemail = doc['Email'];
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => ArtistProfile(email: email , artistemail: artistemail)));
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
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.013),
                                          child: Text(
                                            "POPULARITY",
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
                                                      .height *
                                                  0.005),
                                        ),
                                        for (int i = 1; i <= doc['star']; i++)
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 12,
                                          ),

                                        //count = celebdata[0]['star'],
                                        if (doc['star'] == 0)
                                          for (int i = 0; i < 5; i++)
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 12,
                                            ),

                                        if (doc['star'] == 1)
                                          for (int i = 2; i <= 5; i++)
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 12,
                                            ),

                                        if (doc['star'] == 2)
                                          for (int i = 3; i <= 5; i++)
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 12,
                                            ),

                                        if (doc['star'] == 3)
                                          for (int i = 4; i <= 5; i++)
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 12,
                                            ),

                                        if (doc['star'] == 4)
                                          for (int i = 5; i <= 5; i++)
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 12,
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
                                    ),
                                  ),
                                ],
                              )),
                          onTap: () {
                            artistemail = doc['Email'];
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => ArtistProfile(email: email , artistemail: artistemail)));
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
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.013),
                                          child: Text(
                                            "POPULARITY",
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
                                                      .height *
                                                  0.005),
                                        ),
                                        for (int i = 1; i <= doc['star']; i++)
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 12,
                                          ),

                                        //count = celebdata[0]['star'],
                                        if (doc['star'] == 0)
                                          for (int i = 0; i < 5; i++)
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 12,
                                            ),

                                        if (doc['star'] == 1)
                                          for (int i = 2; i <= 5; i++)
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 12,
                                            ),

                                        if (doc['star'] == 2)
                                          for (int i = 3; i <= 5; i++)
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 12,
                                            ),

                                        if (doc['star'] == 3)
                                          for (int i = 4; i <= 5; i++)
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 12,
                                            ),

                                        if (doc['star'] == 4)
                                          for (int i = 5; i <= 5; i++)
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 12,
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
                                    ),
                                  ),
                                ],
                              )),
                          onTap: () {
                            artistemail = doc['Email'];
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => ArtistProfile(email: email , artistemail: artistemail)));
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

