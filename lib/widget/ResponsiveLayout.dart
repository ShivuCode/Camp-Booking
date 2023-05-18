import 'package:flutter/widgets.dart';

class ResponsiveLayout {
  static const mobileSize = 400;
  static Widget responsiveForm(
      {required List<Widget> children,
      double verticalSpace = 8,
      double horizontalSpace = 8}) {
    return LayoutBuilder(builder: (context, constraints) {
      var count = (constraints.maxWidth ~/ (mobileSize * .8)) == 0
          ? 1
          : (constraints.maxWidth ~/ (mobileSize * .8));
      var mod = children.length % count;
      List<Widget> list =
          List.generate((children.length / count).ceil(), (index) {
        return Padding(
          padding: EdgeInsets.only(top: index == 0 ? 0 : verticalSpace),
          child: Row(
              children: List.generate(count, (index2) {
            var childIndex = (index * count) + index2;
            if (childIndex >= children.length) {
              return const Spacer();
            }
            return Expanded(
                child: Padding(
              padding: EdgeInsets.only(
                  right: index2 == count - 1 ? 0 : horizontalSpace),
              child: children[childIndex],
            ));
          })),
        );
      });

      if (mod > 0) {
        list.add(Padding(
          padding: EdgeInsets.only(top: verticalSpace),
          child: Row(
              children: List.generate(count, (index) {
            if (mod == 0) {
              return const Spacer();
            }
            var widget = children[children.length - mod];
            mod--;
            return const SizedBox();
          })),
        ));
      }
      return Column(children: list);
    });
  }
}
