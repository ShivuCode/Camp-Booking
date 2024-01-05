import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AnimatedText extends StatefulWidget {
  String text;
  AnimatedText({super.key, required this.text});

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation =
        IntTween(begin: 0, end: widget.text.length).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          widget.text.substring(0, _animation.value),
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w400, color: Colors.black87),
        );
      },
    );
  }
}
