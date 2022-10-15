// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Edit_bid.dart';

// ignore: must_be_immutable
class MyBidScreen extends StatelessWidget {
  final String email;
  final List bidsdata = [];
  MyBidScreen({super.key, required this.email});
  var time =
      "${TimeOfDay.now().hour.toString()} : ${TimeOfDay.now().minute.toString()}";
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> bidstream = FirebaseFirestore.instance
        .collection('EnterGalleryBid')
        .where("Email", isEqualTo: email)
        .snapshots();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
                    'MY BID',
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
            stream: bidstream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              snapshot.data!.docs.map((DocumentSnapshot e) {
                Map dis = e.data() as Map<String, dynamic>;
                bidsdata.add(dis);
              }).toList();
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];

                return Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.04),
                child: Container(
                    height: MediaQuery.of(context).size.height*0.13,
                    color: Colors.lightBlue,
                    child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(height / 80.3),
                                color: Colors.black,
                              ),
                              height: MediaQuery.of(context).size.height*0.1,
                              width: MediaQuery.of(context).size.height*0.1,
                              child: CachedNetworkImage(
                                imageUrl: doc['ImageURL'],
                                height: MediaQuery.of(context).size.height*0.1,
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
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(height / 100.375),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            style: TextStyle(
                                                fontSize: height / 50.18,
                                                color: Colors.white),
                                            'Current Bid'),
                                        Text(doc['Time']
                                            // style: TextStyle(
                                            //     fontSize: height / 57.35,
                                            //     color: Colors.white),
                                            ),
                                        ElevatedButton(
                                            style:
                                            ElevatedButton.styleFrom(
                                              primary: Color(0xffff3157),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:BorderRadius.circular(
                                                  height / 32.12,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder: (context) => EditBid(email: email , bidtime: doc['Time'] , imgurl: doc['ImageURL'])));
                                            },
                                            child: Text("Change Bid")
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.keyboard_arrow_right,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]
                    )
                ),
              );
                  });
                }
                )

        );
  }
}
