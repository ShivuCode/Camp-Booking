import 'dart:io';
import 'dart:async';
import 'package:camp_booking/constant.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String> downloadPdf(context, filename, pdf) async {
  final androidInfo = await DeviceInfoPlugin().androidInfo;
  late final Map<Permission, PermissionStatus> status;

  if (androidInfo.version.sdkInt <= 32) {
    status = await [Permission.storage].request();
  } else {
    status = await [
      Permission.photos,
      Permission.manageExternalStorage,
    ].request();
  }

  var allAccepted =
      status.values.every((stu) => stu == PermissionStatus.granted);

  if (allAccepted) {
    final directory = Directory("/storage/emulated/0/Download");
    String path = '${directory.path}/$filename.pdf';

    if (await File(path).exists()) {
      // Use Completer to wait for the user's choice
      Completer<String> completer = Completer<String>();

      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                FontAwesomeIcons.warning,
                color: Colors.red,
                size: 30,
              ),
              const Text(
                "Warning",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 10),
              const Text(
                "Do you want to overwrite the file if it already exists?",
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          int counter = 1;
                          do {
                            final file = File(
                                '${directory.path}/$filename($counter).pdf');
                            if (!await file.exists()) {
                              await file.writeAsBytes(await pdf.save());
                              completer.complete(file.path);
                              break;
                            }
                            counter++;
                            print(counter);
                          } while (true);
                        },
                        child: const Text("No"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          final file = File(path);
                          await file.writeAsBytes(await pdf.save());
                          completer.complete(file.path);
                        },
                        child: const Text("Yes"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      return completer.future;
    } else {
      final file = File(path);
      await file.writeAsBytes(await pdf.save());
      return file.path;
    }
  } else {
    return '';
  }
}
