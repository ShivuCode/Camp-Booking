import 'package:camp_booking/Models/customer_model.dart';
import 'package:flutter/material.dart';

class CustomerProvider with ChangeNotifier {
  List<Customer> customers = [];

  //fetching all customers details
  // Future<List<Customer>> getAllCustomer() async {
  //   await ApiService.getCustomers();
  //   return customers;
  //   // customers = await ApiService.getCustomers();
  //   // return customers;
  // }
}
