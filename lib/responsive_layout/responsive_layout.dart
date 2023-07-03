import 'package:camp_booking/Services/api.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ResponsiveLayout extends StatefulWidget {
  Widget mobileScaffold;
  Widget tabletScaffold;
  Widget laptopScaffold;
  ResponsiveLayout(
      {super.key,
      required this.mobileScaffold,
      required this.tabletScaffold,
      required this.laptopScaffold});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    ApiService.checkToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      if (constraints.maxWidth < 500) {
        return widget.mobileScaffold;
      } else if (constraints.maxWidth < 1100) {
        return widget.tabletScaffold;
      } else {
        return widget.laptopScaffold;
      }
    });
  }
}
