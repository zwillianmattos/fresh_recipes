import 'package:flutter/material.dart';

class RoundInforCard extends StatefulWidget {
  final String text;
  final String desc;
  final TextStyle? textStyle;

  const RoundInforCard({super.key, required this.text, this.textStyle, required this.desc});

  @override
  State<RoundInforCard> createState() => _RoundInforCardState();
}

class _RoundInforCardState extends State<RoundInforCard> {
  final TextStyle _textStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2.0),
        borderRadius: const BorderRadius.all(
          Radius.circular(200),
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: widget.textStyle != null
                  ? widget.textStyle!.copyWith(
                      fontSize: _textStyle.fontSize,
                      fontWeight: _textStyle.fontWeight,
                    )
                  : _textStyle,
            ),
            Text(
              widget.desc,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
