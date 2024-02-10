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
  final void Function(double value) onChange;

  const MySleekCircularSlider({
    super.key,
    required this.min,
    required this.max,
    required this.initialValue,
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
  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        customWidths: CustomSliderWidths(
          progressBarWidth: 5,
        ),
        customColors: CustomSliderColors(
          trackColor: widget.trackColor,
          progressBarColors: widget.progressBarColors,
          shadowMaxOpacity: widget.shadowMaxOpacity,
        ),
        infoProperties: InfoProperties(
          topLabelText: widget.topLabelText,
        ),
      ),
      initialValue: _value,
      onChange: (double value) {
        setState(() {
          _value = value;
          widget.onChange(value); // Notify caller of value change
        });
      },
    );
  }
}