import 'package:flutter/material.dart';
import 'package:fooddelivery/support_files/constants.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String message;
  final Function onRefreshTapped;
  ErrorMessageWidget({this.message, this.onRefreshTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            message,
            style: kHeaderLabelTextStyle,
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            child: Icon(
              Icons.refresh,
              size: 30.0,
            ),
            onTap: onRefreshTapped,
          )
        ],
      ),
    ));
  }
}
