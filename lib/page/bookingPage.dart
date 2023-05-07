import 'package:camp_booking/widget/ResponsiveLayout.dart';
import 'package:camp_booking/page/invoicePage.dart';
import 'package:flutter/material.dart';

import '../constants/constant.dart';

class BookingPage extends StatefulWidget {
  Map camp;
  BookingPage({super.key, required this.camp});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController bookingDate = TextEditingController();
  TextEditingController foodType = TextEditingController();
  TextEditingController adult = TextEditingController();
  TextEditingController child = TextEditingController();
  TextEditingController totalAmt = TextEditingController();
  Map<String, dynamic> details = {};

  void total() {
    try {
      double a = double.parse(adult.text) *
              double.parse(widget.camp["price"].toString()) +
          double.parse(child.text) *
              double.parse(widget.camp["child"].toString());
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
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: size * 2.5,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(8.0),
            image: const DecorationImage(
              image: NetworkImage(
                  "https://rt-homepage.roadtrippers.com/wp-content/uploads/2019/05/camping_night_tent_stars.jpg"),
              fit: BoxFit.cover,
              opacity: 0.8,
            )),
        child: Padding(
          padding: EdgeInsets.all(size < 600 ? 15 : 50),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fill the Complete form for Confirm Booking",
                    style: TextStyle(
                        fontSize: size < 600 ? 21 : 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  height(20),
                  ResponsiveLayout.responsiveForm(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fieldTitle("Full Name"),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
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
                          style: const TextStyle(color: Colors.white),
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
                          style: const TextStyle(color: Colors.white),
                          controller: email,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Required email";
                            } else if (!v.contains("@") ||
                                !v.contains(".com")) {
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
                          style: const TextStyle(color: Colors.white),
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
                            style: const TextStyle(color: Colors.white),
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
                                      const BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                            )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fieldTitle("Food Type"),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Required food type";
                            }
                            return null;
                          },
                          controller: foodType,
                          keyboardType: TextInputType.text,
                          decoration: fieldDec("Ex- 1 Veg and # Non Veg"),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fieldTitle("Adult: ${widget.camp["price"]}"),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
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
                        fieldTitle(
                            "Child: ${widget.camp["child"]} + [kids age 0-6 Free]"),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          onChanged: (v) => total(),
                          controller: child,
                          decoration: fieldDec("0"),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fieldTitle("Total Amount"),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
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
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          details.addAll({
                            "name": name.text,
                            "email": email.text,
                            "add": address.text,
                            "mobile": mobile.text,
                            "food": foodType.text,
                            "date": bookingDate.text,
                            "adult": adult.text,
                            "child": child.text,
                            "total": totalAmt.text,
                            "campName": widget.camp["name"],
                            "price": widget.camp["price"],
                            "childPrice": widget.camp["child"]
                          });
                        });
                        nextScreen(context, Invoice(details: details));
                      }
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
      ),
    );
  }
}
