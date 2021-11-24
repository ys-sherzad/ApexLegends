// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ScaleAnimation extends HookWidget {
  const ScaleAnimation({
    Key? key,
    required this.child,
    required this.show,
  }) : super(key: key);

  final Widget child;
  final bool show;

  @override
  Widget build(BuildContext context) {
    final _ctrl = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );

    final scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: Curves.fastOutSlowIn,
      ),
    );
    useEffect(() {
      if (show) {
        _ctrl.forward();
      } else {
        _ctrl.reverse();
      }
      // return () => _ctrl.dispose();
    }, [show, _ctrl]);

    return ScaleTransition(
      scale: scaleAnimation,
      child: child,
    );
  }
}
