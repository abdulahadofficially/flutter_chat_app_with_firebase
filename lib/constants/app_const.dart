import 'package:flutter/material.dart';

class AppConst {
  static const kBackgroundColor = Color(0xff191720);
  static const kTextFieldFill = Color(0xff1E1C24);
// TextStyles
  static const kHeadline = TextStyle(
    color: Colors.white,
    fontSize: 34,
    fontWeight: FontWeight.bold,
  );

  static const kBodyText = TextStyle(
    color: Colors.grey,
    fontSize: 15,
  );

  static const kButtonText = TextStyle(
    color: Colors.black87,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const kBodyText2 =
      TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Colors.white);

 static final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );
 static final RegExp passwordRegExp = RegExp(
    r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$",
  );
 static final RegExp usernameRegExp = RegExp(
    r"^[a-zA-Z0-9_]{3,16}$",
  );
 static final RegExp phoneRegExp = RegExp(
    r"^\+?[1-9]\d{1,14}$",
  );
}
