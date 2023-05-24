import 'package:camp_booking/Models/customer_model.dart';
import 'package:flutter/material.dart';

import '../Services/ApiService.dart';

class CustomerProvider with ChangeNotifier {
  List<Customer> customers=[];

  //fetching all customers details
  Future<List<Customer>> getAllCustomer() async {
    customers = await ApiService.getCustomers();
    return customers;
  }
}
