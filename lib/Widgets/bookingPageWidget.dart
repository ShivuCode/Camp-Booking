import 'dart:async';

import 'package:camp_booking/Models/customer_model.dart';
import 'package:camp_booking/Pages/INVOICE/laptopInvoice.dart';
import 'package:camp_booking/Pages/INVOICE/mobileInvoice.dart';
import 'package:camp_booking/Pages/INVOICE/tabletInvoice.dart';
import 'package:camp_booking/Responsive_Layout/responsiveWidget.dart';
import 'package:camp_booking/Responsive_Layout/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:camp_booking/constant.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';

// ignore: must_be_immutable
class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController(),
      mobile = TextEditingController(),
      email = TextEditingController(),
      address = TextEditingController(),
      bookingDate = TextEditingController(),
      vegCount = TextEditingController(),
      nonVegCount = TextEditingController(),
      groupType = TextEditingController(),
      adult = TextEditingController(),
      child = TextEditingController(),
      totalAmt = TextEditingController(),
      price = TextEditingController(),
      advanceAmt = TextEditingController(),
      ticketFlag = TextEditingController();
late  Customer customer;

  void total() {
    try {
      double a =
          double.parse(adult.text) * double.parse(price.text.toString()) +
              double.parse(child.text) * double.parse(price.text.toString());
      setState(() {
        totalAmt.text = a.toString();
      });
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    adult.text = "0";
    child.text = "0";
    totalAmt.text = "0";
    advanceAmt.text = "0";
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size < 600 ? 20 : 50, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Fill the Complete form for Confirm Booking",
                  style: TextStyle(
                      fontSize: size < 600 ? 21 : 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                ),
                height(20),
                ResponsiveForm.responsiveForm(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldTitle("Full Name"),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: name,
                        keyboardType: TextInputType.text,
                        decoration: fieldDec("Full Name"),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Required full name";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldTitle("Mobile"),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: mobile,
                        keyboardType: TextInputType.number,
                        decoration: fieldDec("Mobile Number"),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Required number";
                          } else if (v.length < 9) {
                            return 'Invalid number';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldTitle("Email"),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: email,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Required email";
                          } else if (!v.contains("@") || !v.contains(".com")) {
                            return "Invalid email";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: fieldDec("Email"),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldTitle("Address"),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: address,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Required number";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: fieldDec("Address"),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldTitle("Booking Date"),
                      TextFormField(
                          style: const TextStyle(color: Colors.black),
                          controller: bookingDate,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return;
                            }
                            return null;
                          },
                          onTap: () async {
                            final DateTime? dt = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(3000));
                            if (dt != null) {
                              setState(() {
                                bookingDate.text =
                                    "${dt.day}/${dt.month}/${dt.year}";
                              });
                            }
                          },
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            hintText: 'dd-yy-mm',
                            hintStyle: const TextStyle(color: Colors.grey),
                            suffixIcon: const Icon(Icons.calendar_month),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                          )),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldTitle("Group Type"),
                      DropdownButton(
                        value: "Couple",
                          items: const [
                            DropdownMenuItem(child: Text("Family")),
                            DropdownMenuItem(child: Text("Couple")),
                            DropdownMenuItem(child: Text("Friends")),
                            DropdownMenuItem(child: Text("Others"))
                          ],
                          onChanged: (value) {
                            setState(() {
                              groupType.text = value;
                            });
                          })
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldTitle("No. of Veg people"),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                        controller: vegCount,
                        keyboardType: TextInputType.text,
                        decoration: fieldDec("0"),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldTitle("No. of Non-Veg people"),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                        controller: nonVegCount,
                        keyboardType: TextInputType.text,
                        decoration: fieldDec("0"),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldTitle("Price"),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: price,
                        onChanged: (v) => total(),
                        keyboardType: TextInputType.number,
                        decoration: fieldDec("0"),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldTitle("Adult: ${price.text}"),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: adult,
                        onChanged: (v) => total(),
                        keyboardType: TextInputType.number,
                        decoration: fieldDec("0"),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldTitle("Child: ${double.parse(price.text)/0.8} + [kids age 0-6 Free]"),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        onChanged: (v) => total(),
                        controller: child,
                        decoration: fieldDec("0"),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldTitle("Ticket Flag"),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: ticketFlag,
                        keyboardType: TextInputType.text,
                        decoration: fieldDec("flag..."),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldTitle("Advance Amount"),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: advanceAmt,
                        keyboardType: TextInputType.number,
                        decoration: fieldDec("0"),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldTitle("Total Amount"),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: totalAmt,
                        enabled: false,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                    ],
                  ),
                ]),
                height(20),
                ElevatedButton(
                  onPressed: () {
                    //if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    customer.addAll(
                        1,
                        name.text,
                        mobile.text,
                        address.text,
                        email.text,
                        int.parse(adult.text),
                        int.parse(child.text),
                        int.parse(vegCount.text),
                        int.parse(nonVegCount.text),
                        groupType.text,
                        bookingDate.text,
                        double.parse(price.text),
                        double.parse(advanceAmt.text),                        
                        double.parse(totalAmt.text),
                        ticketFlag.text,);
                    //after booking save the customer detail

                    nextScreen(
                        context,
                        ResponsiveLayout(
                            mobileScaffold: MobileInvoice(customer: customer),
                            tabletScaffold: TabletInvoice(customer: customer,),
                            laptopScaffold: LaptopInvoice(
                              customer: customer,
                            )));
                    //}
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(119, 50),
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.white),
                  child: const Text("Checkout"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // sendEmail(context, String subject, String body, String recipientmail) async {
  //   final Uri params =
  //       Uri(scheme: 'mailto', path: 'shivubind4160@gmail.com', query: '$body');

  //   runZoned(() async {
  //     // your asynchronous code here
  //     if (await canLaunchUrl(params)) {
  //       await launchUrl(params);
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text("send:openss")));
  //     } else {
  //       throw 'Could not launch $params';
  //     }
  //   }, onError: (error, stackTrace) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("error : $error")));
  //     print('Error: $error');
  //     print(stackTrace);
  //   });
  // }
}
