import 'customer_model.dart';

class Invoice {
  Customer customer;
  List<InvoiceItem> item;
  Invoice({required this.customer, required this.item});
}


class InvoiceItem {
  String campName;
  double price;
  int noOfAdult;
  int noOfChild;
  String foodType;
  InvoiceItem(
      {required this.price,
      required this.campName,
      required this.noOfChild,
      required this.noOfAdult,
      required this.foodType});
}
