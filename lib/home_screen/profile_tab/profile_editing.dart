// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors, duplicate_ignore, prefer_const_constructors_in_immutables, avoid_print, prefer_typing_uninitialized_variables, use_build_context_synchronously, sort_child_properties_last, unnecessary_new

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coworking_space/constants.dart';
import 'package:coworking_space/home_screen/profile_tab/profile_tab.dart';
// import 'package:coworking_space/home_screen/profile_tab/profile_tab.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// import 'package:firebase_storage/firebase_storage.dart';

final _auth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;
final _fireStorage = FirebaseStorage.instance;

// ignore: must_be_immutable
class ProfileEditing extends StatefulWidget {
  // const ProfileEditing({Key? key}) : super(key: key);

  final void Function(String, String, String, String) onPressedCallback;
  ProfileEditing(this.onPressedCallback);

  @override
  State<ProfileEditing> createState() => _ProfileEditingState();
}

class _ProfileEditingState extends State<ProfileEditing>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String? fullNameEdit = _auth.currentUser!.displayName;
  String? bioFieldEdit = "";
  String? emailEdit = _auth.currentUser!.email;
  String? imageURLEdit = sentImageURL;
  String? phoneNoEdit;
  bool showSpinner = false;
  late File _image;

  String? bioInitValue;

  late AnimationController controller;
  bool isLoaded = false;
  bool imageChanged = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false);
    super.initState();
    _getData();

    // getCurrentUser();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _getData() async {
    final data = await _fireStore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => value.data());
    // print(data![stringValue]);
    setState(() {
      fullNameEdit = data!["Full Name"];
      phoneNoEdit = data["phone No"];
      bioFieldEdit = data["bio Field"];
      imageURLEdit = data["profile_PIC"];
    });
    isLoaded = true;
  }

  // String? passwordController;
  String? usernameValidate(String? value) {
    if (value == null || value.isEmpty) {
      return " * Username field isRequired";
    } else if (value.length <= 3) {
      return "*must be more than 3 letters";
    } else {
      fullNameEdit = value;
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return " * Email-address is required";
    } else if (!EmailValidator.validate(value)) {
      return "*Enter a valid email";
    } else {
      emailEdit = value;
    }
    return null;
  }

  String? phoneValidate(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.toString().isEmpty) {
      return null;
    } else if (value.toString().length != 11) {
      showSpinner = false;
      return "*must be 11 digits";
    } else if (!regExp.hasMatch(value.toString())) {
      showSpinner = false;
      return 'Please enter valid mobile number';
    }
    return null;
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
          return CircleAvatar(
            radius: 67,
            backgroundImage: FileImage(_image),
          );
        },
        itemCount: _imageFileList!.length,
      ));
    } else if (_imageFileList == null) {
      return CircleAvatar(
        radius: 67,
        backgroundImage: NetworkImage(sentImageURL),
      );
    } else {
      return CircleAvatar(
        radius: 67,
        backgroundColor: Colors.grey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ModalProgressHUD(
      inAsyncCall: showSpinner,
      progressIndicator: CircularProgressIndicator(color: kDarkRed),
      child: Form(
          key: _formKey,
          child: Container(
            color: Color(0xff757575),
            // height: 500,
            child: Container(
              padding: EdgeInsets.all(20),
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
                Row(
                  children: [
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
                      flex: 1,
                      child: Text(
                        "Edit Profile",
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
                            try {
                              showSpinner = true;
                              // Full name & Email
                              if (_formKey.currentState!.validate()) {
                                await _auth.currentUser!
                                    .updateDisplayName(fullNameEdit);
                                await _auth.currentUser!
                                    .updateEmail(emailEdit!);

                                // image change
                                if (imageChanged == true) {
                                  final imgRef = _fireStorage
                                      .ref()
                                      .child('user_images/')
                                      .child("${_auth.currentUser!.uid}.jpg");
                                  // print(_imageFile);
                                  await imgRef.putFile(_image);
                                  final imgURL = await imgRef.getDownloadURL();
                                  imageURLEdit = imgURL;
                                  await _fireStore
                                      .collection("users")
                                      .doc(_auth.currentUser!.uid)
                                      .set({
                                    "profile_PIC": imageURLEdit,
                                  });
                                }

                                await _fireStore
                                    .collection("users")
                                    .doc(_auth.currentUser!.uid)
                                    .set({
                                  "profile_PIC": imageChanged
                                      ? imageURLEdit
                                      : sentImageURL,
                                  "Full Name": fullNameEdit,
                                  "bio Field": bioFieldEdit,
                                  "Email": emailEdit,
                                  "phone No": phoneNoEdit
                                });

                                if (imageChanged) {
                                  widget.onPressedCallback(
                                    fullNameEdit.toString(),
                                    bioFieldEdit.toString(),
                                    phoneNoEdit.toString(),
                                    imageURLEdit.toString(),
                                  );
                                } else {
                                  widget.onPressedCallback(
                                    fullNameEdit.toString(),
                                    bioFieldEdit.toString(),
                                    phoneNoEdit.toString(),
                                    sentImageURL,
                                  );
                                }
                                Navigator.pop(context);
                              }
                              showSpinner = false;
                            } catch (e) {
                              print(e);
                            }
                          }),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(24.0),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: kDarkRed,
                        child: MaterialButton(
                          child: CircleAvatar(
                            radius: 67,
                            child: previewImages(),
                          ),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // getPhoto(ImageSource.gallery);
                            // print("from on presssed");
                            showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))),
                                    height: 150,
                                    child: Column(children: [
                                      MaterialButton(
                                          onPressed: () {
                                            getPhoto(ImageSource.gallery);
                                            Navigator.pop(context);
                                          },
                                          child: SizedBox(
                                            width: 350,
                                            child: Center(
                                              child: Text(
                                                'Select profile picture',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          )),
                                      MaterialButton(
                                          onPressed: () {},
                                          child: SizedBox(
                                              width: 350,
                                              child: Center(
                                                child: Text(
                                                  'view profile picture',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ))),
                                    ]),
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                    FormTextField(
                      identifier: "Name",
                      placeHolder: "Full Name",
                      initialValue: sentFullName,
                      validator: usernameValidate,
                      onChangedField: (value) {
                        fullNameEdit = value;
                      },
                    ),
                    FormTextField(
                      identifier: "Bio",
                      placeHolder: "Bio",
                      initialValue: sentBio == "null" ? "" : sentBio,
                      onChangedField: (value) {
                        bioFieldEdit = value;
                      },
                    ),
                    FormTextField(
                      identifier: "Email",
                      placeHolder: "Email",
                      initialValue: _auth.currentUser?.email.toString(),
                      validator: validateEmail,
                      onChangedField: (value) {
                        emailEdit = value;
                      },
                    ),
                    FormTextField(
                      identifier: "PhoneNo.",
                      placeHolder: "Phone",
                      initialValue: sentPhoneNo == "null" ? "" : sentPhoneNo,
                      validator: phoneValidate,
                      onChangedField: (value) {
                        phoneNoEdit = value;
                      },
                    ),
                  ],
                )
              ]),
            ),
          )),
    ));
  }
}

// ======================
class FormTextField extends StatelessWidget {
  final String placeHolder;
  final String? Function(String?)? validator;
  final void Function(String)? onChangedField;
  // final void Function(PhoneAuthCredential)? onPhoneSubmit;
  final String? initialValue;
  final String identifier;

  FormTextField({
    required this.placeHolder,
    this.validator,
    // this.onPhoneSubmit,
    this.onChangedField,
    this.initialValue,
    required this.identifier,
    // required this.controllerText,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            identifier,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              // color: Colors.b
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Material(
              color: Colors.white,
              shadowColor: Colors.white,
              elevation: 5,
              borderRadius: BorderRadius.circular(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 5,
                    child: TextFormField(
                      initialValue: initialValue!,
                      // controller: TextEditingController(text: controllerText, te ) ,

                      style: TextStyle(
                        // backgroundColor: Colors.greenAccent,
                        height: 1,
                      ),
                      validator: validator,
                      // onFieldSubmitted: onFieldSubmitted,s
                      onChanged: onChangedField,

                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          height: 0,
                          fontSize: 13,
                        ),
                        contentPadding: EdgeInsets.zero,
                        labelText: placeHolder,
                        labelStyle: TextStyle(
                          height: 1.5,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// =======================================

// Future<void> picBottomSheet(BuildContext context) {
//   return showModalBottomSheet<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10), topRight: Radius.circular(10))),
//           height: 150,
//           child: Column(children: [
//             MaterialButton(
//                 onPressed: () {
//                   getPhoto(ImageSource.gallery);
//                 },
//                 child: SizedBox(
//                   width: 350,
//                   child: Center(
//                     child: Text(
//                       'Select profile picture',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 )),
//             MaterialButton(
//                 onPressed: () {},
//                 child: SizedBox(
//                     width: 350,
//                     child: Center(
//                       child: Text(
//                         'view profile picture',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                     ))),
//           ]),
//         );
//       });
// }
