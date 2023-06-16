import 'package:camp_booking/Models/camp_model.dart';
import 'package:camp_booking/Models/customer_model.dart';
import 'package:camp_booking/Responsive_Layout/responsiveWidget.dart';
import 'package:camp_booking/Services/ApiService.dart';
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
  String _selectedDate = '';
  String date = '';

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
    double total = ((double.parse(_priceController.text) *
            double.parse(_adultController.text)) +
        ((double.parse(_priceController.text) * 0.45) *
            double.parse(_childController.text)));

    setState(() {
      _totalController.text = total.toStringAsFixed(2);
    });
  }

  void initialized() {
    if (widget.customer != null) {
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
                                  image: NetworkImage(widget.camp!.imageUrl),
                                  fit: BoxFit.cover)),
                        ),
                        width(8),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.camp!.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18)),
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
                                      text: " ₹ ${widget.camp!.fee}",
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
                                const TextStyle(fontSize: 18)),
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the number of adults';
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the number of children';
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the price';
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
                  TextFormField(
                    controller: _totalController,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Total',
                      border: OutlineInputBorder(),
                    ),
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
                            minimumSize: Size(size * 0.4, 60)),
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
                            print(widget.customer!.bookingDate);
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
                            minimumSize: Size(size * 0.4, 60)),
                        child: const Text('Save'),
                      ))
                    ],
                  ),
                if (widget.camp != null)
                  ElevatedButton(
                    onPressed: () async {
                      print("${_selectedDate}");
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
                            vegPeopleCount: int.parse(_noOfVegController.text),
                            nonVegPeopleCount:
                                int.parse(_noOfNonVegController.text),
                            bookingDate: "${_selectedDate}T00:00:00",
                            groupType: _selectedGroupType,
                            price: int.parse(_priceController.text),
                            ticketFlag: 1,
                            advAmt: int.parse(_advanceController.text));
                        if (await ApiService.addNew(customer)) {
                          // ignore: use_build_context_synchronously
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: const Text("Booking Successful"),
                                    icon: const ImageIcon(
                                      AssetImage('assets/c4.png'),
                                      size: 60.0,
                                    ),
                                    content: const Text(
                                        "Request for camp booking is approved. Have a taste of wild."),
                                    actions: [
                                      MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            nextReplacement(
                                                context,
                                                ResponsiveLayout(
                                                    mobileScaffold:
                                                        MobileHomeScreen(),
                                                    tabletScaffold:
                                                        TabletHomeScreen(),
                                                    laptopScaffold:
                                                        LaptopHomeScreen()));
                                          },
                                          color: mainColor,
                                          minWidth: double.infinity,
                                          height: 40,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: const Text(
                                            "THANKS!",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                    ],
                                  ));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size(size * 0.9, 60)),
                    child: const Text('Confirm'),
                  )
              ],
            ),
          ),
        ));
  }
}
