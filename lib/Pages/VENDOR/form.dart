// ignore_for_file: use_build_context_synchronously

import 'package:camp_booking/Models/vendor_model.dart';
import 'package:camp_booking/Services/api.dart';
import 'package:camp_booking/constant.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Responsive_Layout/responsiveWidget.dart';
import '../../Responsive_Layout/responsive_layout.dart';
import '../../Services/database.dart';
import '../../variables.dart';
import '../HOME/laptopHomeScreen.dart';
import '../HOME/mobileHomeScreen.dart';
import '../HOME/tabletHomeScreen.dart';

// ignore: must_be_immutable
class VendorForm extends StatefulWidget {
  VendorForm({super.key, this.vendor});
  Vendor? vendor;
  @override
  State<VendorForm> createState() => _VendorFormState();
}

class _VendorFormState extends State<VendorForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = "";
  int uid = 0;
  int id = 0;
  bool showUserDropDown = false;
  List<Map<String, dynamic>> userId = [];
  bool showUpdate = false;
  bool isLoad = false;
  // ignore: non_constant_identifier_names
  final TextEditingController _Vname = TextEditingController(),
      _gst = TextEditingController(),
      _website = TextEditingController(),
      _mobile = TextEditingController(),
      _mail = TextEditingController(),
      _address = TextEditingController(),
      _loction = TextEditingController(),
      _ownerName = TextEditingController();

  check() async {
    if (await DbHelper.getId() == 1) {
      setState(() {
        showUserDropDown = true;
      });

      final data = await ApiService.fetchUsers();
      if (data.isNotEmpty) {
        for (var element in data) {
          print(element);
          if (element['rolesId'] != 3) {
            if (!userId.any((item) => item["name"] == element["userName"])) {
              setState(() {
                userId.add(
                    {"name": element['userName'] ?? "", "id": element["id"]});
              });
            }
          }
        }

        setState(() {
          userId.add({"name": data[0]['userName'] ?? '', "id": data[0]["id"]});
          name = userId[0]["name"];
          uid = userId[0]["id"];
        });
      }
    }
  }

  findId() {
    for (var element in userId) {
      if (element["name"] == name) {
        setState(() {
          uid = element["id"];
        });
      }
    }
  }

  void clearTextBoxs() {
    setState(() {
      _ownerName.clear();
      _Vname.clear();
      _address.clear();
      _gst.clear();
      _mail.clear();
      _mobile.clear();
      _website.clear();
    });
  }

  @override
  void initState() {
    if (widget.vendor != null) {
      setState(() {
        id = widget.vendor!.vendorid;
        uid = widget.vendor!.userId;
        _Vname.text = widget.vendor!.organizationName;
        _address.text = widget.vendor!.address;
        _gst.text = widget.vendor!.gst;
        _mail.text = widget.vendor!.email;
        _mobile.text = widget.vendor!.mobile;
        _ownerName.text = widget.vendor!.ownerName;
        _website.text = widget.vendor!.website;
        _loction.text = widget.vendor!.location;
        showUpdate = true;
      });
    }
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollGlowEffect(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Vendor Registration,",
                        style: TextStyle(fontSize: 28)),
                    height(10),
                    ResponsiveForm.responsiveForm(children: [
                      TextFormField(
                          cursorColor: mainColor,
                          controller: _Vname,
                          decoration: dec("Organization Name"),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Please enter Organization name';
                            } else {
                              return null;
                            }
                          }),
                      TextFormField(
                        cursorColor: mainColor,
                        controller: _gst,
                        decoration: dec("Vendor Gst Registration"),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Please enter gst Registration';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        cursorColor: mainColor,
                        controller: _website,
                        decoration: dec("Webiste"),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Please enter website';
                          } else if (!v.contains(".")) {
                            return "Please enter valid link";
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        cursorColor: mainColor,
                        controller: _mobile,
                        keyboardType: TextInputType.number,
                        decoration: dec("Mobile"),
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
                      showUserDropDown
                          ? DropdownSearch(
                              showSearchBox: true,
                              maxHeight:
                                  userId.length < 3 ? userId.length * 90 : 400,
                              popupSafeArea: const PopupSafeAreaProps(
                                  minimum: EdgeInsets.all(10)),
                              searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(0),
                                    prefixIcon: const Icon(
                                      FontAwesomeIcons.magnifyingGlass,
                                      size: 18,
                                    ),
                                    prefixIconColor: mainColor,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 1.3)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            color: mainColor, width: 1.3)),
                                  ),
                                  cursorColor: mainColor),
                              popupShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              dropdownSearchDecoration: dec("User Id"),
                              items: userId.map((e) => e["name"]).toList(),
                              selectedItem: name,
                              onChanged: (value) => setState(() {
                                name = value;
                                print(name);
                              }),
                            )
                          : TextFormField(
                              cursorColor: mainColor,
                              controller: _mail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: dec("Email"),
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return 'Please enter email';
                                } else if (!v.contains("@") &&
                                    !v.contains(".com")) {
                                  return 'Please enter valid email';
                                } else {
                                  return null;
                                }
                              },
                            ),
                      TextFormField(
                        cursorColor: mainColor,
                        controller: _address,
                        keyboardType: TextInputType.streetAddress,
                        decoration: dec("Address"),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Please enter address';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        cursorColor: mainColor,
                        controller: _ownerName,
                        decoration: dec("Owner Name"),
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
                    TextFormField(
                      decoration: dec("Location"),
                      controller: _loction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Location required';
                        } else {
                          return null;
                        }
                      },
                    ),
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
                                          pos: 'editVendor',
                                        ),
                                        tabletScaffold: TabletHomeScreen(
                                          pos: 'editVendor',
                                        ),
                                        laptopScaffold: LaptopHomeScreen(
                                          pos: 'editVendor',
                                        )));
                              },
                              child: const Text("Cancel")),
                        ),
                        width(10),
                        Expanded(
                          child: showUpdate
                              ? ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(mainColor),
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(double.infinity, 50))),
                                  onPressed: () async {
                                    findId();
                                    print(uid);
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoad = true;
                                      });

                                      widget.vendor!.userId = uid;
                                      widget.vendor!.organizationName =
                                          _Vname.text;
                                      widget.vendor!.address = _address.text;
                                      widget.vendor!.gst = _gst.text;
                                      widget.vendor!.email = name;
                                      widget.vendor!.mobile = _mobile.text;
                                      widget.vendor!.ownerName =
                                          _ownerName.text;
                                      widget.vendor!.website = _website.text;
                                      widget.vendor!.location = _loction.text;
                                      if (await ApiService.updateVendor(
                                          context, widget.vendor!)) {
                                        myToast(context, "Details Updated");
                                        clearTextBoxs();
                                        Navigator.pop(context);
                                      } else {
                                        myToast(context, "Updating Failed");
                                      }
                                    }
                                    setState(() {
                                      isLoad = false;
                                    });
                                  },
                                  child: const Text("Update"))
                              : ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(mainColor),
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(double.infinity, 50))),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      findId();
                                      print(uid);
                                      setState(() {
                                        isLoad = true;
                                      });
                                      final data =
                                          await ApiService.fetchVendor(1, 20);

                                      Vendor vendor = Vendor(
                                          vendorid: data.length + 1,
                                          userId: uid,
                                          organizationName: _Vname.text,
                                          gst: _gst.text,
                                          mobile: _mobile.text,
                                          email: showUserDropDown
                                              ? name
                                              : _mail.text,
                                          address: _address.text,
                                          ownerName: _ownerName.text,
                                          website: _website.text,
                                          location: _loction.text);

                                      if (await ApiService.addVendor(
                                          context, vendor)) {
                                        Fluttertoast.showToast(
                                            msg: "Registered Succefully",
                                            backgroundColor: mainColor);

                                        nextReplacement(
                                            context,
                                            ResponsiveLayout(
                                                mobileScaffold:
                                                    MobileHomeScreen(
                                                  pos: 'vendor',
                                                ),
                                                tabletScaffold:
                                                    TabletHomeScreen(
                                                  pos: 'vendor',
                                                ),
                                                laptopScaffold:
                                                    LaptopHomeScreen(
                                                  pos: 'vendor',
                                                )));
                                      }
                                    }
                                    setState(() {
                                      isLoad = false;
                                    });
                                  },
                                  child: const Text("Register")),
                        ),
                      ],
                    ),
                    height(20),
                    isLoad
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Colors.grey.shade300,
                            strokeWidth: 5,
                          ))
                        : const Center()
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
