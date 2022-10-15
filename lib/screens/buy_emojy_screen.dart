// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/assets.dart';

class BuyEmojyScreen extends StatefulWidget {
  const BuyEmojyScreen({Key? key}) : super(key: key);

  @override
  State<BuyEmojyScreen> createState() => _BuyEmojyScreenState();
}

class _BuyEmojyScreenState extends State<BuyEmojyScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xff2caefc),
      ),
      child: Scaffold(
        body: SafeArea(
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
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(height / 32.12),
                              bottomRight: Radius.circular(height / 32.12),
                            ),
                            border: Border.all(color: Colors.white, width: 2)),
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
                    Text("ARTIST PROFILE",
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
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: width / 2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2),
                    itemCount: 8,
                    itemBuilder: (BuildContext ctx, index) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                opacity: 0.1,
                                image: AssetImage(Assets.actor1),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.black,
                            ),
                          ),
                          Positioned(
                            left: width / 26.2,
                            top: height / 32.12,
                            child: Container(
                              width: height / 8.03,
                              height: height / 8.03,
                              decoration: BoxDecoration(
                                color: const Color(0xff7c94b6),
                                image: DecorationImage(
                                  image: AssetImage(Assets.actor2),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(height / 16.06)),
                                border: Border.all(
                                  color: Colors.pink,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: width / 26.2,
                            top: height / 32.12,
                            child: Container(
                              width: height / 8.03,
                              height: height / 8.03,
                              decoration: BoxDecoration(
                                color: const Color(0xff7c94b6),
                                image: DecorationImage(
                                  image: AssetImage(Assets.actor3),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(height / 16.06)),
                                border: Border.all(
                                  color: Colors.pink,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: height / 32.12,
                            child: Container(
                              width: height / 8.03,
                              height: height / 8.03,
                              decoration: BoxDecoration(
                                color: const Color(0xff7c94b6),
                                image: DecorationImage(
                                  image: AssetImage(Assets.actor1),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(height / 16.06)),
                                border: Border.all(
                                  color: Colors.pink,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: height / 5.12,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: height / 100.375, horizontal: 0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft:
                                                Radius.circular(height / 32.12),
                                            bottomLeft: Radius.circular(
                                                height / 32.12)),
                                        color: Colors.red),
                                    child: Padding(
                                      padding: EdgeInsets.all(height / 100.375),
                                      child: Text(
                                        "\$43.99",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: height / 50.18,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight:
                                                Radius.circular(height / 32.12),
                                            bottomRight: Radius.circular(
                                                height / 32.12)),
                                        color:
                                            Color.fromARGB(255, 34, 247, 41)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: height / 66.92,
                                          right: height / 66.92,
                                          top: height / 100.375,
                                          bottom: height / 100.375),
                                      child: Text(
                                        "BUY",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: height / 50.18,
                                            color: Color.fromARGB(
                                                255, 94, 94, 94)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
