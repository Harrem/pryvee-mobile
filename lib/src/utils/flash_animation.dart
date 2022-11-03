import 'package:flutter/material.dart';

class FlashAnimation extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool infinite;
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;

  FlashAnimation({this.key, this.child, this.duration = const Duration(milliseconds: 1000), this.delay = const Duration(milliseconds: 0), this.infinite = false, this.controller, this.manualTrigger = false, this.animate = true}) : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _FlashAnimation createState() => _FlashAnimation();
}

class _FlashAnimation extends State<FlashAnimation> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacityOut1;
  Animation<double> opacityIn1;
  Animation<double> opacityOut2;
  Animation<double> opacityIn2;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    opacityOut1 = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.25)));
    opacityIn1 = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: controller, curve: Interval(0.25, 0.5)));
    opacityOut2 = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(parent: controller, curve: Interval(0.5, 0.75)));
    opacityIn2 = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: controller, curve: Interval(0.75, 1)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        (widget.infinite) ? controller.repeat() : controller?.forward();
      });
    }

    if (widget.controller is Function) widget.controller(controller);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) controller?.forward();

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Opacity(
            opacity: (controller.value < 0.25)
                ? opacityOut1.value
                : (controller.value < 0.5)
                    ? opacityIn1.value
                    : (controller.value < 0.75)
                        ? opacityOut2.value
                        : opacityIn2.value,
            child: widget.child,
          );
        });
  }
}
