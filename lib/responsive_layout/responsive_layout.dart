import 'package:flutter/material.dart';
class ResponsiveLayout extends StatelessWidget {
  Widget mobileScaffold;
  Widget tabletScaffold;
  Widget laptopScaffold;
  ResponsiveLayout({super.key,required this.mobileScaffold,required this.tabletScaffold,required this.laptopScaffold});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      if (constraints.maxWidth < 500) {
        return mobileScaffold;
      } else if (constraints.maxWidth < 1100) {
        return tabletScaffold;
      } else {
        return laptopScaffold;
      }
    });
  }
}
