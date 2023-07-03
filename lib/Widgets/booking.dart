import 'package:camp_booking/Models/camp_model.dart';
import 'package:camp_booking/Models/customer_model.dart';
import 'package:camp_booking/Pages/ORDER/order.dart';
import 'package:camp_booking/Responsive_Layout/responsiveWidget.dart';
import 'package:camp_booking/Services/api.dart';
import 'package:camp_booking/Services/email.dart';
import 'package:camp_booking/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../Pages/HOME/laptopHomeScreen.dart';
import '../Pages/HOME/mobileHomeScreen.dart';
import '../Pages/HOME/tabletHomeScreen.dart';
import '../Responsive_Layout/responsive_layout.dart';

// ignore: must_be_immutable
class BookingPage extends StatefulWidget {
  Camp? camp;
  Customer? customer;
  BookingPage({super.key, this.customer, this.camp});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String _selectedGroupType = 'Couple';
  int _ticketFlag = 0;
  String _selectedDate = '';
  String date = '';
  String _userActive = 'Disable';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(),
      _addressController = TextEditingController(),
      _emailController = TextEditingController(),
      _mobileController = TextEditingController(),
      _adultController = TextEditingController(),
      _childController = TextEditingController(),
      _noOfVegController = TextEditingController(),
      _noOfNonVegController = TextEditingController(),
      _priceController = TextEditingController(),
      _advanceController = TextEditingController(),
      _totalController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        DateTime dt = picked;
        DateFormat dateFormat = DateFormat('yyyy-MM-ddThh:mm:ss');
        date = dateFormat.format(dt);
        DateFormat dateF = DateFormat('yyyy-MM-dd');
        _selectedDate = dateF.format(dt);
      });
    }
  }

  void _updateTotal() {
    if (_adultController.text.isNotEmpty &&
        _childController.text.isNotEmpty &&
        _priceController.text.isNotEmpty) {
      double total = ((double.parse(_priceController.text) *
              double.parse(_adultController.text)) +
          ((double.parse(_priceController.text) * 0.45) *
              double.parse(_childController.text)));

      setState(() {
        _totalController.text = total.toStringAsFixed(2);
      });
    }
  }

  void initialized() {
    if (widget.customer != null) {
      _ticketFlag = widget.customer!.ticketFlag;
      if (_ticketFlag == 0) {
        _userActive = "Enable";
      } else {
        _userActive = "Disable";
      }
      _selectedDate = widget.customer!.bookingDate.substring(0, 10);
      date = widget.customer!.bookingDate;
      _nameController.text = widget.customer!.name;
      _addressController.text = widget.customer!.address;
      _mobileController.text = widget.customer!.mobNo;
      _emailController.text = widget.customer!.email;
      _adultController.text = widget.customer!.adult.toString();
      _childController.text = widget.customer!.child.toString();
      _noOfVegController.text = widget.customer!.vegPeopleCount.toString();
      _noOfNonVegController.text =
          widget.customer!.nonVegPeopleCount.toString();
      _priceController.text = widget.customer!.price.toString();
      _advanceController.text = widget.customer!.advAmt.toString();
      _updateTotal();
    }
  }

  @override
  void initState() {
    initialized();
    super.initState();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _adultController.dispose();
    _nameController.dispose();
    _childController.dispose();
    _noOfVegController.dispose();
    _noOfNonVegController.dispose();
    _priceController.dispose();
    _advanceController.dispose();
    _totalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.customer != null)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                            "Your Previous Detail,\nWhat do you want to edit?",
                            style: TextStyle(fontSize: 28)),
                        height(10),
                      ]),
                if (widget.camp != null)
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      const Text("Your Selected Camp Details",
                          style: TextStyle(fontSize: 28)),
                      height(10),
                      Row(children: [
                        Container(
                          height: size < 600 ? 100 : 150,
                          width: size < 600 ? 100 : 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  onError: (exception, stackTrace) => {},
                                  image: NetworkImage(
                                      "https://pawnacamp.in/Content/img/Camp/${widget.camp!.titleImageUrl}"),
                                  fit: BoxFit.cover)),
                        ),
                        width(8),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size * 0.55,
                              child: Text(widget.camp!.campName,
                                  softWrap: true,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18)),
                            ),
                            height(8),
                            const SizedBox(
                              width: 200,
                              child: Text(
                                "Beautiful Couple Camping With Decoration light, food & support.",
                                softWrap: true,
                              ),
                            ),
                            height(10),
                            Text.rich(TextSpan(
                                text: "${widget.camp!.discountStatus}%OFF",
                                style: const TextStyle(color: Colors.blue),
                                children: [
                                  TextSpan(
                                      text: " ₹ ${widget.camp!.campFee}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black))
                                ]))
                          ],
                        )
                      ])
                    ]),
                  ),
                height(10),
                ResponsiveForm.responsiveForm(children: [
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    controller: _addressController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    controller: _mobileController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Mobile No.',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                      value: _selectedGroupType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedGroupType = newValue!;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select a group type';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Group Type',
                        border: OutlineInputBorder(),
                      ),
                      items: <String>[
                        'Family',
                        'Couple',
                        'Friends',
                        'Others',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()),
                  Row(
                    children: [
                      const Text(
                        'Booking Date: ',
                        style: TextStyle(fontSize: 16),
                      ),
                      width(10),
                      Expanded(
                        child: TextButton(
                          onPressed: () => _selectDate(context),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.all(10),
                            ),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 15)),
                            minimumSize:
                                MaterialStateProperty.all(const Size(250, 60)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                          child: Text(
                            _selectedDate.isEmpty
                                ? 'Select Date'
                                : _selectedDate,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(children: [
                    Expanded(
                      child: TextFormField(
                        controller: _adultController,
                        keyboardType: TextInputType.number,
                        onChanged: (v) {
                          if (_priceController.text.isNotEmpty) {
                            _updateTotal();
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the number of adults';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Adult',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    width(10),
                    Expanded(
                      child: TextFormField(
                        controller: _childController,
                        keyboardType: TextInputType.number,
                        onChanged: (v) {
                          if (_priceController.text.isNotEmpty) {
                            _updateTotal();
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the number of children';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Child',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    )
                  ]),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _noOfVegController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            int v = int.parse(_adultController.text) +
                                int.parse(_childController.text);
                            int c = int.parse(_noOfVegController.text) +
                                int.parse(_noOfNonVegController.text);
                            if (value!.isEmpty) {
                              return 'Please enter the number of children';
                            } else if (v != c) {
                              return 'Please enter valid Quantity';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Veg count',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      width(10),
                      Expanded(
                        child: TextFormField(
                          controller: _noOfNonVegController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            int v = int.parse(_adultController.text) +
                                int.parse(_childController.text);
                            int c = int.parse(_noOfVegController.text) +
                                int.parse(_noOfNonVegController.text);
                            if (value!.isEmpty) {
                              return 'Please enter the number of children';
                            } else if (v != c) {
                              return 'Please enter valid Quantity';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Non-Veg count',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the price';
                            } else if (int.tryParse(value) == null) {
                              return 'Please remove floating value';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Price',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (_) => _updateTotal(),
                        ),
                      ),
                      width(10),
                      Expanded(
                        child: TextFormField(
                          controller: _advanceController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the advance amount';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Advance',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (_) => _updateTotal(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                            value: _userActive,
                            onChanged: (newValue) {
                              setState(() {
                                if (newValue == 'Enaable') {
                                  _ticketFlag = 0;
                                  _userActive = "Enable";
                                } else {
                                  _ticketFlag = 1;
                                  _userActive = "Disable";
                                }
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'User Active',
                              border: OutlineInputBorder(),
                            ),
                            items: <String>[
                              'Enable',
                              'Disable',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()),
                      ),
                      width(10),
                      Expanded(
                        child: TextFormField(
                          controller: _totalController,
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: 'Total',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
                height(20),
                if (widget.customer != null)
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Perform booking confirmation logic here
                            nextReplacement(
                                context,
                                ResponsiveLayout(
                                    mobileScaffold:
                                        MobileHomeScreen(pos: 'search'),
                                    tabletScaffold:
                                        TabletHomeScreen(pos: 'search'),
                                    laptopScaffold:
                                        LaptopHomeScreen(pos: 'search')));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: Size(size * 0.4, 50)),
                        child: const Text('Cancel'),
                      )),
                      width(5),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            widget.customer!.name = _nameController.text;
                            widget.customer!.address = _addressController.text;
                            widget.customer!.mobNo = _mobileController.text;
                            widget.customer!.email = _emailController.text;
                            widget.customer!.adult =
                                int.parse(_adultController.text);
                            widget.customer!.child =
                                int.parse(_childController.text);
                            widget.customer!.nonVegPeopleCount =
                                int.parse(_noOfNonVegController.text);
                            widget.customer!.vegPeopleCount =
                                int.parse(_noOfVegController.text);
                            widget.customer!.advAmt =
                                int.parse(_advanceController.text);
                            widget.customer!.bookingDate = date;
                            widget.customer!.groupType = _selectedGroupType;
                            widget.customer!.price =
                                int.parse(_priceController.text);
                            widget.customer!.ticketFlag = _ticketFlag;

                            if (await ApiService.update(widget.customer!)) {
                              Fluttertoast.showToast(
                                  msg: "Updated", gravity: ToastGravity.BOTTOM);
                              // ignore: use_build_context_synchronously
                              nextReplacement(
                                  context,
                                  ResponsiveLayout(
                                      mobileScaffold:
                                          MobileHomeScreen(pos: 'search'),
                                      tabletScaffold:
                                          TabletHomeScreen(pos: 'search'),
                                      laptopScaffold:
                                          LaptopHomeScreen(pos: 'search')));
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Failed", gravity: ToastGravity.BOTTOM);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: Size(size * 0.4, 50)),
                        child: const Text('Save'),
                      ))
                    ],
                  ),
                if (widget.camp != null)
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                            primary: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: Size(size * 0.4, 45)),
                        child: const Text('Cancel'),
                      )),
                      width(5),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              if (_formKey.currentState!.validate()) {
                                int l = 0;
                                final data = await ApiService.fetchData();
                                l = data.length;

                                Customer customer = Customer(
                                    id: l + 1,
                                    name: _nameController.text,
                                    address: _addressController.text,
                                    email: _emailController.text,
                                    mobNo: _mobileController.text,
                                    adult: int.parse(_adultController.text),
                                    child: int.parse(_childController.text),
                                    vegPeopleCount:
                                        int.parse(_noOfVegController.text),
                                    nonVegPeopleCount:
                                        int.parse(_noOfNonVegController.text),
                                    bookingDate: date,
                                    groupType: _selectedGroupType,
                                    price: int.parse(_priceController.text),
                                    ticketFlag: _ticketFlag,
                                    advAmt: int.parse(_advanceController.text));
                                if (await ApiService.addNew(customer)) {
                                  Email.sendMail(customer);
                                  //ignore: use_build_context_synchronously
                                  nextReplacement(
                                      context,
                                      OrderPage(
                                          camp: widget.camp!,
                                          customer: customer));
                                }
                              }
                            } catch (e) {}
                          },
                          style: ElevatedButton.styleFrom(
                              primary: mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: Size(size * 0.9, 45)),
                          child: const Text('Confirm'),
                        ),
                      ),
                    ],
                  ),
                height(5),
              ],
            ),
          ),
        ));
  }
}
