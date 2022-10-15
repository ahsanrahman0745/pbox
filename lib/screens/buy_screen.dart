// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'buy_emoji.dart';

class BuyScreen extends StatelessWidget {
  final String email;
  final String artistemail;
  const BuyScreen({super.key, required this.email, required this.artistemail});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BuyEmoji(email: email , artistemail: artistemail)));
                },
                child: Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.12,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(
                          Icons.emoji_emotions,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.09,
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.03),
                        child: Text(
                          "Emogis",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.43),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => BuyEmoji(email: email , artistemail: artistemail)));
                },
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.12,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.09,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.03),
                      child: Text(
                        "Vemogis",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.399),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BuyEmoji(email: email , artistemail: artistemail)));
                },
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.12,
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        Icons.handshake_outlined,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.09,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.03),
                      child: Text(
                        "Merchandising",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.26),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
