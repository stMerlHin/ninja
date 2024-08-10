import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class DraggableWidget extends StatefulWidget {
  const DraggableWidget(
      {Key? key, this.child, this.alignment = Alignment.center})
      : super(key: key);

  final Widget? child;
  final Alignment alignment;
  @override
  State<DraggableWidget> createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _animation;
  Alignment _dragAlignment = Alignment.centerLeft;

  @override
  void initState() {
    super.initState();
    _dragAlignment = widget.alignment;
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _controller.addListener(() {
      // update _dragAlignment when the AnimationController produces a value
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanDown: (details) {
        // update the GestureDetector to manage the animation controller
        _controller.stop();
      },
      onPanUpdate: (details) {
        setState(() {
          _dragAlignment += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          );
        });
      },
      onPanEnd: (details) {
        // update the GestureDetector to manage the animation controller
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },
      child: Align(
        alignment: _dragAlignment,
        child: Container(
          child: widget.child,
        ),
      ),
    );
  }

  /// Calculates and runs a [SpringSimulation].
  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: widget.alignment,
      ),
    );
    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
