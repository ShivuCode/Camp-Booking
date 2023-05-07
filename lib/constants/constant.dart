import 'package:flutter/material.dart';

Widget height(double h) {
  return SizedBox(
    height: h,
  );
}

Widget width(double h) {
  return SizedBox(
    width: h,
  );
}

nextScreen(context, page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
}

nextReplacement(context, page) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
}

dec(String hint) {
  InputDecoration decoration = InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      hoverColor: Colors.white12);
  return decoration;
}

fieldTitle(String title) {
  return Column(
    children: [
      Text(
        title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
      ),
      height(5)
    ],
  );
}

fieldDec(String hint) {
  InputDecoration decoration = InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.white)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.white)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.white)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.white)),
  );
  return decoration;
}
