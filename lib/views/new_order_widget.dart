import 'package:flutter/material.dart';
import 'package:fooddelivery/models/enum_collections.dart';
import 'package:fooddelivery/models/order_model.dart';
import 'package:fooddelivery/support_files/constants.dart';
import 'package:flutter_dash/flutter_dash.dart';

class NewOrderWidget extends StatelessWidget {
  final OrderModel order;
  final Function onStatusBtnPressed;
  final Function onCallBtnPressed;
  final Function onMapBtnPressed;

  NewOrderWidget(
      {this.order,
      this.onStatusBtnPressed,
      this.onCallBtnPressed,
      this.onMapBtnPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 202.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green.shade100),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10.0))),
                  height: 90.0,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '#${order.orderId}',
                                    style: kBodyLabelTextStyle.copyWith(
                                        color: Colors.black, fontSize: 20.0),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    order.deliveryName,
                                    style: kBodyLabelTextStyle.copyWith(
                                        color: Colors.black, fontSize: 18.0),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    order.mobileNo,
                                    style: kBodyLabelTextStyle.copyWith(
                                        color: Colors.black, fontSize: 18.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            width: 100.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '\$${order.totalPrice.toStringAsFixed(2)}',
                                      style: kBodyLabelTextStyle.copyWith(
                                          color: Colors.orange, fontSize: 25.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      order.paidStatus == PaymentStatus.paid
                                          ? 'PAID'
                                          : 'UNPAID',
                                      style: kHeaderLabelTextStyle.copyWith(
                                          fontSize: 18.0),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 54.0,
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 9.0,
                          ),
                          Container(
                            height: 6.0,
                            width: 6.0,
                            color: Colors.green,
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Container(
                            height: 20.0,
                            width: 10.0,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 4.0,
                                ),
                                Dash(
                                  direction: Axis.vertical,
                                  dashColor: Colors.black,
                                  length: 20.0,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Container(
                            height: 6.0,
                            width: 6.0,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(children: <Widget>[
                          Flexible(
                            child: Container(
                              height: 24.0,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  order.hotelAddress,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: kBodyLabelTextStyle.copyWith(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Flexible(
                            child: Container(
                              height: 24.0,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  order.deliveryAddress,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: kBodyLabelTextStyle.copyWith(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  height: 11.0,
                  child: Center(
                    child: Container(
                      height: 1.0,
                      color: Colors.green.shade100,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Container(
                      height: 40.0,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              child: FlatButton(
                                onPressed: onStatusBtnPressed,
                                child: Text(
                                  'Status',
                                  style: kHeaderLabelTextStyle,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              child: FlatButton(
                                onPressed: onCallBtnPressed,
                                child: Text(
                                  'Call',
                                  style: kHeaderLabelTextStyle,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              child: FlatButton(
                                onPressed: onMapBtnPressed,
                                child: Text(
                                  'Map',
                                  style: kHeaderLabelTextStyle,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                )
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}
