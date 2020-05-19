import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

String url =
    'https://images.pexels.com/photos/4239547/pexels-photo-4239547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    BorderRadiusGeometry radius = BorderRadius.only(
        topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0));
    Widget image_carousel = new Container(
      height: 250.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('./assets/images/3.jpg'),
          AssetImage('./assets/images/17.jpg'),
          AssetImage('./assets/images/9.jpg'),
          AssetImage('./assets/images/10.jpg'),
          AssetImage('./assets/images/3.jpg'),
          AssetImage('./assets/images/16.jpg'),
        ],
        autoplay: false,
        //animationCurve: Curves.fastOutSlowIn,
        //animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 4.0,
        dotBgColor: Colors.transparent,
      ),
    );
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple),
      home: Scaffold(
        //drawerEdgeDragWidth: 100,
        body: Stack(children: <Widget>[
          //image_carousel,
         // DrawerTile(),
        ]),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * .30,
      height: size.height,
      color: Colors.white,
      child: Drawer(
        elevation: 10, 
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text("Category Lists"),
            ),
            CustomListTile(Icons.person, "Profile", () => {}),
          ],
        ),
      )
    );
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;
  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
          splashColor: Colors.blueAccent,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          text,
                          style: TextStyle(fontSize: 16.0),
                        )),
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
