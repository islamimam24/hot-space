// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, must_be_immutable, sort_child_properties_last

import 'package:flutter/material.dart';

const kTextHome = TextStyle(
  color: Colors.grey,
  fontWeight: FontWeight.bold,
  fontSize: 16,
);
const kOptionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

const kHeaderText = TextStyle(
  color: Color(0xFF240b36),
  fontWeight: FontWeight.bold,
  fontSize: 25,
);
const kPurpleGredient = [
  Color(0xFF240b36),
  Color(0xFFc31432),
];
const kGreenGredient = [
  Color(0xFF240b36),
  Color(0xFF00F260),
];

const kDarkRed = Color.fromARGB(255, 140, 1, 1);
const kLightRed = Color.fromARGB(255, 255, 222, 222);
// ==========================( Custom Material Button)=================//

class CustomButton extends StatelessWidget {
  final Color color;
  final List<Color> gradientColor;
  final String textButton;
  final void Function() onTapFunc;
  final double padding;

  const CustomButton({
    Key? key,
    this.color = Colors.transparent,
    required this.textButton,
    required this.onTapFunc,
    this.gradientColor = kPurpleGredient,
    this.padding = 12,
  }) : super(key: key);

  // const CustomButton(
  //     {required this.color,
  //     required this.textButton,
  //     required this.onTapFunc,
  //     required this.gradientColor
  //     this.padding;
  //     });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: gradientColor),
        ),
        child: Material(
          color: color,
          shadowColor: Colors.black,
          elevation: 15,
          borderRadius: BorderRadius.circular(30),
          child: MaterialButton(
            onPressed: onTapFunc,
            minWidth: padding,
            height: 50.0,
            child: Text(
              textButton,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            textColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

// ==========================(.customElevatedButton )=================//

class CustomElevatedButton extends StatefulWidget {
  // const CustomElevatedButton({ Key? key }) : super(key: key);
  final Color color;
  final String textButton;
  final void Function() onTapFunc;

  const CustomElevatedButton({
    required this.color,
    required this.textButton,
    required this.onTapFunc,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: kPurpleGredient,
          ),
        ),
        child: ElevatedButton(
          onPressed: widget.onTapFunc,
          style: ButtonStyle(
            // shape: MaterialStateProperty.resolveWith(
            //     (states) => CircleBorder(side: BorderRadius. ) ),
            padding: MaterialStateProperty.resolveWith((states) =>
                EdgeInsets.only(left: 60, right: 60, top: 15, bottom: 15)),
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Colors.transparent),
            elevation: MaterialStateProperty.resolveWith((states) => 15),
          ),
          child: Text(
            widget.textButton,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

//
// ==========================(  custom Text Field )=================//

// class InputField extends StatelessWidget {
//   final Widget icon;
//   final String placeHolder;
//   final void Function() onEditingComplete;
//   final void Function(String)? onChangeCallBack;

//   InputField({
//     required this.icon,
//     required this.placeHolder,
//     required this.onEditingComplete,
//     required this.onChangeCallBack,
//   });
//   // // final String? Function(String?)? validator;
//   // InputField({required this.placeHolder});
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       // padding: const EdgeInsets.only(left: 24, right: 24),
//       padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
//       child: Material(
//         color: Colors.white,
//         shadowColor: Colors.white,
//         elevation: 15,
//         borderRadius: BorderRadius.circular(20),
//         child: Padding(
//           padding: const EdgeInsets.only(left: 10, right: 24),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: icon,
//               ),
//               Expanded(
//                 flex: 5,
//                 child: TextField(
//                   onSubmitted: onChangeCallBack,
//                   // onChanged: onChangeCallBack,
//                   onEditingComplete: onEditingComplete,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.all(5),
//                     labelText: placeHolder,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ==========================( custom Text Form Field )=================//

class CustomFormField extends StatelessWidget {
  final Widget icon;
  final String placeHolder;
  final String? Function(String?)? validator;
  // final Void Function(String)? validator;
  final void Function(String)? onFieldSubmitted;
  // final TextEditingController controllerText;
  // final String? controllerText;
  bool obscureText = false;

  CustomFormField({
    required this.icon,
    required this.placeHolder,
    required this.validator,
    required this.obscureText,
    required this.onFieldSubmitted,
    // required this.controllerText,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Material(
        color: Colors.white,
        shadowColor: Colors.white,
        elevation: 15,
        borderRadius: BorderRadius.circular(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: icon,
            ),
            Expanded(
              flex: 5,
              child: TextFormField(
                // controller: TextEditingController(text: controllerText, te ) ,

                obscureText: obscureText,

                style: TextStyle(
                  // backgroundColor: Colors.greenAccent,
                  height: 1,
                ),
                validator: validator,
                // onFieldSubmitted: onFieldSubmitted,s
                onChanged: onFieldSubmitted,
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
    );
  }
}

// ==========================( Validation Text )=================//

class ValidationText extends StatelessWidget {
  const ValidationText({
    Key? key,
    required this.validationText,
  }) : super(key: key);

  final String validationText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 80.0),
          child: Text(
            validationText,
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
// ===================================

const kSendButtonTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kDarkRed, width: 2.0),
  ),
);

const kButtonField = InputDecoration(
  hintText: 'Enter your email',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDarkRed, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDarkRed, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
// ====================================

class MessageBuble extends StatelessWidget {
  const MessageBuble({
    Key? key,
    this.text = '',
    this.sender = '',
    this.isMe = true,
  }) : super(key: key);

  // MessageBuble({
  //   this.text,
  //   this.sender,
  //   this.isMe,
  // });

  final String text;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          sender,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 12,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Material(
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(15) : Radius.circular(0),
              topRight: isMe ? Radius.circular(0) : Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            elevation: 5,
            color: isMe ? kDarkRed : Colors.grey.shade500,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ===================
// / ======================
class FormTextFieldConst extends StatelessWidget {
  final String placeHolder;
  final String? Function(String?)? validator;
  final void Function(String)? onChangedField;

  // final void Function(PhoneAuthCredential)? onPhoneSubmit;
  final String? initialValue;
  final String identifier;

  FormTextFieldConst({
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
          flex: 2,
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
          flex: 7,
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
                      initialValue: initialValue,
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
