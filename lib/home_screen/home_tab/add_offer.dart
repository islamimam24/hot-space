// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:coworking_space/constants.dart';
import 'offer_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final List<Widget> offerCard = [];

class AddOfferBottomSheet extends StatefulWidget {
  const AddOfferBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddOfferBottomSheet> createState() => _AddOfferBottomSheetState();
}

class _AddOfferBottomSheetState extends State<AddOfferBottomSheet> {
  final _fireStorage = FirebaseStorage.instance;
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? wsImage, wsName, wsLocation, wsPrice, wsOfferPercentage, imageEditURL;
  late File _image;
  bool imageChanged = false;
  num? wsOfferPrice;
  bool showSpinner = false;

  num? offerPriceCalc(String numb1, String numb2) {
    final wsOfferPrice = int.parse(numb1) * (1 - (int.parse(numb2) / 100));
    return wsOfferPrice;
  }

  List<XFile>? _imageFileList;
  bool isUploaded = false;
  _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  Future<void> getPhoto(ImageSource source) async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(source: source);
      setState(() {
        _imageFile(pickedFile);
        imageChanged = true;
      });
      isUploaded = true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Widget previewImages() {
    if (_imageFileList != null) {
      return Semantics(
        child: ListView.builder(
          key: UniqueKey(),
          itemBuilder: (BuildContext context, int index) {
            _image = File(_imageFileList![index].path);
            return Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(_image), fit: BoxFit.cover),
              ),
            );
          },
          itemCount: _imageFileList!.length,
        ),
      );
      // }  else if (_imageFileList == null) {
      //   return Container(
      //     color: Colors.white,
      //     child: Center(
      //         child: Icon(
      //       Icons.add_a_photo,
      //       size: 20,
      //     )),
      //   );

    } else {
      return Container(
        color: Colors.white,
        child: Center(
            child: Icon(
          Icons.add_a_photo,
          size: 20,
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: CircularProgressIndicator(color: kDarkRed),
      inAsyncCall: showSpinner,
      color: Colors.white,
      // opacity: 1,
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            )),
        child: Column(children: [
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Add a Space",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: kDarkRed),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                    child: Text(
                      "Done",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                    onTap: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final offerPrice = offerPriceCalc(
                            wsPrice.toString(), wsOfferPercentage.toString());

                        final imgRef = _fireStorage
                            .ref()
                            .child('workspace_images/')
                            .child("${_auth.currentUser!.uid}.jpg");
                        // print(_imageFile);
                        await imgRef.putFile(_image);
                        final imgURL = await imgRef.getDownloadURL();
                        imageEditURL = imgURL;

                        await _fireStore.collection("workspaces").doc().set({
                          "profile_PIC": imageEditURL,
                          "name": wsName,
                          "city": wsLocation,
                          "price": wsPrice,
                          "offerDiscount": wsOfferPercentage
                        });

                        offerCard.add(OfferCard(
                            imageEditURL.toString(),
                            wsName.toString(),
                            wsLocation.toString(),
                            wsPrice.toString(),
                            wsOfferPercentage.toString(),
                            offerPrice!,
                            () {}));

                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        setState(() {
                          showSpinner = false;
                        });
                        setState(() {});
                      } catch (e) {
                        // ignore: avoid_print
                        print(e);
                      }
                    }),
              )
            ]),
          ),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: MaterialButton(
              child: previewImages(),
              onPressed: () {
                getPhoto(ImageSource.gallery);
                // Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  FormTextFieldConst(
                    placeHolder: "Name",
                    identifier: "Name",
                    onChangedField: (value) {
                      wsName = value;
                    },
                  ),
                  FormTextFieldConst(
                    placeHolder: "City",
                    identifier: "City",
                    onChangedField: (value) {
                      wsLocation = value;
                    },
                  ),
                  FormTextFieldConst(
                    placeHolder: "Price",
                    identifier: "Price",
                    onChangedField: (value) {
                      wsPrice = value;
                    },
                  ),
                  FormTextFieldConst(
                    placeHolder: "offer %",
                    identifier: "offer Discount",
                    onChangedField: (value) {
                      wsOfferPercentage = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          // FormTextFieldConst(
          //   placeHolder: "offerPrice",
          //   identifier: "offer price",
          //   onChangedField: (value) {
          //     wsOfferPrice = value;
          //   },
          // ),
        ]),
      ),
    );
  }
}
