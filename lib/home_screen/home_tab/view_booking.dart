// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, deprecated_member_use, duplicate_ignore, sort_child_properties_last

import 'package:flutter/material.dart';

class ViewBooking extends StatelessWidget {
  static String viewBookingId = "view_booking";
  bool isLiked = true;
  String workspaceName, date, time, imgPath;
  ViewBooking(this.imgPath, this.workspaceName, this.date, this.time);

  @override
  Widget build(BuildContext context) {
    const kDarkRed = Color.fromARGB(255, 140, 1, 1);

    return Column(
      children: [
        Container(
          height: 410,
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    offset: Offset(-10, 10),
                    blurRadius: 20,
                    spreadRadius: 4),
              ]),
          child: Column(children: [
            Stack(
              children: [
                Card(
                  elevation: 5,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
                  child: Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                            fit: BoxFit.fill, image: AssetImage(imgPath))),
                  ),
                ),
              ],
            ),
            Container(
              height: 200,
              width: 300,
              padding: EdgeInsets.all(20),
              // color: Colors.green,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("WorkSpace Name:  ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(workspaceName,
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Row(
                      children: [
                        Text("Date:  ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(date,
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Row(
                      children: [
                        Text("Time:  ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(time,
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RaisedButton(
                            onPressed: () {},
                            child: Icon(Icons.edit),
                            color: kDarkRed,
                            textColor: Colors.white,
                          ),
                          RaisedButton(
                            onPressed: () {},
                            child: Icon(Icons.cancel_sharp),
                            color: kDarkRed,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ]),
            )
          ]),
        ),
        Padding(padding: EdgeInsets.only(top: 25)),
        SizedBox(
          width: 300,
          // ignore: deprecated_member_use
          child: RaisedButton(
            onPressed: () {},
            child: Text(
              "Return Home",
              style: TextStyle(fontSize: 18),
            ),
            color: kDarkRed,
            textColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
        ),
      ],
    );
  }
}
