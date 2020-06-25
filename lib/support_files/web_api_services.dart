import 'package:fooddelivery/models/app_init_model.dart';
import 'package:fooddelivery/models/enum_collections.dart';
import 'package:fooddelivery/models/history_order_model.dart';
import 'package:fooddelivery/models/network_response.dart';
import 'package:fooddelivery/models/order_model.dart';
import 'package:fooddelivery/support_files/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class WebApiServices {
  static final shared = WebApiServices();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> getUserLoggedInStatus() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(kUserLoggedInKey) ?? false;
  }

  void setUserLoggedInStatus(bool newValue) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(kUserLoggedInKey, newValue);
  }

  Future<int> getUserId() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(kUserIdKey) ?? 0;
  }

  void setUserId({int userId}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(kUserIdKey, userId);
  }

  Future<List<String>> getUserDetails() async {
    final SharedPreferences prefs = await _prefs;
    //The order should be name, mobile no, hotelId, hotelName, hotelIcon,hotelAddress
    List<String> defaultResult = ['', '', '0', '', '', ''];
    return prefs.getStringList(kUserDetailsKey) ?? defaultResult;
  }

  void setUserDetails({List<String> userDetails}) async {
    final SharedPreferences prefs = await _prefs;
    //The order should be name, mobile no, hotel Id, hotelName, hotelIcon, hotelAddress
    prefs.setStringList(kUserDetailsKey, userDetails);
  }

  void showToastMessage(
      {String message, ToastGravity place, Toast duration, Color bgColor}) {
    Fluttertoast.showToast(
        msg: message,
        gravity: place,
        toastLength: duration,
        backgroundColor: bgColor);
  }

  Future showInOutDailog({
    @required BuildContext context,
    @required Widget yourWidget,
    Widget icon,
    Widget title,
    @required Widget firstButton,
    Widget secondButton,
  }) {
    assert(context != null, "context is null!!");
    assert(yourWidget != null, "yourWidget is null!!");
    assert(firstButton != null, "button is null!!");
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.7),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.fastOutSlowIn.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                title: title,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    icon,
                    Container(
                      height: 10,
                    ),
                    yourWidget,
                    Container(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[firstButton],
                    )
                  ],
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  Future showInOutDailogWithTwoButtons({
    @required BuildContext context,
    @required Widget yourWidget,
    Widget icon,
    Widget title,
    @required Widget firstButton,
    @required Widget secondButton,
  }) {
    assert(context != null, "context is null!!");
    assert(yourWidget != null, "yourWidget is null!!");
    assert(firstButton != null, "button is null!!");
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.7),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.fastOutSlowIn.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                title: title,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    icon,
                    Container(
                      height: 10,
                    ),
                    yourWidget,
                    Container(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        firstButton,
                        SizedBox(
                          width: 20.0,
                        ),
                        secondButton
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  void showAlert(
      {BuildContext context,
      String title,
      Function onPressed,
      String message}) async {
    await showInOutDailog(
        context: context,
        yourWidget: Container(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              message,
              style: kBodyLabelTextStyle.copyWith(
                  color: Colors.black87, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        firstButton: MaterialButton(
          // FIRST BUTTON IS REQUIRED
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: Colors.green,
          child: Text(
            'Ok',
            style: kBodyLabelTextStyle.copyWith(
                color: Colors.black, fontSize: 18.0),
          ),
          onPressed: onPressed,
        ),
        icon: Icon(
          Icons.info_outline,
          color: Colors.red,
          size: 0.0,
        ),
        title: Center(
            child: Text(
          title,
          style:
              kBodyLabelTextStyle.copyWith(color: Colors.black, fontSize: 18.0),
        )));
  }

  void showAlertWithTwoOptions(
      {BuildContext context,
      String title,
      Function onFirstButtonPressed,
      Function onSecondButtonPressed,
      String message,
      String firstBtnTitle,
      String secondBtnTitle}) async {
    await showInOutDailogWithTwoButtons(
        context: context,
        yourWidget: Container(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              message,
              style: kBodyLabelTextStyle.copyWith(
                  color: Colors.black87, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        firstButton: MaterialButton(
          // FIRST BUTTON IS REQUIRED
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: Colors.orange,
          child: Text(
            firstBtnTitle,
            style: kBodyLabelTextStyle.copyWith(
                color: Colors.black, fontSize: 18.0),
          ),
          onPressed: onFirstButtonPressed,
        ),
        secondButton: MaterialButton(
          // FIRST BUTTON IS REQUIRED
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: Colors.green,
          child: Text(
            secondBtnTitle,
            style: kBodyLabelTextStyle.copyWith(
                color: Colors.black, fontSize: 18.0),
          ),
          onPressed: onSecondButtonPressed,
        ),
        icon: Icon(
          Icons.info_outline,
          color: Colors.red,
          size: 0.0,
        ),
        title: Center(
            child: Text(
          title,
          style:
              kBodyLabelTextStyle.copyWith(color: Colors.black, fontSize: 18.0),
        )));
  }

  String changeDateFormat(String serverDate) {
    String reqDate = serverDate
        .replaceAll(RegExp('-'), '')
        .replaceAll(RegExp(':'), '')
        .replaceAll(RegExp('T'), '');
    String date = reqDate.split('.')[0];
    String dateWithT = date.substring(0, 8) + 'T' + date.substring(8);
    DateTime dateTime = DateTime.parse(dateWithT);
    String req =
        formatDate(dateTime, [MM, dd, ', ', yyyy, ', ', hh, ':', nn, am]);
    return req;
  }

  /* This is to get app init details. So that we can decide the screen to land initially */
  Future<NetworkResponse> getAppInitDetails() async {
    NetworkResponse responseValue;
    try {
      http.Response response =
          await http.post(kUrlToGetAppInitDetails, headers: kHeader);
      String data = response.body;
      var jsonData = jsonDecode(data);
      if (response.statusCode == 200) {
        int responseCode = jsonData['Code'];
        String responseMessage = jsonData['Message'];

        if (responseCode == 1) {
          AppUpdateType updateType;
          var data = jsonData['Data'];
          int status = data['status'];
          switch (status) {
            case 0:
              {
                updateType = AppUpdateType.noUpdate;
              }
              break;
            case 1:
              {
                updateType = AppUpdateType.optionalUpdate;
              }
              break;
            case 2:
              {
                updateType = AppUpdateType.mustUpdate;
              }
              break;
            default:
              break;
          }
          bool isUserLoggedIn = await getUserLoggedInStatus();

          InitialScreen initScreen;

          if (updateType != AppUpdateType.noUpdate) {
            String latestVersion = data['version'];
            if (kCurrentAppVersion == latestVersion) {
              initScreen = isUserLoggedIn
                  ? InitialScreen.homeScreen
                  : InitialScreen.loginScreen;
            } else {
              initScreen = InitialScreen.appInitScreen;
            }
          } else {
            initScreen = isUserLoggedIn
                ? InitialScreen.homeScreen
                : InitialScreen.loginScreen;
          }
          String instruction = data['message'];

          AppInitModel appInitModel = AppInitModel(
              initScreen: initScreen,
              updateFlag: updateType,
              instruction: instruction);

          responseValue = NetworkResponse(
              responseCode: responseCode,
              responseMessage: responseMessage,
              responseData: appInitModel);
        } else {
          responseValue = NetworkResponse(
              responseCode: 0,
              responseMessage: 'Something went wrong. Please try again later',
              responseData: null);
        }
      } else {
        String message = jsonData['Message'];
        responseValue = NetworkResponse(
            responseCode: 0, responseMessage: message, responseData: null);
      }
    } catch (e) {
      String err = e.toString();
      responseValue = NetworkResponse(
          responseCode: 0, responseMessage: err, responseData: null);
    }
    return responseValue;
  }

  /* To login the user*/
  Future<NetworkResponse> login({String mobileNo, String password}) async {
    NetworkResponse responseValue;
    try {
      var params = new Map<String, dynamic>();
      params['phone_no'] = mobileNo;
      params['password'] = password;
      var body = json.encode(params);

      http.Response response =
          await http.post(kUrlToLogin, headers: kHeader, body: body);
      String data = response.body;
      var jsonData = jsonDecode(data);
      if (response.statusCode == 200) {
        int responseCode = jsonData['Code'];
        String responseMessage = jsonData['Message'];
        if (responseCode == 1) {
          var responseData = jsonData['Data'];
          int userId = responseData['supplier_id'];
          String name = responseData['supplier_name'];
          int hotelId = responseData['hotel_id'];
          String hotelName = responseData['hotel_name'];
          String hotelIcon = responseData['hotel_icon'];
          String hotelAddress = responseData['hotel_address'];
          //The order should be name, mobile no, hotelId, hotelName, hotelIcon,hotelAddress
          List<String> userDetails = [
            name,
            mobileNo,
            '$hotelId',
            hotelName,
            hotelIcon,
            hotelAddress
          ];
          setUserDetails(userDetails: userDetails);
          setUserId(userId: userId);
          setUserLoggedInStatus(true);
        }
        responseValue = NetworkResponse(
            responseCode: responseCode,
            responseMessage: responseMessage,
            responseData: null);
      } else {
        // The response code is not 200.
        String message = jsonData['Message'];
        responseValue = NetworkResponse(
            responseCode: 0, responseMessage: message, responseData: null);
      }
    } catch (e) {
      // The webservice throws an error.
      String err = e.toString();
      responseValue = NetworkResponse(
          responseCode: 0, responseMessage: err, responseData: null);
    }
    return responseValue;
  }

  /*To check any order to delivery*/
  Future<NetworkResponse> checkForOrderToDelivery() async {
    NetworkResponse responseValue;
    try {
      int supplierId = await getUserId();
      var params = new Map<String, dynamic>();
      params['supplier_id'] = supplierId;
      var body = json.encode(params);

      http.Response response = await http.post(kUrlToCheckOrderToService,
          headers: kHeader, body: body);
      String data = response.body;
      var jsonData = jsonDecode(data);
      if (response.statusCode == 200) {
        int responseCode = jsonData['Code'];
        String responseMessage = jsonData['Message'];
        if (responseCode == 1) {
          var ordersData = jsonData['Data'];
          List<OrderModel> orders = [];
          //The order should be name, mobile no, hotelId, hotelName, hotelIcon,hotelAddress
          List<String> userDetails = await getUserDetails();
          String hotelAddress = userDetails[3] + ', ' + userDetails[5];
          for (var order in ordersData) {
            int orderId = order['order_id'];
            String mobileNo = order['customer_phone_no'].toString();
            String customerName = order['customer_name'];
            String deliveryAddress = order['delivery_address'];
            double deliveryAddressLatitude = order['delivery_lat'];
            double deliveryAddressLongitude = order['delivery_lon'];
            double totalPrice = order['total_amount'];
            int payStatusId = order['paid_status'];
            PaymentStatus paymentStatus =
                payStatusId == 0 ? PaymentStatus.unpaid : PaymentStatus.paid;
            int orderStatusId = order['order_status_id'];
            OrderStatus orderStatus;
            switch (orderStatusId) {
              case 1:
                orderStatus = OrderStatus.dishPrepared;
                break;
              case 2:
                orderStatus = OrderStatus.dishPrepared;
                break;
              case 3:
                orderStatus = OrderStatus.dishPrepared;
                break;
              case 4:
                orderStatus = OrderStatus.pickedAtHotel;
                break;
              case 5:
                orderStatus = OrderStatus.delivered;
                break;
              case 6:
                orderStatus = OrderStatus.completed;
                break;
              case 7:
                orderStatus = OrderStatus.cancelled;
                break;
              default:
                orderStatus = OrderStatus.dishPrepared;
                break;
            }

            OrderModel orderModel = OrderModel(
                orderId: orderId,
                deliveryName: customerName,
                mobileNo: mobileNo,
                totalPrice: totalPrice,
                paidStatus: paymentStatus,
                hotelAddress: hotelAddress,
                deliveryAddress: deliveryAddress,
                deliveryAddressLatitude: deliveryAddressLatitude,
                deliveryAddressLongitude: deliveryAddressLongitude,
                orderStatus: orderStatus);
            orders.add(orderModel);
          }
          responseValue = NetworkResponse(
              responseCode: responseCode,
              responseMessage: responseMessage,
              responseData: orders);
        } else {
          responseValue = NetworkResponse(
              responseCode: responseCode,
              responseMessage: responseMessage,
              responseData: null);
        }
      } else {
        // The response code is not 200.
        String message = jsonData['Message'];
        responseValue = NetworkResponse(
            responseCode: 0, responseMessage: message, responseData: null);
      }
    } catch (e) {
      // The webservice throws an error.
      String err = e.toString();
      responseValue = NetworkResponse(
          responseCode: 0, responseMessage: err, responseData: null);
    }
    return responseValue;
  }

  /*To update the status of the current order*/
  Future<NetworkResponse> updateOrderStatus(
      {int orderId, int orderStatus}) async {
    NetworkResponse responseValue;
    try {
      int supplierId = await getUserId();
      var params = new Map<String, dynamic>();
      params['supplier_id'] = supplierId;
      params['order_id'] = orderId;
      params['order_status'] = orderStatus;
      var body = json.encode(params);

      http.Response response = await http.post(kUrlToUpdateOrderStatus,
          headers: kHeader, body: body);
      String data = response.body;
      var jsonData = jsonDecode(data);
      if (response.statusCode == 200) {
        int responseCode = jsonData['Code'];
        String responseMessage = jsonData['Message'];
        responseValue = NetworkResponse(
            responseCode: responseCode,
            responseMessage: responseMessage,
            responseData: null);
      } else {
        // The response code is not 200.
        String message = jsonData['Message'];
        responseValue = NetworkResponse(
            responseCode: 0, responseMessage: message, responseData: null);
      }
    } catch (e) {
      // The webservice throws an error.
      String err = e.toString();
      responseValue = NetworkResponse(
          responseCode: 0, responseMessage: err, responseData: null);
    }
    return responseValue;
  }

  /*To check any order to delivery*/
  Future<NetworkResponse> getCompletedOrdersHistory() async {
    NetworkResponse responseValue;
    try {
      int supplierId = await getUserId();
      var params = new Map<String, dynamic>();
      params['supplier_id'] = supplierId;
      var body = json.encode(params);

      http.Response response =
          await http.post(kUrlToGetOrdersHistory, headers: kHeader, body: body);
      String data = response.body;
      var jsonData = jsonDecode(data);
      if (response.statusCode == 200) {
        int responseCode = jsonData['Code'];
        String responseMessage = jsonData['Message'];
        if (responseCode == 1) {
          var ordersData = jsonData['Data'];
          List<HistoryOrderModel> orders = [];
          //The order should be name, mobile no, hotelId, hotelName, hotelIcon,hotelAddress
          List<String> userDetails = await getUserDetails();
          String hotelAddress = userDetails[3] + ', ' + userDetails[5];
          for (var order in ordersData) {
            int orderId = order['order_id'];
            String deliveryAddress = order['delivery_address'];

            HistoryOrderModel orderModel = HistoryOrderModel(
                orderId: orderId,
                orderDate: 'May25, 2020, 05:30PM',
                hotelAddress: hotelAddress,
                deliveryAddress: deliveryAddress,
                orderRatings: 4.2);
            orders.add(orderModel);
          }
          responseValue = NetworkResponse(
              responseCode: responseCode,
              responseMessage: responseMessage,
              responseData: orders);
        } else {
          responseValue = NetworkResponse(
              responseCode: responseCode,
              responseMessage: responseMessage,
              responseData: null);
        }
      } else {
        // The response code is not 200.
        String message = jsonData['Message'];
        responseValue = NetworkResponse(
            responseCode: 0, responseMessage: message, responseData: null);
      }
    } catch (e) {
      // The webservice throws an error.
      String err = e.toString();
      responseValue = NetworkResponse(
          responseCode: 0, responseMessage: err, responseData: null);
    }
    return responseValue;
  }
}
