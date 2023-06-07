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
  TextEditingController idController = TextEditingController(),
      nameController = TextEditingController(),
      bookingDateController = TextEditingController(),
      adultController = TextEditingController(),
      childController = TextEditingController(),
      typeController = TextEditingController(),
      priceController = TextEditingController(),
      totalController = TextEditingController();

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

  void findById(value) async {
    findCustomer = [];
    final data = await ApiService.findByID(int.parse(value));
    if (data.isNotEmpty) {
      setState(() {
        findCustomer.add(Customer.fromJson(data));
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            height(20),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "Customers ${customers.length}",
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1),
              ),
            ),
            height(15),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 30),
              height: 40,
              child: TextField(
                onChanged: (v) {
                  if (v.isNotEmpty) {
                    findById(v);
                  }
                },
                controller: searchId,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, bottom: 5),
                  hintText: 'Search by customer id ex. 1023',
                  hintStyle: TextStyle(fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
                  border: InputBorder.none,
                ),
              ),
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(
                  left: 30, right: 30, bottom: 30, top: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(31, 177, 162, 162)),
                  borderRadius: BorderRadius.circular(10)),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: header(),
                      rows: rows(),
                    )),
              ),
            )),
          ]),
    );
  }

  header() {
    List headers = [
      "Id",
      "Customer",
      "Booking Date",
      "Person",
      "Price",
      "Total",
      ""
    ];
    return List.generate(
      headers.length,
      (index) => DataColumn(label: Text(headers[index])),
    );
  }

  rows() {
    return customers.isEmpty
        ? List.generate(customers.length, (i) {
            return DataRow(cells: [
              DataCell(
                Container(
                  width: 100,
                  height: 35,
                  alignment: Alignment.centerLeft,
                  child: Text(customers[i].id.toString()),
                ),
              ),
              DataCell(
                Container(
                  alignment: Alignment.centerLeft,
                  width: 150,
                  height: 35,
                  child: Text(customers[i].name),
                ),
              ),
              DataCell(
                Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 35,
                  child: Text(customers[i].bookingDate),
                ),
              ),
              DataCell(
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 35,
                  child: Text(
                      (customers[i].adult + customers[i].child).toString()),
                ),
              ),
              DataCell(
                Container(
                  alignment: Alignment.centerLeft,
                  width: 150,
                  height: 35,
                  child: Text(customers[i].price.toString()),
                ),
              ),
              DataCell(
                Container(
                  alignment: Alignment.centerLeft,
                  width: 150,
                  height: 35,
                  child: Text(customers[i].total.toString()),
                ),
              ),
              DataCell(
                Container(
                  width: 50,
                  alignment: Alignment.center,
                  height: 35,
                  child: Row(
                    children: [
                      IconButton(
                          splashRadius: 15,
                          onPressed: () {
                            setState(() {
                              idController.text = customers[i].id.toString();
                              bookingDateController.text =
                                  customers[i].bookingDate.toString();
                              nameController.text = customers[i].name;
                              adultController.text =
                                  customers[i].adult.toString();
                              childController.text =
                                  customers[i].child.toString();
                              typeController.text =
                                  customers[i].groupType.toString();
                              priceController.text =
                                  customers[i].price.toString();
                              totalController.text =
                                  customers[i].total.toString();
                            });
                            editBox(context, i);
                            customers = [];
                            customers = [];
                            fetchData();
                          },
                          icon: const Icon(
                            Icons.edit,
                            size: 15,
                          ))
                    ],
                  ),
                ),
              )
            ]);
          })
        : List.generate(findCustomer.length, (i) {
            return DataRow(cells: [
              DataCell(
                Container(
                  width: 100,
                  height: 35,
                  alignment: Alignment.centerLeft,
                  child: Text(findCustomer[i].id.toString()),
                ),
              ),
              DataCell(
                Container(
                  alignment: Alignment.centerLeft,
                  width: 150,
                  height: 35,
                  child: Text(findCustomer[i].name),
                ),
              ),
              DataCell(
                Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 35,
                  child: Text(findCustomer[i].bookingDate),
                ),
              ),
              DataCell(
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 35,
                  child: Text((findCustomer[i].adult + findCustomer[i].child)
                      .toString()),
                ),
              ),
              DataCell(
                Container(
                  alignment: Alignment.centerLeft,
                  width: 120,
                  height: 35,
                  child: Text(findCustomer[i].price.toString()),
                ),
              ),
              DataCell(
                Container(
                  alignment: Alignment.centerLeft,
                  width: 120,
                  height: 35,
                  child: Text(findCustomer[i].total.toString()),
                ),
              ),
              DataCell(
                Container(
                  alignment: Alignment.centerLeft,
                  height: 35,
                  child: Row(
                    children: [
                      IconButton(
                          splashRadius: 15,
                          onPressed: () {
                            setState(() {
                              idController.text = findCustomer[i].id.toString();
                              bookingDateController.text =
                                  findCustomer[i].bookingDate.toString();
                              nameController.text = findCustomer[i].name;
                              adultController.text =
                                  findCustomer[i].adult.toString();
                              childController.text =
                                  findCustomer[i].child.toString();
                              typeController.text =
                                  findCustomer[i].groupType.toString();
                              priceController.text =
                                  findCustomer[i].price.toString();
                              totalController.text =
                                  findCustomer[i].total.toString();
                            });
                            editBox(context, i);
                            findCustomer = [];
                            customers = [];
                            fetchData();
                          },
                          icon: const Icon(
                            Icons.edit,
                            size: 15,
                          ))
                    ],
                  ),
                ),
              )
            ]);
          });
  }

  editBox(BuildContext context, i) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        InputDecoration decorat(lable) {
          return InputDecoration(
            labelText: lable,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.grey)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.grey)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.grey)),
          );
        }

        double size = MediaQuery.of(context).size.width;

        return AlertDialog(
          title: const Text('Edit Customer'),
          content: Container(
            alignment: Alignment.center,
            width: size > 600 ? 600 : double.infinity,
            height: size < 600 ? 400 : 300,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: 300,
                    child: TextFormField(
                        controller: idController, decoration: decorat("Id")),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: 300,
                    child: TextFormField(
                        controller: nameController,
                        decoration: decorat("Name")),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: 300,
                    child: TextFormField(
                        controller: bookingDateController,
                        decoration: decorat("Booking Date")),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: 300,
                    child: TextFormField(
                      controller: adultController,
                      decoration: decorat(
                        'Adult',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: 300,
                    child: TextFormField(
                      controller: childController,
                      decoration: decorat(
                        'Child',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: 300,
                    child: TextFormField(
                      controller: typeController,
                      decoration: decorat(
                        'groupType',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: 300,
                    child: TextFormField(
                      enabled: false,
                      controller: priceController,
                      decoration: decorat(
                        'Price',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: 300,
                    child: TextFormField(
                      enabled: false,
                      controller: totalController,
                      decoration: decorat(
                        'Total',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            OutlinedButton(
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size(120, 40))),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey),
                )),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                  minimumSize: MaterialStateProperty.all(const Size(120, 40))),
              onPressed: () {
                // Save the edited values
                setState(() {
                  findCustomer[i].id = int.parse(idController.text);
                  findCustomer[i].name = nameController.text;
                  findCustomer[i].bookingDate = bookingDateController.text;
                  findCustomer[i].adult = int.parse(adultController.text);
                  findCustomer[i].child = int.parse(childController.text);
                  findCustomer[i].groupType = typeController.text;
                });
                ApiService.update(findCustomer[i]);

                Navigator.of(context).pop();
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
