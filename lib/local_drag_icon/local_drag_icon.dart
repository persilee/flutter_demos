import 'package:flutter/material.dart';

class LocalDragIcon extends StatefulWidget {
  const LocalDragIcon({Key? key}) : super(key: key);

  @override
  State<LocalDragIcon> createState() => _LocalDragIconState();
}

class _LocalDragIconState extends State<LocalDragIcon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Drag Icon'),
      ),
      body: Container(),
    );
  }
}
