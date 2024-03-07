import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MySleekCircularSlider extends StatefulWidget {

  final double min;
  final double max;
  final double initialValue;
  final Color trackColor;
  final List<Color> progressBarColors;
  final double shadowMaxOpacity;
  final String topLabelText;
  final String unit;
  final void Function(double value) onChange;

  const MySleekCircularSlider({
    super.key,
    required this.min,
    required this.max,
    required this.initialValue,
    required this.unit,
    this.trackColor = Colors.grey,
    this.progressBarColors = const [Colors.cyan, Colors.cyan],
    this.shadowMaxOpacity = 50.0,
    this.topLabelText = '',
    required this.onChange,
  });

  @override
  State<MySleekCircularSlider> createState() => _MySleekCircularSliderState();
}

class _MySleekCircularSliderState extends State<MySleekCircularSlider> {
  double _value = 0.0;
  double _min = 0.0;
  double _max = 0.0;
  String _unit = "";
  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
    _min = widget.min;
    _max = widget.max;
    _unit = widget.unit;
  }

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        size: 120,
        customWidths: CustomSliderWidths(
          trackWidth: 5,
          progressBarWidth: 5,
          
        ),
        customColors: CustomSliderColors(
          trackColor: widget.trackColor,
          progressBarColors: widget.progressBarColors,
          hideShadow: true,
          // shadowMaxOpacity: widget.shadowMaxOpacity,
        ),
        infoProperties: InfoProperties(
          topLabelText: widget.topLabelText,
          
          modifier: (double value) {

            final temp = value.toInt();
            return '$temp $_unit';
          },
        ),
      ),
      initialValue: _value,
      min: _min,
      max: _max,
    );
  }
}