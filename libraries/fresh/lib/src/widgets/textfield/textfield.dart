import 'package:flutter/material.dart';

class FreshTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final EdgeInsets? padding;
  final int? maxLines;
  final bool readOnly;
  final bool enabled;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;

  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;

  const FreshTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText,
    this.padding,
    this.maxLines = 1,
    this.readOnly = false,
    this.enabled = true,
    this.onTap,
    this.validator,
    this.prefixIcon,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.onFieldSubmitted,
  });

  @override
  State<FreshTextField> createState() => _FreshTextFieldState();
}

class _FreshTextFieldState extends State<FreshTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextFormField(
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        onFieldSubmitted: widget.onFieldSubmitted,
        enableInteractiveSelection: widget.readOnly == true,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        controller: widget.controller,
        obscureText: widget.obscureText ?? false,
        maxLines: widget.maxLines,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          border: const OutlineInputBorder(
            gapPadding: 18.0,
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
