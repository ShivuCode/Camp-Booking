import 'package:camp_booking/Models/camp_model.dart';
import 'package:camp_booking/Models/customer_model.dart';
import 'package:camp_booking/Pages/ORDER/order.dart';
import 'package:camp_booking/Responsive_Layout/responsiveWidget.dart';
import 'package:camp_booking/Services/api.dart';
import 'package:camp_booking/Services/email.dart';
import 'package:camp_booking/constant.dart';
import 'package:camp_booking/variables.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../Services/database.dart';

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
  int _userActive = 0;

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
      _noteSection = TextEditingController(),
      _freeKid = TextEditingController(),
      _advanceController = TextEditingController(),
      _totalController = TextEditingController(),

      _discount = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.green, // Set your desired color here

            colorScheme: const ColorScheme.light(primary: mainColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    // ignore: unrelated_type_equality_checks
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
              ((double.parse(_priceController.text) * 0.5) *
                  double.parse(_childController.text))) -
          double.parse(_discount.text) -
          double.parse(_advanceController.text);

      setState(() {
        _totalController.text = total.toStringAsFixed(2);
      });
    }
  }

  void initialized() {
    if (widget.customer != null) {
      setState(() {
        _userActive = widget.customer!.ticketFlag;

        _selectedDate = widget.customer!.bookingDate.substring(0, 10);
        date = widget.customer!.bookingDate;
        _selectedGroupType = widget.customer!.groupType;
        _nameController.text = widget.customer!.name;
        _addressController.text = widget.customer!.address;
        _noteSection.text = widget.customer!.noteSection;
        _freeKid.text = widget.customer!.freeKid.toString();
        _mobileController.text = widget.customer!.mobNo;
        _emailController.text = widget.customer!.email;
        _adultController.text = widget.customer!.adult.toString();
        _childController.text = widget.customer!.child.toString();
        _noOfVegController.text = widget.customer!.vegPeopleCount.toString();
        _noOfNonVegController.text =
            widget.customer!.nonVegPeopleCount.toString();
        _priceController.text = widget.customer!.price.toString();
        _advanceController.text = widget.customer!.advAmt.toString();
        _discount.text = widget.customer!.discount.toString();
      });

      _updateTotal();
    } else {
      _adultController.text = '0';
      _childController.text = '0';
      _discount.text = '0';
      _freeKid.text = '0';
      _advanceController.text = '0';
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
    _noteSection.dispose();
    _freeKid.dispose();
    _totalController.dispose();
    _discount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Container(
        padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
        child: ScrollConfiguration(
          behavior: ScrollGlowEffect(),
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
                                    image: NetworkImage(widget
                                            .camp!.titleImageUrl
                                            .contains("/Content/Uploads")
                                        ? "https://titwi.in/${widget.camp!.titleImageUrl}"
                                        : "https://titwi.in/content/camp/${widget.camp!.titleImageUrl}"),
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
                                  text: widget.camp!.discountStatus,
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
                        cursorColor: mainColor,
                        controller: _nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: dec("Name")),
                    TextFormField(
                      cursorColor: mainColor,
                      controller: _addressController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                      decoration: dec("Address"),
                    ),
                    TextFormField(
                      cursorColor: mainColor,
                      controller: _emailController,
                      decoration: dec("Email"),
                    ),
                    TextFormField(
                        cursorColor: mainColor,
                        controller: _mobileController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: dec("Mobile No.")),
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
                        decoration: dec("Group Type"),
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
                                const EdgeInsets.symmetric(horizontal: 5),
                              ),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              textStyle: MaterialStateProperty.all(
                                  const TextStyle(fontSize: 15)),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(250, 45)),
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
                            cursorColor: mainColor,
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
                            decoration: dec("Adult")),
                      ),
                      width(10),
                      Expanded(
                        child: TextFormField(
                            cursorColor: mainColor,
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
                            decoration: dec("Child")),
                      ),
                      width(10),
                      Expanded(
                        child: TextFormField(
                            cursorColor: mainColor,
                            controller: _freeKid,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the number of children';
                              }
                              return null;
                            },
                            decoration: dec("Free Kid")),
                      ),
                    ]),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                              cursorColor: mainColor,
                              controller: _noOfVegController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                int v = int.parse(_adultController.text) +
                                    int.parse(_childController.text) +
                                    int.parse(_freeKid.text);
                                int c = int.parse(_noOfVegController.text) +
                                    int.parse(_noOfNonVegController.text);
                                if (value!.isEmpty) {
                                  return 'Please enter the number of children';
                                } else if (v != c) {
                                  return 'Please enter valid Quantity';
                                }
                                return null;
                              },
                              decoration: dec("Veg Count")),
                        ),
                        width(10),
                        Expanded(
                          child: TextFormField(
                              cursorColor: mainColor,
                              controller: _noOfNonVegController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                int v = int.parse(_adultController.text) +
                                    int.parse(_childController.text) +
                                    int.parse(_freeKid.text);
                                int c = int.parse(_noOfVegController.text) +
                                    int.parse(_noOfNonVegController.text);
                                if (value!.isEmpty) {
                                  return 'Please enter the number of children';
                                } else if (v != c) {
                                  return 'Please enter valid Quantity';
                                }
                                return null;
                              },
                              decoration: dec("Non-Veg Count")),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            cursorColor: mainColor,
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
                            decoration: dec("Price"),
                            onChanged: (_) => _updateTotal(),
                          ),
                        ),
                        width(10),
                        Expanded(
                          child: TextFormField(
                            cursorColor: mainColor,
                            controller: _advanceController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the advance amount';
                              }
                              return null;
                            },
                            decoration: dec("Advance"),
                            onChanged: (_) => _updateTotal(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            cursorColor: mainColor,
                            controller: _discount,
                            keyboardType: TextInputType.number,
                            decoration: dec("Discount"),
                            onChanged: (_) => _updateTotal(),
                          ),
                        ),
                        width(10),
                        Expanded(
                          child: TextFormField(
                            cursorColor: mainColor,
                            controller: _totalController,
                            enabled: false,
                            decoration: dec("Total"),
                          ),
                        ),
                      ],
                    ),
                    DropdownButtonFormField<int>(
                      value: _userActive,
                      onChanged: (int? newValue) {
                        setState(() {
                          _userActive = newValue ?? 0;
                        });
                      },
                      decoration: dec("User Active"),
                      items: const [
                        DropdownMenuItem<int>(
                          value: 0,
                          child: Text("Enable"),
                        ),
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text("Disable"),
                        ),
                      ],
                    )
                  ]),
                  height(20),
                  TextFormField(
                    cursorColor: mainColor,
                    maxLength: 200,
                    maxLines: 4,
                    controller: _noteSection,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Note',
                      hintText: 'Description',
                      helperStyle: TextStyle(color: Colors.grey.shade300),
                      labelStyle: const TextStyle(color: Colors.grey),
                      contentPadding: const EdgeInsets.all(8),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              const BorderSide(color: mainColor, width: 1.3)),
                    ),
                    onChanged: (_) => _updateTotal(),
                  ),
                  
                  height(20),
                  if (widget.customer != null)
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                _selectedDate.isNotEmpty) {
                              // Perform booking confirmation logic here
                              nextReplacement(context, search);
                            } else {
                              myToast(context, "Please fill all requirements");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
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
                            if (_formKey.currentState!.validate() &&
                                _selectedDate.isNotEmpty) {
                              widget.customer!.name = _nameController.text;
                              widget.customer!.address =
                                  _addressController.text;
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
                              widget.customer!.freeKid =
                                  int.parse(_freeKid.text);
                              widget.customer!.noteSection = _noteSection.text;
                              widget.customer!.price =
                                  int.parse(_priceController.text);
                              widget.customer!.discount =
                                  int.parse(_discount.text);
                              widget.customer!.ticketFlag = _userActive;

                              if (await ApiService.update(
                                  context, widget.customer!)) {
                                // ignore: use_build_context_synchronously
                                myToast(context, "Updated Successfully");
                                // ignore: use_build_context_synchronously
                                nextReplacement(context, search);
                              } else {
                                // ignore: use_build_context_synchronously
                                myToast(context, "Failed");
                              }
                            } else {
                              myToast(context, "Please fill all requirements");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
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
                              backgroundColor: mainColor,
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
                                  final data =
                                      await ApiService.fetchData(context);
                                  int id = await DbHelper.getId();
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
                                      ticketFlag: _userActive,
                                      noteSection: _noteSection.text,
                                      userId: id,
                                      freeKid: int.parse(_freeKid.text),
                                      advAmt:
                                          int.parse(_advanceController.text),
                                      discount: int.parse(_discount.text));
                                  // ignore: use_build_context_synchronously
                                  if (await ApiService.addNew(
                                      context, customer)) {
                                    customer.email.isNotEmpty
                                        ? Email.sendMail(customer)
                                        : null;

                                    // ignore: use_build_context_synchronously
                                    myToast(context, "Booking Successfully");
                                    //ignore: use_build_context_synchronously
                                    nextReplacement(
                                        context,
                                        OrderPage(
                                            camp: widget.camp!,
                                            customer: customer));
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    myToast(context, "Failed");
                                  }
                                }
                              } catch (e) {
                                if (kDebugMode) {
                                  print(e);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
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
          ),
        ));
  }
}
