import 'dart:io';
import 'package:camp_booking/Models/camp_model.dart';
import 'package:camp_booking/Responsive_Layout/responsiveWidget.dart';
import 'package:camp_booking/Services/api.dart';
import 'package:camp_booking/Services/database.dart';
import 'package:camp_booking/variables.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../constant.dart';

// ignore: must_be_immutable
class AddCamp extends StatefulWidget {
  Camp? camp;
  AddCamp({super.key, this.camp});
  @override
  State<AddCamp> createState() => _AddCampState();
}

class _AddCampState extends State<AddCamp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // ignore: prefer_final_fields
  final TextEditingController _cName = TextEditingController(),
      _location = TextEditingController(),
      _fee = TextEditingController(),
      _brochure = TextEditingController(),
      _viewDetails = TextEditingController(),
      _controllerName = TextEditingController(),
      _type = TextEditingController(),
      _planId = TextEditingController();

  String _imageUrl = '';
  String _isActive = 'Disable';
  String _discount = '5% OFF';
  String _videoUrl = "";
  String? _thumbnailPath = '';
  String name = "";
  int id = 0;
  bool showUserDropDown = false;
  bool update = false;
  List vendorId = [];
  check() async {
    if (await DbHelper.getId() == 1) {
      setState(() {
        showUserDropDown = true;
      });

      final data = await ApiService.fetchVendor(1, 20);

      if (data.isNotEmpty) {
        setState(() {
          vendorId.add({
            "name": data['items'][0]['email'] ?? '',
            "id": data['items'][0]["userId"] ?? 0
          });
          name = vendorId[0]["name"];
          id = vendorId[0]["id"];
        });
        for (var element in data['items']) {
          if (!vendorId.any((item) => item["name"] == element["email"])) {
            setState(() {
              vendorId.add({
                "name": element['email'] ?? "",
                "id": element["userId"] ?? 0
              });
            });
          }
        }
      }
    }
  }

  findId() {
    for (var element in vendorId) {
      if (element["name"] == name) {
        setState(() {
          id = element["id"];
        });
      }
    }
  }

  editCheck() {
    if (widget.camp != null) {
      setState(() {
        update = true;
      });
      _cName.text = widget.camp!.campName;
      _brochure.text = widget.camp!.campBrochure;
      _controllerName.text = widget.camp!.controllerName;
      _discount = widget.camp!.discountStatus;
      _fee.text = widget.camp!.campFee.toString();
      _imageUrl = widget.camp!.titleImageUrl;
      _videoUrl = "https://PawnacampAppProd.titwi.in/${widget.camp!.videoUrl}";
      _location.text = widget.camp!.campLocation;
      _isActive = widget.camp!.isActive == 1 ? "Enable" : "Disable";
      _planId.text = widget.camp!.campPlanId.toString();
      _type.text = widget.camp!.type.toString();
      _viewDetails.text = widget.camp!.campViewDetails;
      _generateThumbnail();
    }
  }

  void clearTextboxs() {
    _brochure.clear();
    _cName.clear();
    _controllerName.clear();
    _discount = "5% OFF";
    _fee.clear();
    _imageUrl = '';
    _isActive = "Enable";
    _location.clear();
    _planId.clear();
    _thumbnailPath = '';
    _type.clear();
    _viewDetails.clear();
  }

  @override
  void initState() {
    check();
    editCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollGlowEffect(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      height(10),
                      const Text(
                          "Add Camp Details,\nWhich Camp you want to add?",
                          style: TextStyle(fontSize: 28)),
                      height(10),
                      ResponsiveForm.responsiveForm(children: [
                        if (showUserDropDown)
                          DropdownSearch(
                            showSearchBox: true,
                            maxHeight: vendorId.length < 3
                                ? vendorId.length * 90
                                : 400,

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
                            dropdownSearchDecoration: dec("Vendor Id"),
                            items: vendorId.map((e) => e["name"]).toList(),
                            selectedItem: "",
                            onChanged: (value) => setState(() {
                              name = value;
                            }),
                            // items: List.generate(10, (index) => "Hello $index"),
                          ),
                        TextFormField(
                          cursorColor: mainColor,
                          controller: _cName,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          decoration: dec("Camp Name"),
                        ),
                        TextFormField(
                          cursorColor: mainColor,
                          controller: _location,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          decoration: dec("Location"),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                cursorColor: mainColor,
                                controller: _fee,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                                decoration: dec("Fee"),
                              ),
                            ),
                            width(10),
                            Expanded(
                              child: TextFormField(
                                cursorColor: mainColor,
                                controller: _brochure,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter brochure';
                                  }
                                  return null;
                                },
                                decoration: dec("Camp Broucher"),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                  value: _discount,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _discount = newValue!;
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please select a group type';
                                    }
                                    return null;
                                  },
                                  decoration: dec("Discount"),
                                  items: <String>[
                                    '0% OFF',
                                    '5% OFF',
                                    '10% OFF',
                                    '15% OFF',
                                    '20% OFF',
                                    '12.5% OFF',
                                    '30% OFF',
                                    '45% OFF',
                                    '40% OFF',
                                    '50% OFF',
                                    '60% OFF',
                                    '70% OFF',
                                    '80% OFF',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                    );
                                  }).toList()),
                            ),
                            width(10),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                  value: _isActive,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _isActive = newValue!;
                                    });
                                  },
                                  decoration: dec("IsActive"),
                                  items: <String>[
                                    'Enable',
                                    'Disable',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                cursorColor: mainColor,
                                controller: _planId,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter campPlanId';
                                  }
                                  return null;
                                },
                                decoration: dec("Camp Plan Id"),
                              ),
                            ),
                            width(10),
                            Expanded(
                              child: TextFormField(
                                cursorColor: mainColor,
                                controller: _type,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter camp type';
                                  }
                                  return null;
                                },
                                decoration: dec("Type"),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Select Image: ",
                                style: TextStyle(fontSize: 18)),
                            Container(
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.centerLeft,
                              height: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: _imageUrl.isEmpty
                                  ? const Center()
                                  : update
                                      ? Image.network(
                                          widget.camp!.titleImageUrl
                                                  .contains("/Content/Uploads")
                                              ? "https://PawnacampAppProd.titwi.in/${widget.camp!.titleImageUrl}"
                                              : "https://PawnacampAppProd.titwi.in/content/camp/${widget.camp!.titleImageUrl}",
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              "assets/imageIcon.png",
                                            );
                                          },
                                        )
                                      : Image.file(File(_imageUrl)),
                            ),
                            height(5),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor),
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();
                                setState(() {
                                  _imageUrl = result!.paths.first!;
                                });
                              },
                              child: const Text("Upload"),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Select Video: ",
                                style: TextStyle(fontSize: 18)),
                            Container(
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.centerLeft,
                              height: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: _thumbnailPath!.isNotEmpty
                                  ? Image.file(File(_thumbnailPath!))
                                  : const Center(),
                            ),
                            height(5),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor),
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();
                                setState(() {
                                  _videoUrl = result!.paths.first!;
                                  _generateThumbnail();
                                });
                              },
                              child: const Text("Upload"),
                            )
                          ],
                        ),
                        TextFormField(
                          cursorColor: mainColor,
                          controller: _controllerName,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter controller name';
                            }
                            return null;
                          },
                          decoration: dec("Controller Name"),
                        ),
                        TextFormField(
                          cursorColor: mainColor,
                          controller: _viewDetails,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter view details';
                            }
                            return null;
                          },
                          decoration: dec("View Details"),
                        ),
                      ]),
                      height(10),
                      update
                          ? Row(
                              children: [
                                Expanded(
                                    child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: mainColor,
                                      minimumSize:
                                          const Size(double.infinity, 50)),
                                  child: const Text("Cancel"),
                                  onPressed: () => Navigator.pop(context),
                                )),
                                width(6),
                                Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: mainColor,
                                          minimumSize:
                                              const Size(double.infinity, 50)),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          findId();
                                          Camp camp = Camp(
                                              campId: id,
                                              campName: _cName.text,
                                              campLocation: _location.text,
                                              campFee: int.parse(_fee.text),
                                              campImageGroupId: 1,
                                              campBrochure: _brochure.text,
                                              campViewDetails:
                                                  _viewDetails.text,
                                              campPlanId:
                                                  int.parse(_planId.text),
                                              titleImageUrl: _imageUrl,
                                              videoUrl: _videoUrl,
                                              discountStatus: _discount,
                                              controllerName:
                                                  _controllerName.text,
                                              isActive:
                                                  _isActive == "Enable" ? 0 : 1,
                                              type: int.parse(_type.text),
                                              userId: await DbHelper.getId());

                                          if (await ApiService.editCamp(
                                              context, camp)) {
                                            // ignore: use_build_context_synchronously
                                            myToast(context, "Update");
                                            clearTextboxs();
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            myToast(context, "Failed");
                                          }
                                        }
                                      },
                                      child: const Text("Update")),
                                ),
                              ],
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  findId();
                                  Camp camp = Camp(
                                      campId: 19,
                                      campName: _cName.text,
                                      campFee: int.parse(_fee.text),
                                      campBrochure: _brochure.text,
                                      campLocation: _location.text,
                                      campImageGroupId: 1,
                                      campPlanId: int.parse(_planId.text),
                                      campViewDetails: _viewDetails.text,
                                      controllerName: _controllerName.text,
                                      discountStatus: _discount,
                                      isActive: 0,
                                      titleImageUrl: _imageUrl,
                                      type: int.parse(_type.text),
                                      videoUrl: _videoUrl,
                                      userId: showUserDropDown
                                          ? id
                                          : await DbHelper.getId());

                                  // ignore: use_build_context_synchronously
                                  if (await ApiService.addCamp(context, camp)) {
                                    Fluttertoast.showToast(
                                        msg: "Added succesfully",
                                        backgroundColor: mainColor);
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              title: const Text(
                                                  "Camp Add Successful"),
                                              icon: const Icon(
                                                  Icons.check_circle_outline,
                                                  color: mainColor,
                                                  size: 60),
                                              content: const Text(
                                                  "Request for camp booking is approved. Have a taste of wild."),
                                              actions: [
                                                MaterialButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      clearTextboxs();
                                                      nextReplacement(
                                                          context, home);
                                                    },
                                                    color: mainColor,
                                                    minWidth: double.infinity,
                                                    height: 40,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6)),
                                                    child: const Text(
                                                      "THANKS!",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))
                                              ],
                                            ));
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor,
                                  minimumSize: const Size(double.infinity, 50)),
                              child: const Text("Confirm"),
                            )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _generateThumbnail() async {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: _videoUrl,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      maxHeight: 200,
      quality: 100,
    );
    setState(() {
      _thumbnailPath = thumbnailPath;
    });
    print(_thumbnailPath);
  }
}
