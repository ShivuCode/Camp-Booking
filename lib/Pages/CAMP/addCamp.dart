import 'dart:io';

import 'package:camp_booking/Responsive_Layout/responsiveWidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';

import '../../constant.dart';

class AddCamp extends StatefulWidget {
  const AddCamp({super.key});

  @override
  State<AddCamp> createState() => _AddCampState();
}

class _AddCampState extends State<AddCamp> {
  TextEditingController _cName = TextEditingController(),
      _location = TextEditingController(),
      _imageUrl = TextEditingController(),
      _fee = TextEditingController(),
      _isActive = TextEditingController(),
      _videoUrl = TextEditingController(),
      _discount = TextEditingController();
  String filePath = '';
  GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Form(
              child: Column(children: [
                height(10),
                const Text("Add Camp Details,\nWhich Camp you want to add?",
                    style: TextStyle(fontSize: 28)),
                height(10),
                ResponsiveForm.responsiveForm(children: [
                  TextFormField(
                    controller: _cName,
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
                  TextFormField(
                    controller: _fee,
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
                  Row(
                    children: [
                      const Text("Select Image: "),
                      Expanded(
                          child: Row(
                        children: [
                          Image.file(
                            width: 200,
                            height: 200,
                            File(filePath),
                            fit: BoxFit.contain,
                          ),
                          IconButton(
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();
                                setState(() {
                                  filePath = result!.paths.first!;
                                });
                              },
                              icon: const Icon(Icons.file_open),
                              splashRadius: 20,
                              splashColor: mainColor.withOpacity(0.3))
                        ],
                      ))
                    ],
                  )
                ])
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
