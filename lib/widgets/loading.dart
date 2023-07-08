import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _loadingAnimationController;
  late Animation<double> _loadingAnimation;

  @override
  void initState() {
    _loadingAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    var curvedAnimation = CurvedAnimation(
        parent: _loadingAnimationController, curve: Curves.easeIn);
    _loadingAnimation =
        Tween<double>(begin: 0, end: 0.5).animate(curvedAnimation);
    _loadingAnimationController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _loadingAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: FadeTransition(
            opacity: _loadingAnimation,
            child: Container(
                height: 20, width: 5, color: Theme.of(context).primaryColor)));
  }
}
