import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fooddelivery/support_files/constants.dart';

class ProfileScreenWidget extends StatelessWidget {
  final String name;
  final String mobileNo;
  final bool isNewVersionAvailable;
  final Function onUpdateVersionPressed;
  final Function onLogOutBtnPressed;
  final Function onEditBtnPressed;

  ProfileScreenWidget(
      {this.name,
      this.mobileNo,
      this.isNewVersionAvailable,
      this.onUpdateVersionPressed,
      this.onLogOutBtnPressed,
      this.onEditBtnPressed});

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
                'Profile',
                style: kHeaderLabelTextStyle.copyWith(fontSize: 20.0),
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 5.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 125.0,
                              child: Center(
                                child: Icon(
                                  Icons.account_circle,
                                  size: 125.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              height: 1.0,
                              color: Colors.green.shade100,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              height: 80.0,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            name,
                                            style: kHeaderLabelTextStyle,
                                          ),
                                        )),
                                        GestureDetector(
                                            onTap: onEditBtnPressed,
                                            child: Container(
                                              height: 26.0,
                                              width: 26.0,
                                              decoration: BoxDecoration(
                                                  color: Colors.green.shade50,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(13.0),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          Colors.green.shade50,
                                                      blurRadius:
                                                          3.0, // has the effect of softening the shadow
                                                      spreadRadius:
                                                          3.0, // has the effect of extending the shadow
                                                      offset: Offset(0.0,
                                                          3.0), // (horizontal , vertical)
                                                    )
                                                  ]),
                                              child: Center(
                                                child: Icon(
                                                  Icons.edit,
                                                  size: 20.0,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      mobileNo,
                                      style: kBodyLabelTextStyle,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    height: 1.0,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isNewVersionAvailable,
                      child: Container(
                        height: 50.0,
                        color: Colors.green.shade50,
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            child: FlatButton(
                                onPressed: onUpdateVersionPressed,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'New app version available',
                                          style: kBodyLabelTextStyle,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'UPDATE',
                                      style: kHeaderLabelTextStyle.copyWith(
                                          color: Colors.orange),
                                    )
                                  ],
                                ))),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 50.0,
                      color: Colors.green.shade50,
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: FlatButton(
                              onPressed: onLogOutBtnPressed,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Log Out',
                                        style: kHeaderLabelTextStyle,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    FontAwesomeIcons.signOutAlt,
                                    color: Colors.black54,
                                  )
                                ],
                              ))),
                    ),
                    SizedBox(
                      height: 5.0,
                    )
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
