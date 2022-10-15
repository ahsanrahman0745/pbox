// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'artist_bid_profile_screen.dart';
import 'artist_services.dart';

class ArtistProfile extends StatelessWidget {
  final String email;
  final String artistemail;
  final List artistdata = [];
  final List imgdata = [];
  ArtistProfile({super.key, required this.email, required this.artistemail});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> thestream = FirebaseFirestore.instance
        .collection('ArtistData')
        .where("ArtistEmail", isEqualTo: artistemail)
        .snapshots();
    Future AddToFavourite(String artistname) async{
      print(artistname);
      Map<String, dynamic> Favorites = {
        "ArtistEmail": artistemail,
        "userEmail": email,
      };

      await FirebaseFirestore.instance
          .collection("Favorites")
          .doc(artistemail)
          .set(Favorites)
          .whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Celebrity has been Added to your Favourites.')),
        );
      });


      Map<String, dynamic> History = {
        "email": email,
        "activity": "$artistname has been Added to your Favourites",
      };

       await FirebaseFirestore.instance
          .collection("History")
          .doc()
          .set(History)
          .whenComplete(() {
        print("$email.History created");
      });

    }
    print (email);
    print(artistemail);
    final Stream<QuerySnapshot> celebstream = FirebaseFirestore.instance
        .collection('ArtistData')
        .where("ArtistEmail", isEqualTo: artistemail)
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

                        print(imgdata[0]['ImageURL']);
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                            Container(
                                height: MediaQuery.of(context).size.height*0.9,
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
                                child: Column(children: <Widget>[
                                  Column(
                                    children: [
                                      Container(
                                            margin: const EdgeInsets.only(
                                              top: 20.0,
                                              left: 20.0,
                                              right: 20.0,
                                            ),
                                            child: Column(
                                              children: [
                                                TextFormField(
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
                                                    hintText: artistdata[0]['ArtistName'],
                                                    hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                                                  child: TextFormField(
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
                                                      hintText: artistdata[0]['ArtistDOB'],
                                                      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                                                  child: TextFormField(
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
                                                      hintText: artistdata[0]['ArtistFB'],
                                                      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                                                  child: TextFormField(
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
                                                      hintText: artistdata[0]['ArtistTwitter'],
                                                      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                                                  child: TextFormField(
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
                                                      hintText: artistdata[0]['ArtistInstagram'],
                                                      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                                                  child: TextFormField(
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
                                                      hintText: artistdata[0]['ArtistFavPlace'],
                                                      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                                                  child: TextFormField(
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
                                                      hintText: artistdata[0]['ArtistFavSong'],
                                                      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                                                  child: TextFormField(
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
                                                      hintText: artistdata[0]['ArtistFavMovie'],
                                                      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    String artistname = artistdata[0]['ArtistName'];
                                                    AddToFavourite(artistname);
                                                  },
                                                  child: Text(
                                                    'ADD TO FAVORITE',
                                                  ),
                                                  style: TextButton.styleFrom(
                                                      minimumSize: Size(300, 40),
                                                      primary: Colors.white,
                                                      backgroundColor: Colors.indigo),
                                                ),
                                              ],
                                            ),
                                          ),
                                    ],
                                  ),
                                ])),
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

