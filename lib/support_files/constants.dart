import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//MARK:- Session Stored Keys
const kUserLoggedInKey = 'userLoggedinKey';
const kUserIdKey = 'userIdKey';
const kUserDetailsKey = 'userDetailsKey';

//MARK:- Map key Constants
const kResponseCodeKey = 'ResponseCode';
const kResponseMessageKey = 'ResponseMessage';
const kResponseData = 'ResponseData';

//MARK:- Current App Version
const kCurrentAppVersion = '1.0';

//MARK:- Headers
const kHeader = {"Content-Type": "application/json"};

//MARK:- Url Constants
const kBaseUrl = 'http://64.15.141.244:80/Hotel/Rest/api/Supplier/';
const kUrlToGetAppInitDetails = kBaseUrl + 'Init';
const kUrlToLogin = kBaseUrl + 'Login';
const kUrlToCheckOrderToService = kBaseUrl + 'CheckAnyOrder';
const kUrlToUpdateOrderStatus = kBaseUrl + 'UpdateOrderStatus';
const kUrlToGetOrdersHistory = kBaseUrl + 'CompletedOrders';

// MARK:- Style Constants
const kHeaderLabelTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 18.0,
  decoration: TextDecoration.none,
  fontFamily: 'AmaranthRegular',
  fontWeight: FontWeight.w500,
);

const kBodyLabelTextStyle = TextStyle(
  color: Colors.black54,
  fontSize: 16.0,
  decoration: TextDecoration.none,
  fontFamily: 'AmaranthRegular',
  fontWeight: FontWeight.w500,
);

const kBoldLabelTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 18.0,
  decoration: TextDecoration.none,
  fontFamily: 'AmaranthBold',
  fontWeight: FontWeight.w500,
);

const kSpinner = SpinKitWave(
  color: Colors.red,
  size: 40.0,
);
