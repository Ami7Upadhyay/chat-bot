import 'package:ai_chat_bot/extension/app_extenstion.dart';
import 'package:flutter/material.dart';

import '../config/app_colors.dart';

class TextTypingAnimation extends StatefulWidget {
  final String text;
  final bool isAutoTypingRequired;
  final Function? onTyping;
  final Function? onCompleteTyping;
  const TextTypingAnimation(
      {super.key,
      required this.text,
      this.isAutoTypingRequired = true,
      this.onTyping,
      this.onCompleteTyping});

  @override
  State<TextTypingAnimation> createState() => _TextTypingAnimationState();
}

class _TextTypingAnimationState extends State<TextTypingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _typeAnimation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    var curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _typeAnimation =
        StepTween(begin: 0, end: widget.text.length).animate(curvedAnimation);

    _animationController.forward();
    _typeAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onCompleteTyping?.call();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _typeAnimation,
        builder: (_, __) {
          String currentString = widget.text.substring(0, _typeAnimation.value);
          widget.onTyping?.call();
          return Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 20, 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                color: colorCBCBCB.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('chatbot'.toPng, height: 30),
                8.hPad,
                Flexible(
                  child: Text(
                    widget.isAutoTypingRequired ? currentString : widget.text,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
