import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pbox/widgets/responsive.dart';

class BuyEmoji extends StatelessWidget {
  final String artistemail;
  final String email;
  BuyEmoji({super.key, required this.artistemail, required this.email});
  final List celebdata = [];
  final PriceEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          TextButton.icon(
            onPressed: () { Navigator.pop(context);},
            icon: const Icon(
              Icons.keyboard_double_arrow_left,
              size: 10.0,
            ),
            label: const Text(
              'BACK',
              style: TextStyle(fontSize: 10),
            ),
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                side: BorderSide(width: 1, color: Colors.white),
                minimumSize: Size(20, 20),
                primary: Colors.white,
                backgroundColor: Colors.transparent),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 60, right: 40),
            child: Text(
              'BUY EMOJI',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
        ]),
        //centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.blue, Colors.lightBlueAccent]),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Container(
            height: 700,
            width: MediaQuery.of(context).size.width - 1.0,
            margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child:
            Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                Widget>[
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('ArtistBids')
                        .where("email", isEqualTo: artistemail)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                            MediaQuery.of(context).size.width *
                                0.4 /
                                (MediaQuery.of(context).size.height *
                                    0.35 /
                                    1)),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot doc = snapshot.data!.docs[index];
                          return Row(
                            children: [
                              if (ResponsiveWidget.isSmallScreen(context))
                                GestureDetector(
                                  child: Container(
                                      height: MediaQuery.of(context).size.height * 0.35,
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Stack(
                                        children: [
                                          Stack(
                                            children: [
                                              CachedNetworkImage(
                                              imageUrl: doc['ImageURL'],
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.35,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.5,
                                              imageBuilder:
                                                  (context, imageProvider) =>
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
                                              errorWidget:
                                                  (context, url, error) =>
                                                  Icon(Icons.error),
                                            ),
                                              Padding(
                                                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.28),
                                                child: Container(
                                                  color: Colors.black,
                                                  height: MediaQuery.of(context).size.height*0.2,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04),
                                                        child: Text("\$"+doc['Price'], style: TextStyle(color: Colors.white , fontSize: MediaQuery.of(context).size.width*0.05),),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.073),
                                                        child: TextButton(
                                                          onPressed: () {},
                                                          child: const Text(
                                                            'BUY',
                                                            style: TextStyle(fontSize: 10),
                                                          ),
                                                          style: TextButton.styleFrom(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(10.0)),
                                                              side: BorderSide(width: 1, color: Colors.white),
                                                              minimumSize: Size(20, 20),
                                                              primary: Colors.white,
                                                              backgroundColor: Colors.transparent),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ]
                                          ),
                                        ],
                                      )),
                                  onTap: () {
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(builder: (context) => ArtistProfile(email: email , artistemail: artistemail)));
                                  },
                                ),
                              if (ResponsiveWidget.isMediumScreen(context))
                                GestureDetector(
                                  child: Container(
                                      height: MediaQuery.of(context).size.height * 0.35,
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Stack(
                                        children: [
                                          Stack(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: doc['ImageURL'],
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.35,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.5,
                                                  imageBuilder:
                                                      (context, imageProvider) =>
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
                                                  errorWidget:
                                                      (context, url, error) =>
                                                      Icon(Icons.error),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.28),
                                                  child: Container(
                                                    color: Colors.black,
                                                    height: MediaQuery.of(context).size.height*0.2,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04),
                                                          child: Text("\$"+doc['Price'], style: TextStyle(color: Colors.white , fontSize: MediaQuery.of(context).size.width*0.05),),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.073),
                                                          child: TextButton(
                                                            onPressed: () {},
                                                            child: const Text(
                                                              'BUY',
                                                              style: TextStyle(fontSize: 10),
                                                            ),
                                                            style: TextButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(10.0)),
                                                                side: BorderSide(width: 1, color: Colors.white),
                                                                minimumSize: Size(20, 20),
                                                                primary: Colors.white,
                                                                backgroundColor: Colors.transparent),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ]
                                          ),
                                        ],
                                      )),
                                  onTap: () {
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(builder: (context) => ArtistProfile(email: email , artistemail: artistemail)));
                                  },
                                ),
                              if (ResponsiveWidget.isLargeScreen(context))
                                GestureDetector(
                                  child: Container(
                                      height: MediaQuery.of(context).size.height * 0.35,
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Stack(
                                        children: [
                                          Stack(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: doc['ImageURL'],
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.35,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.5,
                                                  imageBuilder:
                                                      (context, imageProvider) =>
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
                                                  errorWidget:
                                                      (context, url, error) =>
                                                      Icon(Icons.error),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.28),
                                                  child: Container(
                                                    color: Colors.black,
                                                    height: MediaQuery.of(context).size.height*0.2,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04),
                                                          child: Text("\$"+doc['Price'], style: TextStyle(color: Colors.white , fontSize: MediaQuery.of(context).size.width*0.05),),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.073),
                                                          child: TextButton(
                                                            onPressed: () {},
                                                            child: const Text(
                                                              'BUY',
                                                              style: TextStyle(fontSize: 10),
                                                            ),
                                                            style: TextButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(10.0)),
                                                                side: BorderSide(width: 1, color: Colors.white),
                                                                minimumSize: Size(20, 20),
                                                                primary: Colors.white,
                                                                backgroundColor: Colors.transparent),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ]
                                          ),
                                        ],
                                      )),
                                  onTap: () {
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(builder: (context) => ArtistProfile(email: email , artistemail: artistemail)));
                                  },
                                ),
                            ],
                          );
                        },
                      );
                    }),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
