// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'artist_profile.dart';
import 'artist_services.dart';
import 'gallery_bid.dart';

class ArtistBidProfileScreen extends StatelessWidget {
  final String email;
  final String artistemail;
  final List artistdata = [];
  final List imgdata = [];
  final height = 100;
  final width=100;
  ArtistBidProfileScreen({super.key, required this.email, required this.artistemail});

  @override
  Widget build(BuildContext context) {
    print (email);
    print(artistemail);
    final Stream<QuerySnapshot> celebstream = FirebaseFirestore.instance
        .collection('ArtistBids')
        .where("email", isEqualTo: artistemail)
        .snapshots();
    final Stream<QuerySnapshot> imgstream = FirebaseFirestore.instance
        .collection('Users')
        .where("Email", isEqualTo: artistemail)
        .snapshots();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.keyboard_double_arrow_left,
                    size: 10.0,
                  ),
                  label: const Text(
                    'Back',
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
                  padding: EdgeInsets.only(
                    left: 70,
                  ),
                  child: Text(
                    'ARTIST PROFILE',
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
        backgroundColor: Colors.blue,
        body: StreamBuilder<QuerySnapshot>(
            stream: celebstream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              snapshot.data!.docs.map((DocumentSnapshot e) {
                Map dis = e.data() as Map<String, dynamic>;
                artistdata.add(dis);
              }).toList();
              return Stack(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: imgstream,
                      builder:
                          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        snapshot.data!.docs.map((DocumentSnapshot e) {
                          Map dis = e.data() as Map<String, dynamic>;
                          imgdata.add(dis);
                        }).toList();

                        return Container(
                          height: MediaQuery.of(context).size.height*0.34,
                          child: Column(
                            children:[
                              CachedNetworkImage(
                                imageUrl: imgdata[0]['ImageURL'],
                                height: MediaQuery.of(context).size.height*0.34,
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
                              ),
                            ],
                          ),
                        );
                      }
                  ),
                  Stack(
                    children: [
                      Positioned(
                          top: MediaQuery.of(context).size.height*0.15,
                          child: Column(children: [
                            Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 80.0,
                                    height: 40.0,
                                    child: TextButton.icon(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => ArtistProfile(email: email , artistemail: artistemail)));
                                      },
                                      icon: Icon(Icons.file_copy),
                                      label: const Text(''),
                                      style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(7.0)),
                                          //    side: BorderSide(width: 1, color: Colors.white),
                                          minimumSize: Size(20, 20),
                                          primary: Colors.white,
                                          backgroundColor: Colors.pink),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  SizedBox(
                                    width: 80.0,
                                    height: 40.0,
                                    child: TextButton.icon(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => ArtistBidProfileScreen(email: email , artistemail: artistemail)));
                                      },
                                      icon: Icon(Icons.photo),
                                      label: const Text(''),
                                      style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(7.0)),
                                          //  side: BorderSide(width: 1, color: Colors.white),
                                          minimumSize: Size(20, 20),
                                          primary: Colors.white,
                                          backgroundColor: Colors.orangeAccent),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  SizedBox(
                                    width: 80.0,
                                    height: 40.0,
                                    child: TextButton.icon(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => ArtistServices(email: email , artistemail: artistemail)));
                                      },
                                      icon: Icon(Icons.videocam),
                                      label: const Text(''),
                                      style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(7.0)),
                                          //side: BorderSide(width: 1, color: Colors.white),
                                          minimumSize: Size(20, 20),
                                          primary: Colors.white,
                                          backgroundColor: Colors.blue),
                                    ),
                                  ),
                                ]
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height*0.9,
                              //bottom: height / 16.06,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),
                                  child: Container(
                                      height: MediaQuery.of(context).size.height*0.9,
                                      width: MediaQuery.of(context).size.width*0.9,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GridView.builder(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          ),
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                          DocumentSnapshot doc = snapshot.data!.docs[index];
                                          return Row(
                                            children: [
                                            GestureDetector(
                                            child: Container(
                                              color: Colors.black,
                                              height: MediaQuery.of(context).size.height * 0.1,
                                              width: MediaQuery.of(context).size.width * 0.25,
                                              child: Stack(
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl: doc['ImageURL'],
                                                    height: MediaQuery.of(context).size.height * 0.1,
                                                    width: MediaQuery.of(context).size.width * 0.25,
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
                                                    Center(
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                    errorWidget: (context, url, error) =>
                                                    Icon(Icons.error),
                                                  ),
                                                  Padding(
                                                  padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context).size.height * 0.07),
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height*0.06,
                                                    width: MediaQuery.of(context).size.width * 0.25,
                                                    decoration: BoxDecoration(
                                                      color:Colors.black,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.013),
                                                          child: Text(
                                                          "BID",
                                                          style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(context).size.width*0.04,
                                                          fontWeight: FontWeight.bold),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                                          child: Icon(Icons.arrow_forward , color: Colors.white,size: MediaQuery.of(context).size.width*0.05),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  ),
                                                ],
                                              )
                                            ),
                                            onTap: () {
                                              Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) => GalleryBid(email: email , artistemail: artistemail)));
                                            },
                                            ),
                                            ],
                                          );
                                          },
                                          )),
                                      ),
                                ),
                                ),
                              ),
                          ])
                      ),
                    ],
                  ),
                ],
              );
            }
        )
    );
  }
}
