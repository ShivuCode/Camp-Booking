import 'package:camp_booking/Models/vendor_model.dart';
import 'package:camp_booking/Services/api.dart';
import 'package:camp_booking/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Responsive_Layout/responsiveWidget.dart';
import '../../Responsive_Layout/responsive_layout.dart';
import '../HOME/laptopHomeScreen.dart';
import '../HOME/mobileHomeScreen.dart';
import '../HOME/tabletHomeScreen.dart';

class VendorForm extends StatefulWidget {
  const VendorForm({super.key});

  @override
  State<VendorForm> createState() => _VendorFormState();
}

class _VendorFormState extends State<VendorForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  final TextEditingController _Vname = TextEditingController(),
      _gst = TextEditingController(),
      _website = TextEditingController(),
      _mobile = TextEditingController(),
      _mail = TextEditingController(),
      _address = TextEditingController(),
      _ownerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Vendor Registration,",
                  style: TextStyle(fontSize: 28)),
              height(10),
              ResponsiveForm.responsiveForm(children: [
                TextFormField(
                    controller: _Vname,
                    decoration: const InputDecoration(
                        label: Text("Organization Name"),
                        border: OutlineInputBorder()),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Please enter Organization name';
                      } else {
                        return null;
                      }
                    }),
                TextFormField(
                  controller: _gst,
                  decoration: const InputDecoration(
                      label: Text("Vendor Gst Registration"),
                      border: OutlineInputBorder()),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Please enter gst Registration';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _website,
                  decoration: const InputDecoration(
                      label: Text("Webiste"), border: OutlineInputBorder()),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Please enter website';
                    } else if (!v.contains("http")) {
                      return "Please enter valid link";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _mobile,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text("Mobile"), border: OutlineInputBorder()),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Please enter mobile number';
                    } else if (v.length < 10 || v.length > 10) {
                      return 'Please enter valid number';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _mail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      label: Text("Email"), border: OutlineInputBorder()),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Please enter email';
                    } else if (!v.contains("@") && !v.contains(".com")) {
                      return 'Please enter valid email';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _address,
                  keyboardType: TextInputType.streetAddress,
                  decoration: const InputDecoration(
                      label: Text("Address"), border: OutlineInputBorder()),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Please enter address';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _ownerName,
                  decoration: const InputDecoration(
                      label: Text("Owner Name"), border: OutlineInputBorder()),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Please enter Owner name';
                    } else {
                      return null;
                    }
                  },
                ),
              ]),
              height(10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(mainColor),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50))),
                        onPressed: () {
                          nextReplacement(
                              context,
                              ResponsiveLayout(
                                  mobileScaffold: MobileHomeScreen(
                                    pos: 'vendor',
                                  ),
                                  tabletScaffold: TabletHomeScreen(
                                    pos: 'vendor',
                                  ),
                                  laptopScaffold: LaptopHomeScreen(
                                    pos: 'vendor',
                                  )));
                        },
                        child: const Text("Cancel")),
                  ),
                  width(10),
                  Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(mainColor),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50))),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            print("call length");
                            // final data = await ApiService.fetchVendor(1, 10);

                            Vendor vendor = Vendor(
                                vendorid: 6,
                                userId: 1,
                                organizationName: _Vname.text,
                                gst: _gst.text,
                                mobile: _mobile.text,
                                email: _mail.text,
                                address: _address.text,
                                ownerName: _ownerName.text,
                                website: _website.text);

                            if (await ApiService.addVendor(vendor)) {
                              Fluttertoast.showToast(
                                  msg: "Registered Succefully",
                                  backgroundColor: mainColor);
                              // ignore: use_build_context_synchronously
                              nextReplacement(
                                  context,
                                  ResponsiveLayout(
                                      mobileScaffold: MobileHomeScreen(
                                        pos: 'vendor',
                                      ),
                                      tabletScaffold: TabletHomeScreen(
                                        pos: 'vendor',
                                      ),
                                      laptopScaffold: LaptopHomeScreen(
                                        pos: 'vendor',
                                      )));
                            }
                          }
                        },
                        child: const Text("Register")),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
