import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fooddelivery/models/enum_collections.dart';
import 'package:fooddelivery/models/history_order_model.dart';
import 'package:fooddelivery/models/network_response.dart';
import 'package:fooddelivery/models/order_model.dart';
import 'package:fooddelivery/screens/completed_orders_screen_widget.dart';
import 'package:fooddelivery/screens/profile_screen_widget.dart';
import 'package:fooddelivery/support_files/constants.dart';
import 'package:fooddelivery/screens/new_order_screen_widget.dart';
import 'package:fooddelivery/support_files/web_api_services.dart';
import 'package:fooddelivery/views/error_message_widget.dart';
import 'package:fooddelivery/views/history_order_widget.dart';
import 'package:fooddelivery/views/new_order_widget.dart';
import 'package:fooddelivery/views/under_lined_text_Field.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _bodyWidget = Container();
  int _selectedIndex = 0;
  List<OrderModel> currentOrdersToDelivery = [];
  bool isModalSpinnerToShow = false;

  bool _isSpinnerToShow = false;
  void updateSpinnerStatus(bool status) {
    setState(() {
      _isSpinnerToShow = status;
    });
  }

  void updateModalSpinnerStatus(bool status) {
    setState(() {
      isModalSpinnerToShow = status;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                //onPressed: () => Navigator.of(context).pop(true),
                //onPressed: () => SystemNavigator.pop(),
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          setNewOrderScreenAsHomeScreen();
          break;
        case 1:
          setCompletedOrdersScreenAsHomeScreen();
          break;
        case 2:
          setProfileScreenAsHomeScreen();
          break;
        default:
          _bodyWidget = Container();
          break;
      }
    });
  }

  void setProfileScreenAsHomeScreen() async {
    List<String> userDetails = await WebApiServices.shared.getUserDetails();
    setState(() {
      _bodyWidget = ProfileScreenWidget(
          name: userDetails[0],
          mobileNo: userDetails[1],
          isNewVersionAvailable: true,
          onUpdateVersionPressed: () {},
          onLogOutBtnPressed: () {
            WebApiServices.shared.showAlertWithTwoOptions(
                context: context,
                title: 'Logout?',
                onFirstButtonPressed: () {
                  Navigator.pop(context);
                },
                onSecondButtonPressed: () {
                  WebApiServices.shared.setUserLoggedInStatus(false);
                  WebApiServices.shared.setUserId(userId: 0);
                  List<String> userDetails = ['', '', '0', '', '', ''];
                  WebApiServices.shared
                      .setUserDetails(userDetails: userDetails);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                message: 'Are you sure you want to log out?',
                firstBtnTitle: 'Cancel',
                secondBtnTitle: 'Logout');
          },
          onEditBtnPressed: () {
            showEditProfileBottomSheet(
                name: userDetails[0],
                mobileNo: userDetails[1],
                canDismiss: true,
                spinner: false);
          });
    });
  }

  FocusNode nameFocusNode = FocusNode();
  FocusNode mobileNoFocusNode = FocusNode();
  final nameTfController = TextEditingController();
  final mobileTfController = TextEditingController();

  void showEditProfileBottomSheet(
      {String name, String mobileNo, bool canDismiss, bool spinner}) {
    nameTfController.text = name;
    mobileTfController.text = mobileNo;

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: canDismiss,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Stack(
              children: <Widget>[
                Container(
                  height: 550.0,
                  color: Color(0xff757575),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          height: 204.0,
                          margin: EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 5.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                height: 30.0,
                                child: Center(
                                  child: Text(
                                    'EDIT ACCOUNT',
                                    textAlign: TextAlign.center,
                                    style: kHeaderLabelTextStyle.copyWith(
                                        color: Colors.black, fontSize: 20.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                height: 50.0,
                                child: UnderlinedTextField(
                                  hintText: 'Full Name',
                                  onChanged: (newValue) {},
                                  editingController: nameTfController,
                                  keyBoardType: TextInputType.text,
                                  isSecureText: false,
                                  inputAction: TextInputAction.next,
                                  focusNode: nameFocusNode,
                                  onSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(mobileNoFocusNode);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                height: 50.0,
                                child: UnderlinedTextField(
                                  hintText: 'Mobile number',
                                  onChanged: (newValue) {},
                                  editingController: mobileTfController,
                                  keyBoardType: TextInputType.phone,
                                  isSecureText: false,
                                  inputAction: TextInputAction.done,
                                  focusNode: mobileNoFocusNode,
                                  onSubmitted: (value) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50.0,
                          color: Colors.green,
                          child: FlatButton(
                              onPressed: () async {
                                String name = nameTfController.text;
                                String mobileNo = mobileTfController.text;
                                Navigator.pop(context);
                                showEditProfileBottomSheet(
                                    name: name,
                                    mobileNo: mobileNo,
                                    canDismiss: false,
                                    spinner: true);
                              },
                              child: Text(
                                'Update',
                                style: kHeaderLabelTextStyle.copyWith(
                                    color: Colors.black, fontSize: 18.0),
                              )),
                        ),
                        Expanded(
                          child: Container(),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  child: Container(
                    height: 550.0,
                    color: Colors.black.withAlpha(0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          child: kSpinner,
                        )),
                        Expanded(child: Container())
                      ],
                    ),
                  ),
                  visible: spinner,
                ),
              ],
            );
          });
        });
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  void setCompletedOrdersScreenAsHomeScreen() async {
    setState(() {
      _bodyWidget = CompletedOrdersScreenWidget(
        bodyWidget: Container(),
      );
    });
    updateSpinnerStatus(true);
    Widget tempWidget;
    NetworkResponse response =
        await WebApiServices.shared.getCompletedOrdersHistory();
    updateSpinnerStatus(false);
    if (response.responseCode == 1) {
      List<HistoryOrderModel> orders = response.responseData;

      if (orders.length == 0) {
        tempWidget = ErrorMessageWidget(
          message: 'No orders found at completed orders list',
          onRefreshTapped: () {
            setCompletedOrdersScreenAsHomeScreen();
          },
        );
      } else {
        tempWidget = createOrdersHistoryListView(orders);
      }
    } else {
      tempWidget = ErrorMessageWidget(
        message: response.responseMessage,
        onRefreshTapped: () {
          setCompletedOrdersScreenAsHomeScreen();
        },
      );
    }

    setState(() {
      _bodyWidget = CompletedOrdersScreenWidget(bodyWidget: tempWidget);
    });
  }

  Widget createOrdersHistoryListView(List<HistoryOrderModel> orders) {
    return ListView(
      children: List.generate(orders.length, (int index) {
        return HistoryOrderWidget(
          order: orders[index],
          onRemoveBtnPressed: () {},
        );
      }),
    );
  }

  void setNewOrderScreenAsHomeScreen() async {
    setState(() {
      _bodyWidget = NewOrderScreenWidget(
        bodyWidget: Container(),
      );
    });
    updateSpinnerStatus(true);
    Widget tempWidget;
    NetworkResponse response =
        await WebApiServices.shared.checkForOrderToDelivery();
    updateSpinnerStatus(false);
    if (response.responseCode == 1) {
      List<OrderModel> orders = response.responseData;
      currentOrdersToDelivery = orders;
      if (orders.length == 0) {
        tempWidget = ErrorMessageWidget(
          message: 'No new orders found to delivery',
          onRefreshTapped: () {
            setNewOrderScreenAsHomeScreen();
          },
        );
      } else {
        tempWidget = createCurrentOrdersLisView(orders);
      }
    } else {
      tempWidget = ErrorMessageWidget(
        message: response.responseMessage,
        onRefreshTapped: () {
          setNewOrderScreenAsHomeScreen();
        },
      );
    }
    setState(() {
      _bodyWidget = NewOrderScreenWidget(bodyWidget: tempWidget);
    });
  }

  Widget createCurrentOrdersLisView(List<OrderModel> orders) {
    return ListView(
      children: List.generate(orders.length, (int index) {
        return NewOrderWidget(
          order: orders[index],
          onCallBtnPressed: () {
            launch('tel://${orders[index].mobileNo}');
          },
          onStatusBtnPressed: () {
            showStatusBottomSheet(
                spinner: isModalSpinnerToShow,
                orderStatus: orders[index].orderStatus,
                indexOfOrder: index,
                orderId: orders[index].orderId);
          },
          onMapBtnPressed: () async {
            var geoLocator = Geolocator();
            var enableStatus = await geoLocator.isLocationServiceEnabled();
            if (enableStatus == false) {
              WebApiServices.shared.showAlert(
                  context: context,
                  title: '',
                  message:
                      'Location service not enabled. Please enable location',
                  onPressed: () {
                    Navigator.pop(context);
                  });
            } else {
              Position position = await Geolocator()
                  .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
              String origin =
                  "${position.latitude},${position.longitude}"; // lat,long like 123.34,68.56
              String destination =
                  "${orders[index].deliveryAddressLatitude},${orders[index].deliveryAddressLongitude}";
              String url = "https://www.google.com/maps/dir/?api=1&origin=" +
                  origin +
                  "&destination=" +
                  destination +
                  "&travelmode=driving&dir_action=navigate";
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            }
          },
        );
      }),
    );
  }

  void showStatusBottomSheet(
      {bool spinner, OrderStatus orderStatus, int indexOfOrder, int orderId}) {
    Future<void> future = showModalBottomSheet<void>(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Stack(
              children: <Widget>[
                Container(
                  color: Color(0xff757575),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Order #$orderId',
                              style: kHeaderLabelTextStyle,
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 40.0,
                                    width: 200.0,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
                                    child: FlatButton(
                                        onPressed: () {
                                          if (orderStatus ==
                                              OrderStatus.dishPrepared) {
                                            updateOrderStatus(
                                                orderId: orderId,
                                                orderStatus:
                                                    OrderStatus.pickedAtHotel,
                                                indexOfOrder: indexOfOrder,
                                                currentStatus: orderStatus);
                                          }
                                        },
                                        child: Center(
                                          child: Text(
                                            'Picked At Hotel',
                                            style:
                                                kHeaderLabelTextStyle.copyWith(
                                                    color: (orderStatus ==
                                                            OrderStatus
                                                                .dishPrepared)
                                                        ? Colors.black
                                                        : Colors.black54),
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        width: 1.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    height: 40.0,
                                    width: 200.0,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
                                    child: FlatButton(
                                        onPressed: () {
                                          if (orderStatus ==
                                              OrderStatus.pickedAtHotel) {
                                            updateOrderStatus(
                                                orderId: orderId,
                                                orderStatus:
                                                    OrderStatus.delivered,
                                                indexOfOrder: indexOfOrder,
                                                currentStatus: orderStatus);
                                          }
                                        },
                                        child: Center(
                                          child: Text(
                                            'Delivered',
                                            style:
                                                kHeaderLabelTextStyle.copyWith(
                                                    color: (orderStatus ==
                                                            OrderStatus
                                                                .pickedAtHotel)
                                                        ? Colors.black
                                                        : Colors.black54),
                                          ),
                                        )),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        width: 1.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 40.0,
                                    width: 200.0,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
                                    child: FlatButton(
                                        onPressed: () {
                                          if (orderStatus ==
                                              OrderStatus.delivered) {
                                            updateOrderStatus(
                                                orderId: orderId,
                                                orderStatus:
                                                    OrderStatus.completed,
                                                indexOfOrder: indexOfOrder,
                                                currentStatus: orderStatus);
                                          }
                                        },
                                        child: Center(
                                          child: Text(
                                            'Completed',
                                            style:
                                                kHeaderLabelTextStyle.copyWith(
                                                    color: (orderStatus ==
                                                            OrderStatus
                                                                .delivered)
                                                        ? Colors.black
                                                        : Colors.black54),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  child: Container(
                    color: Colors.black.withAlpha(0),
                    child: spinner ? kSpinner : Stack(),
                  ),
                  visible: spinner,
                ),
              ],
            );
          });
        });

    future.then((void value) => _closeModal(value));
  }

  void _closeModal(void value) {
    setNewOrderScreenAsHomeScreen();
  }

  void updateOrderStatus(
      {int orderId,
      OrderStatus orderStatus,
      int indexOfOrder,
      OrderStatus currentStatus}) async {
    int orderStatusId = 0;
    if (orderStatus == OrderStatus.pickedAtHotel) {
      orderStatusId = 4;
    } else if (orderStatus == OrderStatus.delivered) {
      orderStatusId = 5;
    } else if (orderStatus == OrderStatus.completed) {
      orderStatusId = 6;
    } else {
      orderStatusId = 3;
    }
    Navigator.pop(context);
    showStatusBottomSheet(
        spinner: true,
        orderStatus: orderStatus,
        indexOfOrder: indexOfOrder,
        orderId: orderId);

    NetworkResponse response = await WebApiServices.shared
        .updateOrderStatus(orderId: orderId, orderStatus: orderStatusId);
    print(response.responseCode);
    Navigator.pop(context);
    if (response.responseCode == 1) {
      currentOrdersToDelivery[indexOfOrder].orderStatus = orderStatus;
      OrderStatus nextStatus;
      if (orderStatus == OrderStatus.pickedAtHotel) {
        nextStatus = OrderStatus.delivered;
      } else if (orderStatus == OrderStatus.delivered) {
        nextStatus = OrderStatus.completed;
      } else {
        nextStatus = OrderStatus.completed;
      }
      showStatusBottomSheet(
          spinner: false,
          orderStatus: nextStatus,
          indexOfOrder: indexOfOrder,
          orderId: orderId);
    } else {
      showStatusBottomSheet(
          spinner: false,
          orderStatus: currentStatus,
          indexOfOrder: indexOfOrder,
          orderId: orderId);
      WebApiServices.shared.showToastMessage(
          message: response.responseMessage,
          place: ToastGravity.BOTTOM,
          duration: Toast.LENGTH_LONG,
          bgColor: Colors.grey);
    }
  }

  @override
  void initState() {
    setNewOrderScreenAsHomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        child: SafeArea(
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
        onWillPop: _onWillPop,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            title: NavigationItemTitle(
              title: 'Orders',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart),
            title: NavigationItemTitle(
              title: 'History',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              size: 25.0,
            ),
            title: NavigationItemTitle(
              title: 'Account',
            ),
          )
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Colors.green,
      ),
    );
  }
}

class NavigationItemTitle extends StatelessWidget {
  final String title;

  NavigationItemTitle({this.title});
  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
          fontSize: 14.0,
          fontFamily: 'AmaranthRegular',
          fontWeight: FontWeight.bold,
        ));
  }
}
