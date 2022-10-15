
//import 'dart:html';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbox/widgets/responsive.dart';
import '../utils/assets.dart';
import 'package:transparent_image_button/transparent_image_button.dart';
import 'package:image_downloader/image_downloader.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'Enter_Gallery_bid.dart';
import 'enter_bid.dart';

class GalleryBid extends StatelessWidget {
  final String email;
  final String artistemail;
  GalleryBid({super.key, required this.email, required this.artistemail});
  bool isVisible = true;
  String? theimage;
  String? swapimage;
  String? img;
  final List celebdata = [];
  @override
  void setState(Null Function() param0) {
    //img = Image.network(${selected_image_URL}) as Image;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> fstream = FirebaseFirestore.instance
        .collection('ArtistBids')
        .where("email", isEqualTo: artistemail)
        .snapshots();
    // final Stream<QuerySnapshot> fstream = FirebaseFirestore.instance.collection(
    //     'ArtistBids').where("email", isEqualTo: ${myemail}).snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: fstream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          snapshot.data!.docs.map((DocumentSnapshot e) {
            Map dis = e.data() as Map<String, dynamic>;
            celebdata.add(dis);
          }).toList();

          theimage = celebdata[0]['ImageURL'];
          swapimage = celebdata[1]['ImageURL'];
          print(theimage);
          print(swapimage);

          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                actions: <Widget>[
                  Row(
                    children: <Widget>[
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            side: BorderSide(color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          // <-- Icon
                          Icons.keyboard_double_arrow_left,
                          color: Colors.white,
                        ),
                        label: Text(
                          'BACK',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      if (ResponsiveWidget.isSmallScreen(context))
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.05),
                          child: Center(
                              child: Text(
                            "GALLERY",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )),
                        ),
                      if (ResponsiveWidget.isMediumScreen(context))
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.05),
                          child: Center(
                              child: Text(
                            "GALLERY",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )),
                        ),
                      if (ResponsiveWidget.isLargeScreen(context))
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.05),
                          child: Center(
                              child: Text(
                            "GALLERY",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )),
                        ),
                      if (ResponsiveWidget.isSmallScreen(context))
                        Padding(
                            padding: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.height * 0.07)),
                      if (ResponsiveWidget.isMediumScreen(context))
                        Padding(
                            padding: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.height * 0.07)),
                      if (ResponsiveWidget.isLargeScreen(context))
                        Padding(
                            padding: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.height * 0.07)),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => EnterGalleryBid(email: email , artistemail: artistemail,imageurl: theimage!)));
                          },
                          icon: Icon(
                            // <-- Icon
                            Icons.hardware_rounded,
                            color: Colors.white,
                          ),
                          label: Text(
                            'BID',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              extendBodyBehindAppBar: true,
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(theimage!),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                height: MediaQuery.of(context).size.height * 0.14,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (ResponsiveWidget.isSmallScreen(context))
                      celebdata[1]['ImageURL'] == null
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01))
                          : Visibility(
                              visible: isVisible,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(swapimage!),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      //img = Image.network(celebdata[1]['ImageURL']);
                                      img = theimage;
                                    });
                                    setState(() {
                                      theimage = swapimage;
                                      print(celebdata[5]['ImageURL']);
                                    });
                                    setState(() {
                                      swapimage = img;
                                      print('$theimage');
                                      print('update=> $swapimage');
                                    });
                                    //super.initState();
                                  },
                                ),
                              ),
                            ),
                    if (ResponsiveWidget.isMediumScreen(context))
                      celebdata[1]['ImageURL'] == null
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01))
                          : Visibility(
                              visible: isVisible,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: CachedNetworkImage(
                                  imageUrl: celebdata[1]['ImageURL'],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    if (ResponsiveWidget.isLargeScreen(context))
                      celebdata[1]['ImageURL'] == null
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01))
                          : Visibility(
                              visible: isVisible,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: CachedNetworkImage(
                                  imageUrl: celebdata[1]['ImageURL'],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    if (ResponsiveWidget.isSmallScreen(context))
                      celebdata[2]['ImageURL'] == null
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01))
                          : Visibility(
                              visible: isVisible,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: CachedNetworkImage(
                                  imageUrl: celebdata[2]['ImageURL'],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    if (ResponsiveWidget.isMediumScreen(context))
                      celebdata[2]['ImageURL'] == null
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01))
                          : Visibility(
                              visible: isVisible,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: CachedNetworkImage(
                                  imageUrl: celebdata[2]['ImageURL'],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    if (ResponsiveWidget.isLargeScreen(context))
                      celebdata[2]['ImageURL'] == null
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01))
                          : Visibility(
                              visible: isVisible,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: CachedNetworkImage(
                                  imageUrl: celebdata[2]['ImageURL'],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    if (ResponsiveWidget.isSmallScreen(context))
                      celebdata[3]['ImageURL'] == null
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01))
                          : Visibility(
                              visible: isVisible,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: CachedNetworkImage(
                                  imageUrl: celebdata[3]['ImageURL'],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    if (ResponsiveWidget.isMediumScreen(context))
                      celebdata[3]['ImageURL'] == null
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01))
                          : Visibility(
                              visible: isVisible,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: CachedNetworkImage(
                                  imageUrl: celebdata[3]['ImageURL'],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    if (ResponsiveWidget.isLargeScreen(context))
                      celebdata[3]['ImageURL'] == null
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01))
                          : Visibility(
                              visible: isVisible,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: CachedNetworkImage(
                                  imageUrl: celebdata[3]['ImageURL'],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    if (ResponsiveWidget.isSmallScreen(context))
                      celebdata[4]['ImageURL'] == null
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01))
                          : Visibility(
                              visible: isVisible,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: CachedNetworkImage(
                                  imageUrl: celebdata[4]['ImageURL'],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    if (ResponsiveWidget.isMediumScreen(context))
                      celebdata[4]['ImageURL'] == null
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01))
                          : Visibility(
                              visible: isVisible,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: CachedNetworkImage(
                                  imageUrl: celebdata[4]['ImageURL'],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    if (ResponsiveWidget.isLargeScreen(context))
                      celebdata[4]['ImageURL'] == null
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01))
                          : Visibility(
                              visible: isVisible,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: CachedNetworkImage(
                                  imageUrl: celebdata[4]['ImageURL'],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
