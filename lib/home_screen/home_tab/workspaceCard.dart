// ignore_for_file: file_names, camel_case_types, use_key_in_widget_constructors, unnecessary_this, prefer_const_constructors, must_be_immutable, no_logic_in_create_state, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class workspaceCard extends StatefulWidget {
  String workspaceName, city, price, imgPath;
  workspaceCard(this.imgPath, this.workspaceName, this.city, this.price);

  @override
  State<workspaceCard> createState() => _workspaceCardState(
      this.imgPath, this.workspaceName, this.city, this.price);
}

class _workspaceCardState extends State<workspaceCard> {
  bool isLiked = true;
  String workspaceName, city, price, imgPath;
  _workspaceCardState(this.imgPath, this.workspaceName, this.city, this.price);

  @override
  Widget build(BuildContext context) {
    const kDarkRed = Color.fromARGB(255, 140, 1, 1);

    return Expanded(
      child: Container(
        height: 260,
        margin: EdgeInsets.all(5),
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
                  height: 150,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      image: DecorationImage(
                          fit: BoxFit.fill, image: AssetImage(imgPath))),
                ),
              ),
              Positioned(
                top: 10,
                right: 15,
                // ignore: deprecated_member_use
                child: InkWell(
                    // color: kDarkRed,
                    child: isLiked
                        ? Icon(
                            Icons.favorite_border_outlined,
                            size: 20,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.favorite,
                            size: 20,
                            color: kDarkRed,
                          ),
                    onTap: () => {
                          setState(() => {isLiked = !isLiked})
                        }),
              ),
            ],
          ),
          Container(
            height: 100,
            width: 160,
            padding: EdgeInsets.symmetric(vertical: 5),
            // color: Colors.green,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(workspaceName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Padding(padding: EdgeInsets.symmetric(vertical: 2)),
              Text(city, style: TextStyle(color: kDarkRed)),
              Padding(padding: EdgeInsets.symmetric(vertical: 2)),
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
              Padding(padding: EdgeInsets.symmetric(vertical: 2)),
              Text(
                price,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ]),
          )
        ]),
      ),
    );
  }
}
