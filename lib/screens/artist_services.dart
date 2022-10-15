// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/widgets/responsive.dart';
import 'bid_screen.dart';
import 'buy_screen.dart';

class ArtistServices extends StatelessWidget {
  final String email;
  final String artistemail;
  const ArtistServices({super.key, required this.email, required this.artistemail});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blue[300],
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: "You can bid on",
              ),
              Tab(
                text: "You can buy",
              ),
            ],
          ),
          backgroundColor: Colors.lightBlueAccent,
          actions: [
            Row(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
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
                      "ARTIST SERVICES",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )),
                  ),
                if (ResponsiveWidget.isMediumScreen(context))
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.05),
                    child: Center(
                        child: Text(
                      "ARTIST SERVICES",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )),
                  ),
                if (ResponsiveWidget.isLargeScreen(context))
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.05),
                    child: Center(
                        child: Text(
                      "ARTIST SERVICES",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )),
                  ),
                if (ResponsiveWidget.isSmallScreen(context))
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.13),
                  ),
                if (ResponsiveWidget.isMediumScreen(context))
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.13),
                  ),
                if (ResponsiveWidget.isLargeScreen(context))
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.13),
                  ),
              ],
            ),
          ],
        ),
        body: TabBarView(
          children: [
            BidScreen(email: email,artistemail: artistemail),
            BuyScreen(email: email,artistemail: artistemail),
          ],
        ),
      ),
    );
  }
}
