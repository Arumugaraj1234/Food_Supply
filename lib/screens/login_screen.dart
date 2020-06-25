import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fooddelivery/models/app_init_model.dart';
import 'package:fooddelivery/models/enum_collections.dart';
import 'package:fooddelivery/models/network_response.dart';
import 'package:fooddelivery/screens/home_screen.dart';
import 'package:fooddelivery/support_files/constants.dart';
import 'package:fooddelivery/support_files/web_api_services.dart';
import 'package:fooddelivery/screens/app_init_screen.dart';
import 'package:fooddelivery/views/under_lined_text_Field.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget _bodyWidget = Container(
    child: Center(
      child: Center(
        child: Icon(
          Icons.fastfood,
          color: Colors.black,
          size: 100.0,
        ),
      ),
    ),
  );
  bool _isSpinnerToShow = false;
  void updateSpinnerStatus(bool status) {
    setState(() {
      _isSpinnerToShow = status;
    });
  }

  TextEditingController mobileNoTfController = TextEditingController();
  TextEditingController passwordTfController = TextEditingController();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    mobileNoTfController.dispose();
    passwordTfController.dispose();
    super.dispose();
  }

  void setLoginScreenAsBodyWidget() {
    Widget tempWidget;

    tempWidget = Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 70.0,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.fastfood,
                      size: 100.0,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 50.0,
                    child: UnderlinedTextField(
                      hintText: 'Mobile Number',
                      onChanged: (newValue) {},
                      editingController: mobileNoTfController,
                      keyBoardType: TextInputType.phone,
                      isSecureText: false,
                      inputAction: TextInputAction.next,
                      focusNode: mobileFocusNode,
                      onSubmitted: (value) {
                        FocusScope.of(context).requestFocus(passwordFocusNode);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 50.0,
                    child: UnderlinedTextField(
                      hintText: 'Password',
                      onChanged: (newValue) {},
                      editingController: passwordTfController,
                      keyBoardType: TextInputType.visiblePassword,
                      isSecureText: true,
                      inputAction: TextInputAction.done,
                      focusNode: passwordFocusNode,
                      onSubmitted: (newValue) {},
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    height: 50.0,
                    color: Colors.green,
                    child: FlatButton(
                      child: Center(
                        child: Text(
                          'Login',
                          style: kHeaderLabelTextStyle.copyWith(fontSize: 20.0),
                        ),
                      ),
                      onPressed: () async {
                        if (mobileNoTfController.text != '' &&
                            passwordTfController.text != '') {
                          updateSpinnerStatus(true);
                          NetworkResponse response = await WebApiServices.shared
                              .login(
                                  mobileNo: mobileNoTfController.text,
                                  password: passwordTfController.text);
                          updateSpinnerStatus(false);
                          if (response.responseCode == 1) {
                            Navigator.pushNamed(context, HomeScreen.id);
                          } else {
                            WebApiServices.shared.showToastMessage(
                                message: 'Oops! ${response.responseMessage}',
                                place: ToastGravity.BOTTOM,
                                duration: Toast.LENGTH_LONG,
                                bgColor: Colors.grey);
                          }
                        } else {
                          WebApiServices.shared.showToastMessage(
                              message: 'Please provide the valid details',
                              place: ToastGravity.BOTTOM,
                              duration: Toast.LENGTH_LONG,
                              bgColor: Colors.grey);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            'Ver: $kCurrentAppVersion',
            style: kBodyLabelTextStyle,
          )
        ],
      ),
    );

    setState(() {
      _bodyWidget = tempWidget;
    });
  }

  void getAppInitDetails() async {
    NetworkResponse response = await WebApiServices.shared.getAppInitDetails();
    if (response.responseCode == 1) {
      AppInitModel appInitModel = response.responseData;
      print(appInitModel.initScreen);
      if (appInitModel.initScreen == InitialScreen.appInitScreen) {
        setLoginScreenAsBodyWidget();
        var status = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return AppInitScreen(
              instruction: appInitModel.instruction,
              updateType: appInitModel.updateFlag,
            );
          }),
        );
        if (status != null) {
          getAppInitDetails();
        }
      } else if (appInitModel.initScreen == InitialScreen.homeScreen) {
        setLoginScreenAsBodyWidget();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      } else {
        setLoginScreenAsBodyWidget();
      }
    } else {
      setLoginScreenAsBodyWidget();
      var status = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return AppInitScreen(
            instruction: response.responseMessage,
            updateType: AppUpdateType.noUpdate,
          );
        }),
      );
      if (status != null) {
        getAppInitDetails();
      }
    }
  }

  @override
  void initState() {
    getAppInitDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _bodyWidget,
            Visibility(
              child: Container(
                color: Colors.black.withAlpha(0),
                child: Center(
                  child: _isSpinnerToShow ? kSpinner : Stack(),
                ),
              ),
              visible: _isSpinnerToShow,
            )
          ],
        ),
      ),
    );
  }
}
