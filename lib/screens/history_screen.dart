// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HistoryScreen extends StatelessWidget {
  final String email;
  final List historydata = [];
  HistoryScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> historystream = FirebaseFirestore.instance
        .collection('History')
        .where("email", isEqualTo: email)
        .snapshots();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xff2caefc),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xff2caefc),
                  Color(0xff17d6e0),
                ],
              ),
            ),
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
                        Color(0xff2caefc),
                        Color(0xff17d6e0),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () { Navigator.pop(context); },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(height / 32.12),
                                bottomRight: Radius.circular(height / 32.12),
                              ),
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: width / 65.5,
                                horizontal: height / 80.3),
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
                      Text("History",
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
                  StreamBuilder<QuerySnapshot>(
                    stream: historystream,
                    builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                    return Center(
                    child: CircularProgressIndicator(),
                    );
                    }

                    snapshot.data!.docs.map((DocumentSnapshot e) {
                    Map dis = e.data() as Map<String, dynamic>;
                    historydata.add(dis);
                    }).toList();
                      return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,

                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot doc = snapshot.data!.docs[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(height / 80.3)),
                                color: Color(0xff1a6390),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height / 100.375,
                                      horizontal: height / 100.375),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Color(0xff1a6390),
                                        ),
                                        height: height / 10.03,
                                        width: MediaQuery.of(context).size.width*0.05,
                                      ),
                                      SizedBox(
                                        width: height / 80.3,
                                      ),
                                      Flexible(
                                        child: Text(doc['activity'],
                                            style: TextStyle(
                                                fontSize: height / 61.76,
                                                color: Colors.white),
                                      )
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                        );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
