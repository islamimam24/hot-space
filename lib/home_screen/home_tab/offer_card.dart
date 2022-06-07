// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, camel_case_types, unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, sort_child_properties_last, prefer_typing_uninitialized_variables

import 'package:coworking_space/home_screen/home_tab/view_booking.dart';
import 'package:flutter/material.dart';
import 'package:coworking_space/constants.dart';
import 'package:coworking_space/home_screen/home_screen.dart';

class OfferCard extends StatelessWidget {
  static String ofersId = "offer_card";
  String workspaceName, city, imageUrl, price, offerPercentage;
  num offerPrice;
  final void Function() callBackFunc;

  OfferCard(this.imageUrl, this.workspaceName, this.city, this.price,
      this.offerPercentage, this.offerPrice, this.callBackFunc);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        highlightColor: kDarkRed,
        onPressed: () {
          Navigator.pushNamed(context, ViewBooking.viewBookingId);
        },
        child: Stack(
          children: [
            Container(
              // height: 200,
              // width: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white,
                        // offset: Offset(-10, 10),
                        blurRadius: 20,
                        spreadRadius: 10),
                  ]),
            ),
            Positioned(
                left: 5,
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  )),
                  child: Container(
                    height: 150,
                    width: 190,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        image: DecorationImage(
                            fit: BoxFit.fill, image: NetworkImage(imageUrl))),
                  ),
                )),
            Positioned(
                left: 5,
                width: 70,
                height: 25,
                child: Card(
                  // padding: EdgeInsets.all(7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                  )),
                  child: Text(
                    "$offerPercentage% OFF",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  color: Color(0xFFA01810),
                )),
            Positioned(
                left: 220,
                child: Container(
                  height: 150,
                  width: 150,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  // color: Colors.green,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(workspaceName,
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        Text(city, style: TextStyle(color: kDarkRed)),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Color(0xFFffcc00),
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Color(0xFFffcc00),
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Color(0xFFffcc00),
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Color(0xFFffcc00),
                              size: 15,
                            ),
                            Icon(
                              Icons.star_border,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "$price LE/hr",
                              style: TextStyle(
                                  fontSize: 13,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Padding(padding: EdgeInsets.all(5)),
                            Text(
                              "$offerPrice LE/hr",
                              style: TextStyle(
                                  color: Color(0xFFA01810), fontSize: 13),
                            ),
                          ],
                        ),
                        BookingButton(callBackFunc)
                      ]),
                )),
          ],
        ),
      ),
    );
  }
}

class BookingButton extends StatefulWidget {
  final void Function() secCallBack;
  // ignore: prefer_const_constructors_in_immutables
  BookingButton(this.secCallBack);

  @override
  State<BookingButton> createState() => _BookingButtonState();
}

class _BookingButtonState extends State<BookingButton> {
  @override
  Widget build(BuildContext context) {
    if (isOfferAtProfile == false) {
      return Positioned(
          top: 110,
          left: 205,
          child: MaterialButton(
            onPressed: widget.secCallBack,
            child: Container(
              color: kDarkRed,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                "Book",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ));
    } else {
      return SizedBox.shrink();
    }
  }
}
