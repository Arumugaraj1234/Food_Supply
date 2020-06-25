class HistoryOrderModel {
  int orderId;
  String orderDate;
  String hotelAddress;
  String deliveryAddress;
  double orderRatings;

  HistoryOrderModel(
      {this.orderId,
      this.orderDate,
      this.hotelAddress,
      this.deliveryAddress,
      this.orderRatings});
}
