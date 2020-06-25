import 'package:fooddelivery/models/enum_collections.dart';

class OrderModel {
  int orderId;
  String deliveryName;
  String mobileNo;
  double totalPrice;
  PaymentStatus paidStatus;
  String hotelAddress;
  String deliveryAddress;
  double deliveryAddressLatitude;
  double deliveryAddressLongitude;
  OrderStatus orderStatus;

  OrderModel(
      {this.orderId,
      this.deliveryName,
      this.mobileNo,
      this.totalPrice,
      this.paidStatus,
      this.hotelAddress,
      this.deliveryAddress,
      this.deliveryAddressLatitude,
      this.deliveryAddressLongitude,
      this.orderStatus});
}
