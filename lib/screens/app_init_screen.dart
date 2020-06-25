import 'package:flutter/material.dart';
import 'package:fooddelivery/models/enum_collections.dart';
import 'package:fooddelivery/screens/home_screen.dart';
import 'package:fooddelivery/support_files/constants.dart';
import 'package:fooddelivery/support_files/web_api_services.dart';

class AppInitScreen extends StatefulWidget {
  static const String id = 'app_init_screen';

  final String instruction;
  final AppUpdateType updateType;

  AppInitScreen({@required this.instruction, @required this.updateType});
  @override
  _AppInitScreenState createState() => _AppInitScreenState();
}

class _AppInitScreenState extends State<AppInitScreen> {
  bool isSpinnerToShow = false;
  bool isUpdateBtnShouldVisible;
  bool isRefreshBtnShouldVisible;
  bool isLaterBtnShouldVisible;

  @override
  void initState() {
    if (widget.updateType == AppUpdateType.noUpdate) {
      setState(() {
        isUpdateBtnShouldVisible = false;
        isLaterBtnShouldVisible = false;
        isRefreshBtnShouldVisible = true;
      });
    } else if (widget.updateType == AppUpdateType.optionalUpdate) {
      setState(() {
        isUpdateBtnShouldVisible = true;
        isLaterBtnShouldVisible = true;
        isRefreshBtnShouldVisible = false;
      });
    } else if (widget.updateType == AppUpdateType.mustUpdate) {
      setState(() {
        isUpdateBtnShouldVisible = true;
        isLaterBtnShouldVisible = false;
        isRefreshBtnShouldVisible = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Container(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 70.0,
                  ),
                  Container(
                    child: Icon(
                      Icons.fastfood,
                      size: 100.0,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.instruction,
                            textAlign: TextAlign.center,
                            style: kBodyLabelTextStyle.copyWith(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Container(
                            height: 50.0,
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: <Widget>[
                                Visibility(
                                  visible: isUpdateBtnShouldVisible,
                                  child: Expanded(
                                    child: Center(
                                      child: GestureDetector(
                                        child: Text(
                                          'Update',
                                          style: kHeaderLabelTextStyle.copyWith(
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                        onTap: () {},
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isRefreshBtnShouldVisible,
                                  child: Expanded(
                                    child: Center(
                                      child: GestureDetector(
                                        child: Icon(
                                          Icons.refresh,
                                          size: 50.0,
                                        ),
                                        onTap: () {
                                          Navigator.pop(context, 1);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isLaterBtnShouldVisible,
                                  child: Expanded(
                                    child: Center(
                                      child: GestureDetector(
                                        child: Text(
                                          'Later',
                                          style: kHeaderLabelTextStyle.copyWith(
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                        onTap: () async {
                                          bool isUserLoggedIn =
                                              await WebApiServices.shared
                                                  .getUserLoggedInStatus();
                                          if (isUserLoggedIn) {
                                            Navigator.pushNamed(
                                                context, HomeScreen.id);
                                          } else {
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
              child: Container(
            child: isSpinnerToShow ? kSpinner : Stack(),
          ))
        ],
      )),
    );
  }
}
