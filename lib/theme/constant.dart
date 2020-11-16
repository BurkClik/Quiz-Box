import 'package:flutter/material.dart';

//===================================
// Light Theme Constant
//===================================
const kPrimaryColor = Color(0xFFFFCA2C);
const kSecondaryColor = Color(0xFF3E4868);
const kThirdColor = Color(0xFFFF5400);

//===================================
// Category
//===================================
const kCategoryTextStyle = TextStyle(
  color: kPrimaryColor,
  fontSize: 16.0,
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w500,
);

const kCategoryBoxDeco = BoxDecoration(
  color: kSecondaryColor,
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  boxShadow: [
    BoxShadow(
      color: Color(0x40000000),
      blurRadius: 4.0,
      offset: Offset(0, 4),
    ),
  ],
);

//===================================
// Question
//===================================
const kQuestionInfoText = TextStyle(
  color: kSecondaryColor,
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w600,
  fontSize: 20.0,
);

const kQuestionTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w500,
);

const kQuestionTimeText = TextStyle(
  color: kSecondaryColor,
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w600,
  fontSize: 32.0,
);

const kAnswerBoxStyle = BoxDecoration(
  color: kSecondaryColor,
  borderRadius: BorderRadius.all(Radius.circular(50.0)),
  boxShadow: [
    BoxShadow(
      color: Color(0x40000000),
      blurRadius: 4.0,
      offset: Offset(0, 4),
    ),
  ],
);

//=================================
// Wrong Screen
//=================================
const kOpsTextStyle = TextStyle(
  color: kSecondaryColor,
  fontSize: 48.0,
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w700,
);

const kResultInfoText = TextStyle(
  color: kSecondaryColor,
  fontSize: 20.0,
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w500,
);

const kScoreInfoTextStyle = TextStyle(
  color: kThirdColor,
  fontSize: 20,
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w700,
);

const kScoreTextStyle = TextStyle(
  color: kThirdColor,
  fontSize: 48,
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w700,
);

//===================================
// Buttons
//===================================
const kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w500,
);

const kButtonBoxDeco = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(50.0)),
  boxShadow: [
    BoxShadow(
      color: Color(0x40000000),
      blurRadius: 4.0,
      offset: Offset(0, 4),
    ),
  ],
);

//======================================
// AlertDialog
//======================================
const kAlertButtonStyle = TextStyle(
  color: Colors.black,
  fontSize: 16.0,
  fontFamily: 'Kodchasan',
  fontWeight: FontWeight.w500,
);
