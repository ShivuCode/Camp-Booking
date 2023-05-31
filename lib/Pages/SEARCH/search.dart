import 'dart:convert';
import 'package:camp_booking/Models/customer_model.dart';
import 'package:camp_booking/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchId = TextEditingController(),
      searchName = TextEditingController();
  List<Customer> customers = [];
  List<Customer> findCustomer = [];
  Future<void> fetchCustomers() async {
    final response =
        await http.post(Uri.parse('https://titwi.in/api/customer/'), headers: {
      'Accept-Control-Allow-Origin': "*",
      'Access-Control-Allow-Credentials': "true",
      'Content-Type': "application/json",
      'Accept': "/"
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
    } else {
      print("Error");
    }
  }

  void findById(value) {
    setState(() {
      findCustomer = customers
          .where((element) => element.id.toString().contains(value))
          .toList();
    });
  }

  void findByName(value) {
    setState(() {
      findCustomer = customers
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(value.toString().toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    // fetchCustomers();
    customers.add(Customer(
        id: 102,
        name: "Shivu",
        mobNo: "9839847362",
        address: "Daman",
        email: "pbind@gmail.com",
        adult: 3,
        child: 0,
        groupType: 'friends',
        bookingDate: '12/06/2023',
        vegPeopleCount: 1,
        nonVegPeopleCount: 2,
        price: 2000,
        advAmt: 200,
        total: 6000,
        ticketFlag: '1'));
    customers.add(Customer(
        id: 103,
        name: "Siya",
        mobNo: "9839847362",
        address: "Daman",
        email: "pbind@gmail.com",
        adult: 3,
        child: 0,
        groupType: 'friends',
        bookingDate: '12/06/2023',
        vegPeopleCount: 1,
        nonVegPeopleCount: 2,
        price: 2000,
        advAmt: 200,
        total: 6000,
        ticketFlag: '1'));
    customers.add(Customer(
        id: 104,
        name: "Prabhu",
        mobNo: "9839847362",
        address: "Daman",
        email: "pbind@gmail.com",
        adult: 3,
        child: 0,
        groupType: 'friends',
        bookingDate: '12/06/2023',
        vegPeopleCount: 1,
        nonVegPeopleCount: 2,
        price: 2000,
        advAmt: 200,
        total: 6000,
        ticketFlag: '1'));
    findCustomer.addAll(customers);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextField(
                onChanged: (v) => findByName(v),
                controller: searchName,
                decoration: const InputDecoration(
                    // contentPadding: EdgeInsets.only(left: 10),
                    hintText: 'Search by customer name ex. Ab2',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none)),
          ),
          const Divider(
            thickness: 0.7,
          ),
          height(15),
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              "Customers 457",
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: 1),
            ),
          ),
          Expanded(
            child: Container(
                margin: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(31, 177, 162, 162)),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 40,
                      child: TextField(
                        onChanged: (v) => findById(v),
                        controller: searchId,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          hintText: 'Search by customer id ex. 1023',
                          hintStyle: TextStyle(fontSize: 14),
                          suffixIcon:
                              Icon(Icons.search, color: Colors.grey, size: 20),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height -
                            300, // Adjust the height as needed
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              header(),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: rows(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ]));
  }

  header() {
    List headers = [
      "Id",
      "Customer",
      "Booking Date",
      "Person",
      "Price",
      "Total"
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(
              headers.length,
              (index) => Container(
                  color: Colors.grey.shade100,
                  width: 150,
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    headers[index],
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  )))),
    );
  }

  rows() {
    return List.generate(findCustomer.length, (i) {
      return Row(children: [
        Container(
          width: 150,
          height: 35,
          alignment: Alignment.center,
          child: Text(findCustomer[i].id.toString()),
        ),
        Container(
          alignment: Alignment.center,
          width: 150,
          height: 35,
          child: Text(findCustomer[i].name),
        ),
        Container(
          alignment: Alignment.center,
          width: 150,
          height: 35,
          child: Text(findCustomer[i].bookingDate),
        ),
        Container(
          alignment: Alignment.center,
          width: 150,
          height: 35,
          child:
              Text((findCustomer[i].adult + findCustomer[i].child).toString()),
        ),
        Container(
          alignment: Alignment.center,
          width: 150,
          height: 35,
          child: Text(findCustomer[i].price.toString()),
        ),
        Container(
          alignment: Alignment.center,
          width: 150,
          height: 35,
          child: Text(findCustomer[i].total.toString()),
        ),
      ]);
    });
  }
}
