import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbox/widgets/responsive.dart';
import '../generated_plugin_registrant.dart';
import '../utils/assets.dart';

class GalleryBuy extends StatelessWidget {
  const GalleryBuy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {},
                icon: Icon(
                  // <-- Icon
                  Icons.keyboard_double_arrow_left,
                  color: Colors.white,
                ),
                label: Text(
                  'BACK',
                  style: TextStyle(color: Colors.white),
                ),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(15),
                //   side: BorderSide(color: Colors.white),
                // ),
              ),
              if (ResponsiveWidget.isSmallScreen(context))
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.05),
                  child: Center(
                      child: Text(
                    "GALLERY",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )),
                ),
              if (ResponsiveWidget.isMediumScreen(context))
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.05),
                  child: Center(
                      child: Text(
                    "GALLERY",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )),
                ),
              if (ResponsiveWidget.isLargeScreen(context))
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.05),
                  child: Center(
                      child: Text(
                    "GALLERY",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )),
                ),
              if (ResponsiveWidget.isSmallScreen(context))
                Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.07)),
              if (ResponsiveWidget.isMediumScreen(context))
                Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.07)),
              if (ResponsiveWidget.isLargeScreen(context))
                Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.07)),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(
                    // <-- Icon
                    Icons.add_card_outlined,
                    color: Colors.white,
                  ),
                  label: Text(
                    'BUY',
                    style: TextStyle(color: Colors.white),
                  ),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(15),
                  //   side: BorderSide(color: Colors.white),
                  // ),
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
            image: AssetImage(Assets.pic1),
            fit: BoxFit.cover,
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
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Image.asset(Assets.pic2, fit: BoxFit.fill),
              ),
            if (ResponsiveWidget.isMediumScreen(context))
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Image.asset(Assets.pic2, fit: BoxFit.fill),
              ),
            if (ResponsiveWidget.isLargeScreen(context))
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Image.asset(Assets.pic2, fit: BoxFit.fill),
              ),
            if (ResponsiveWidget.isSmallScreen(context))
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Image.asset(Assets.pic3, fit: BoxFit.fill),
              ),
            if (ResponsiveWidget.isMediumScreen(context))
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Image.asset(Assets.pic3, fit: BoxFit.fill),
              ),
            if (ResponsiveWidget.isLargeScreen(context))
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Image.asset(Assets.pic3, fit: BoxFit.fill),
              ),
            if (ResponsiveWidget.isSmallScreen(context))
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Image.asset(Assets.pic4, fit: BoxFit.fill),
              ),
            if (ResponsiveWidget.isMediumScreen(context))
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Image.asset(Assets.pic4, fit: BoxFit.fill),
              ),
            if (ResponsiveWidget.isLargeScreen(context))
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Image.asset(Assets.pic4, fit: BoxFit.fill),
              ),
            if (ResponsiveWidget.isSmallScreen(context))
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.13,
                child: Image.asset(Assets.pic5, fit: BoxFit.fill),
              ),
            if (ResponsiveWidget.isMediumScreen(context))
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.13,
                child: Image.asset(Assets.pic5, fit: BoxFit.fill),
              ),
            if (ResponsiveWidget.isLargeScreen(context))
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.13,
                child: Image.asset(Assets.pic5, fit: BoxFit.fill),
              ),
          ],
        ),
      ),
    );
  }
}
