import 'package:flutter/cupertino.dart';

Color backgroundColour = const Color(0xff24E7AC);

const String baseUrl = "https://employee-manager-backend-ss.herokuapp.com/";

// Errors
const userInvalidResponse = 100;
const noInternet = 101;
const invalidFormat = 102;
const unknownError = 103;

Map<String, String> headersMap = {
  'Content-Type': 'application/json; charset=UTF-8',
  // 'Authorization': ,
};
