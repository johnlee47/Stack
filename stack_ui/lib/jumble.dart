import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackui/UI/AccountPage.dart';
import 'package:stackui/UI/CategoryPage.dart';
import 'package:stackui/UI/HomePage.dart';
import 'package:stackui/bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class jumble extends StatefulWidget {
  @override
  _jumbleState createState() => _jumbleState();
}

class DrawerTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Drawer(
      elevation: 10,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text("Category Lists"),
          ),
          CustomListTile(Icons.person, "Profile", () => {}),
        ],
      ),
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

class _jumbleState extends State<jumble> {
  BottomNavigationBloc _bottomNavigationBloc;
  int index;
  bool openDrawer = false;
  bool openCart = false;
  bool setTimer = false;
  bool allowTransition = true;
  int horizontalDragBuildUp = 0;
  int verticalDragBuildUp = 0;

  void callTransition(int index) {
    _bottomNavigationBloc.add(TransitionEvent(index: index));
  }

  void setResetTimer() {
    Timer(Duration(seconds: 1), () {
      allowTransition = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _bottomNavigationBloc = BlocProvider.of<BottomNavigationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
      if (state is TransitionState) {
        index = state.index;
      } else if (state is InitialBottomNavigationState) {
        index = state.index;
      } else if (state is CartState) {
        openCart = state.openCart;
      } else if (state is DrawerState) {
        openDrawer = state.openDrawer;
      }

      return Scaffold(
        body: Builder(
            builder: (context) => Stack(
                  children: <Widget>[
                    // CustomListTile(Icons.person, "Profile", () => {}),
                    //MyDrawer(),

                    AnimatedPositioned(
                      duration: Duration(milliseconds: 500),
                      width: screenwWidth,
                      top: openCart ? 0 - (screenHeight * 0.10) : 0,
                      left: openDrawer ? 0 - (screenwWidth * 0.30): 0,
                      child: GestureDetector(
                        onHorizontalDragUpdate: (dragDetails) {
                          double draggedScreenPercentageY =
                              dragDetails.globalPosition.dy / screenHeight;
                          double draggedScreenPercentageX =
                              dragDetails.globalPosition.dx / screenwWidth;

                          if (draggedScreenPercentageX < 0.3 &&
                              draggedScreenPercentageX > 0) {
                            if (dragDetails.delta.dx > 2) {
                              _bottomNavigationBloc
                                  .add(DrawerTransition(openDrawer: true));
                            }
                          }
                          if (openDrawer) {
                            if (dragDetails.delta.dx < -2) {
                              _bottomNavigationBloc
                                  .add(DrawerTransition(openDrawer: false));
                            }
                          }
//                           else if (draggedScreenPercentageX > 0.6 &&
//                               draggedScreenPercentageX < 0.9) {
//                             if (dragDetails.delta.dx < -3) {
//                               if (index != 2) {
//                                 if (allowTransition) {
//                                   allowTransition = false;
//                                   setResetTimer();
//                                   _bottomNavigationBloc
//                                       .add(TransitionEvent(index: index + 1));
//                                 }
// //
//                               }
//                             }
//                           }
                        },
                        onVerticalDragUpdate: (dragDetails) {
                          double draggedScreenPercentageY =
                              dragDetails.globalPosition.dy / screenHeight;

                          if (draggedScreenPercentageY > 0.8) {
                            if (dragDetails.delta.dy < -2) {
                              _bottomNavigationBloc
                                  .add(CartTransition(openCart: true));
                            }
                          }

                          if (openCart) {
                            if (dragDetails.delta.dy > 2) {
                              _bottomNavigationBloc
                                  .add(CartTransition(openCart: false));
                            }
                          }
//                      print("horizontal position"+"${dragDetails.delta.dx}");
//                      print("vertical position"+"${dragDetails.delta.dy}");
                        },
                        onTap: () {
                          if (openCart) {
                            _bottomNavigationBloc
                                .add(CartTransition(openCart: false));
                          } else if (openDrawer) {
                            _bottomNavigationBloc
                                .add(DrawerTransition(openDrawer: false));
                          }
                        },
                        child: Column(
                          children: <Widget>[
                            //MyDrawer(),
                            Stack(
                              children: <Widget>[

                                AnimatedPositioned(
                                  height: screenHeight * .90,
                                  width: screenwWidth * .30,
                                  left: openDrawer
                                      ? 0
                                      : 0 ,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Material(
                                        type: MaterialType.card,
                                        color: Colors.white24,
                                        elevation: 10,
                                        shadowColor: Colors.black,
                                        child:  Text("hi"),),
                                        //CustomListTile(Icons.person, "Profile", () => {}),),
                                  ),
                                  duration: Duration(milliseconds: 17),
                                ),
                                SizedBox.fromSize(
                                  size: Size(
                                      MediaQuery.of(context).size.width,
                                      MediaQuery.of(context).size.height *
                                          0.90),
                                  child: IndexedStack(
                                    index: index,
                                    children: <Widget>[
                                      //DrawerTile(),
                                      HomePage(),
                                      CategoryPage(),
                                      AccountPage()
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                SizedBox.fromSize(
                                    size: Size(
                                        MediaQuery.of(context).size.width / 3,
                                        MediaQuery.of(context).size.height *
                                            0.10),
                                    child: Material(
                                      type: MaterialType.card,
                                      color: Colors.white,
                                      elevation: 3,
                                      child: IconButton(
                                        onPressed: () {
                                          callTransition(0);
                                        },
                                        icon: Icon(
                                          Icons.home,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    )),
                                SizedBox.fromSize(
                                    size: Size(
                                        MediaQuery.of(context).size.width / 3,
                                        MediaQuery.of(context).size.height *
                                            0.10),
                                    child: Material(
                                      type: MaterialType.card,
                                      color: Colors.white,
                                      elevation: 3,
                                      child: IconButton(
                                        onPressed: () {
                                          callTransition(1);
                                        },
                                        icon: Icon(
                                          Icons.category,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    )),
                                SizedBox.fromSize(
                                    size: Size(
                                        MediaQuery.of(context).size.width / 3,
                                        MediaQuery.of(context).size.height *
                                            0.10),
                                    child: Material(
                                      type: MaterialType.card,
                                      color: Colors.white,
                                      elevation: 3,
                                      child: IconButton(
                                        onPressed: () {
                                          callTransition(2);
                                        },
                                        icon: Icon(
                                          Icons.account_circle,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      height: screenHeight / 10,
                      width: screenwWidth,
                      top: openCart
                          ? screenHeight - (screenHeight / 10)
                          : screenHeight,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(2, 10, 2, 5),
                        child: Material(
                          type: MaterialType.card,
                          color: Colors.white24,

//                          borderRadius: BorderRadius.only(topLeft: Radius.circular(0),topRight: Radius.circular(0),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                          elevation: 10,
                          shadowColor: Colors.black,

                          child: Center(
                            child: Text("Cart Here",
                                style: TextStyle(
                                    fontFamily: 'KaushanScript-Regular',
                                    fontSize: 25,
                                    color: Colors.yellowAccent)),
                          ),
                        ),
                      ),
                      duration: Duration(milliseconds: 500),
                    )
                  ],
                )),
      );
    });
  }
}
