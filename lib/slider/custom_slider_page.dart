import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/slider/slider_data.dart';

import 'custom_slider.dart';

class CustomSliderPage extends StatefulWidget {
  const CustomSliderPage({Key? key}) : super(key: key);

  @override
  State<CustomSliderPage> createState() => _CustomSliderPageState();
}

class _CustomSliderPageState extends State<CustomSliderPage> {
  final List<SliderData> _values = [
    SliderData(value: 1, tenor: '2.25% p.a'),
    SliderData(value: 3, tenor: '3.00% p.a'),
    SliderData(value: 6, tenor: '4.00% p.a'),
    SliderData(value: 9, tenor: '5.00% p.a'),
    SliderData(value: 18, tenor: '5.50% p.a'),
    SliderData(value: 24, tenor: '5.75% p.a'),
    SliderData(value: 36, tenor: '6.00% p.a'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider'),
      ),
      body: _myBody(),
    );
  }

  _myBody() {
    return Center(
      child: CustomSlider(
        sliderData: _values,
        progressChanged: (val) {
          if (kDebugMode) {
            print(val);
          }
        },
      ),
    );
  }
}
