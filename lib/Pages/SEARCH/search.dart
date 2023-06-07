import 'package:camp_booking/Models/customer_model.dart';
import 'package:camp_booking/Services/ApiService.dart';
import 'package:camp_booking/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchId = TextEditingController(),
      searchName = TextEditingController();
  List<Customer> findCustomer = [];
  List<Customer> customers = [];

  void fetchData() async {
    final data = await ApiService.fetchData();

    for (var element in data) {
      Customer customer = Customer.fromJson(element);
      setState(() {
        customers.add(customer);
        findCustomer.add(customer);
      });
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
    print(customers);
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
    fetchData();
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
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              "Customers ${customers.length}",
              style: const TextStyle(
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
