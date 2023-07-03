import 'dart:io';
import 'package:camp_booking/Models/camp_model.dart';
import 'package:camp_booking/Responsive_Layout/responsiveWidget.dart';
import 'package:camp_booking/Services/api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../Responsive_Layout/responsive_layout.dart';
import '../../constant.dart';
import '../HOME/laptopHomeScreen.dart';
import '../HOME/mobileHomeScreen.dart';
import '../HOME/tabletHomeScreen.dart';

class AddCamp extends StatefulWidget {
  const AddCamp({super.key});

  @override
  State<AddCamp> createState() => _AddCampState();
}

class _AddCampState extends State<AddCamp> {
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _isActive = 'Disable';
  String _discount = '5%OFF';
  String _videoUrl = "";
  String? _thumbnailPath = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height(10),
                    const Text("Add Camp Details,\nWhich Camp you want to add?",
                        style: TextStyle(fontSize: 28)),
                    height(10),
                    ResponsiveForm.responsiveForm(children: [
                      TextFormField(
                        controller: _cName,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Camp Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      TextFormField(
                        controller: _location,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Location',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _fee,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Fee',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          width(10),
                          Expanded(
                            child: TextFormField(
                              controller: _brochure,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter brochure';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Camp Brochure',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                                value: _discount,
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
                                decoration: const InputDecoration(
                                  labelText: 'Discount Status',
                                  border: OutlineInputBorder(),
                                ),
                                items: <String>[
                                  '5%OFF',
                                  '10%OFF',
                                  '15%OFF',
                                  '20%OFF',
                                  '30%OFF',
                                  '45%OFF',
                                  '50%OFF',
                                  '60%OFF',
                                  '70%OFF',
                                  '80%OFF',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
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
                                decoration: const InputDecoration(
                                  labelText: 'isActive',
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
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _planId,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter campPlanId';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Camp Plan Id',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          width(10),
                          Expanded(
                            child: TextFormField(
                              controller: _type,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter camp type';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Type',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _controllerName,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter controller name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Contoller Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      TextFormField(
                        controller: _viewDetails,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter view details';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'View Details',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ]),
                    height(10),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Camp _camp = Camp(
                              campId: 21,
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
                              videoUrl: _videoUrl);

                          if (await ApiService.addCamp(_camp)) {
                            Fluttertoast.showToast(
                                msg: "Added succesfully",
                                backgroundColor: mainColor);
                            // ignore: use_build_context_synchronously
                            showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: const Text("Camp Add Successful"),
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
                                            },
                                            color: mainColor,
                                            minWidth: double.infinity,
                                            height: 40,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6)),
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
