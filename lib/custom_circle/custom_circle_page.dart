import 'package:flutter/material.dart';

import 'custom_circle_painter.dart';

class CustomCirclePage extends StatefulWidget {
  const CustomCirclePage({Key? key}) : super(key: key);

  @override
  State<CustomCirclePage> createState() => _CustomCirclePageState();
}

class _CustomCirclePageState extends State<CustomCirclePage>
    with TickerProviderStateMixin {
  late AnimationController controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 600))
    ..forward();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom circle'),
      ),
      body: _myBody(),
    );
  }

  _myBody() {
    return Center(
      child: Column(
        children: [
          CustomPaint(
            painter: CustomCirclePainter(
              percentage: 66,
              controller: controller,
            ),
            size: const Size(260.0, 260.0),
          ),
          CustomPaint(
            painter: DoubleCirclePainter(
              percentage: 66,
              controller: controller,
            ),
            size: const Size(260.0, 260.0),
          ),
        ],
      ),
    );
  }
}
