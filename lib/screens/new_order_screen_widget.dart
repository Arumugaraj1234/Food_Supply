import 'package:flutter/material.dart';
import 'package:fooddelivery/support_files/constants.dart';

class NewOrderScreenWidget extends StatelessWidget {
  final Widget bodyWidget;

  NewOrderScreenWidget({@required this.bodyWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            color: Colors.green,
            child: Center(
              child: Text(
                'Orders',
                style: kHeaderLabelTextStyle.copyWith(fontSize: 20.0),
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: bodyWidget,
            ),
          ))
        ],
      ),
    );
  }
}
