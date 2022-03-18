// import 'dart:ui';

// import 'package:flutter/material.dart';

// class AnimatedCheck extends StatefulWidget {
//   final Animation<double> progress;
//   final double size;
//   final Color? color;
//   final double? strokeWidth;

//   const AnimatedCheck({
//     required this.progress,
//     required this.size,
//     this.color,
//     this.strokeWidth,
//   });

//   @override
//   State<StatefulWidget> createState() => AnimatedCheckState();
// }

// class AnimatedCheckState extends State<AnimatedCheck>
//     with SingleTickerProviderStateMixin {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);

//     return CustomPaint(
//       foregroundPainter: AnimatedPathPainter(
//         widget.progress,
//         widget.color ?? theme.primaryColor,
//         widget.strokeWidth,
//       ),
//       child: SizedBox(
//         width: widget.size,
//         height: widget.size,
//       ),
//     );
//   }
// }

// class AnimatedPathPainter extends CustomPainter {
//   final Animation<double> _animation;

//   final Color _color;

//   final double? strokeWidth;

//   AnimatedPathPainter(this._animation, this._color, this.strokeWidth)
//       : super(repaint: _animation);

//   Path _createAnyPath(Size size) {
//     return Path()
//       ..moveTo(0.27083 * size.width, 0.54167 * size.height)
//       ..lineTo(0.41667 * size.width, 0.68750 * size.height)
//       ..lineTo(0.75000 * size.width, 0.35417 * size.height);
//   }

//   Path createAnimatedPath(Path originalPath, double animationPercent) {
//     final totalLength = originalPath
//         .computeMetrics()
//         .fold(0.0, (double prev, PathMetric metric) => prev + metric.length);

//     final currentLength = totalLength * animationPercent;

//     return extractPathUntilLength(originalPath, currentLength);
//   }

//   Path extractPathUntilLength(Path originalPath, double length) {
//     var currentLength = 0.0;

//     final path = Path();

//     final metricsIterator = originalPath.computeMetrics().iterator;

//     while (metricsIterator.moveNext()) {
//       final metric = metricsIterator.current;

//       final nextLength = currentLength + metric.length;

//       final isLastSegment = nextLength > length;
//       if (isLastSegment) {
//         final remainingLength = length - currentLength;
//         final pathSegment = metric.extractPath(0.0, remainingLength);

//         path.addPath(pathSegment, Offset.zero);
//         break;
//       } else {
//         final pathSegment = metric.extractPath(0.0, metric.length);
//         path.addPath(pathSegment, Offset.zero);
//       }

//       currentLength = nextLength;
//     }

//     return path;
//   }

//   @override
//   void paint(Canvas canvas, Size size) {
//     final animationPercent = _animation.value;

//     final path = createAnimatedPath(_createAnyPath(size), animationPercent);

//     final Paint paint = Paint();
//     paint.color = _color;
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = strokeWidth ?? size.width * 0.06;

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }

import 'package:flutter/material.dart';

class AnimatedCheck extends StatefulWidget {
  @override
  _AnimatedCheckState createState() => _AnimatedCheckState();
}

class _AnimatedCheckState extends State<AnimatedCheck>
    with TickerProviderStateMixin {
  late AnimationController scaleController = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  );
  late Animation<double> scaleAnimation =
      CurvedAnimation(parent: scaleController, curve: Curves.elasticOut);
  late AnimationController checkController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late Animation<double> checkAnimation =
      CurvedAnimation(parent: checkController, curve: Curves.linear);

  @override
  void initState() {
    super.initState();
    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkController.forward();
      }
    });
    scaleController.forward();
  }

  @override
  void dispose() {
    scaleController.dispose();
    checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double circleSize = 70;
    const double iconSize = 54;

    return ScaleTransition(
      scale: scaleAnimation,
      child: Container(
        height: circleSize,
        width: circleSize,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: SizeTransition(
          sizeFactor: checkAnimation,
          axis: Axis.horizontal,
          axisAlignment: -1,
          child: Center(
            child: Icon(Icons.check, color: Colors.white, size: iconSize),
          ),
        ),
      ),
    );
  }
}
