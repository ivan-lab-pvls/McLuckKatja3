import 'package:flutter/material.dart';
import 'package:mcluck_app/theme/colors.dart';

class ButtonSelectionComponent extends StatefulWidget {
  final List<String> buttonValues;
  String value;

  ButtonSelectionComponent({required this.buttonValues, required this.value,});

  @override
  _ButtonSelectionComponentState createState() =>
      _ButtonSelectionComponentState();
}

class _ButtonSelectionComponentState extends State<ButtonSelectionComponent> {
  int _selectedButton = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ...List.generate(widget.buttonValues.length ~/ 2, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildButton(widget.buttonValues[index * 2]),
                SizedBox(width: 8),
                _buildButton(widget.buttonValues[index * 2 + 1]),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildButton(String value) {
    int _index = widget.buttonValues.indexOf(value);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedButton = _index;
            widget.value = widget.buttonValues[_selectedButton];
            print(widget.value);
          });
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
          color: _selectedButton == _index ? AppColors.accentRed : AppColors.grey,
          border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Center(child: Text(value, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.white),)),
        ),
      ),);
  }
}
