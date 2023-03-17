import 'package:flutter/material.dart';
import 'package:pertamina_test/helper/extension.dart';

class SearchTextField extends StatefulWidget {
  final String? hint, label;
  final void Function(dynamic)? validator, onChanged, onAction;
  final void Function()? onTap;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? readOnly, enabled;
  final int? maxLine, maxLength;
  final IconData? suffix;

  const SearchTextField(
      {Key? key,
      this.hint,
      this.label,
      this.validator,
      this.onChanged,
      this.onAction,
      this.onTap,
      this.inputType,
      this.inputAction,
      this.controller,
      this.focusNode,
      this.readOnly,
      this.enabled,
      this.maxLine,
      this.maxLength,
      this.suffix})
      : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly ?? false,
      controller: widget.controller ?? TextEditingController(),
      onChanged: widget.onChanged ?? (a) {},
      onTap: widget.onTap,
      style: TextStyle(
          color: Colors.grey.shade800, fontSize: context.scaleFont(16)),
      decoration: InputDecoration(
        filled: true,
        enabled: widget.enabled ?? true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 2)),
        hintText: widget.hint ?? '',
        hintStyle: TextStyle(fontSize: context.scaleFont(15)),
        suffixIcon: Icon(
          widget.suffix ?? Icons.search,
          color: Colors.black,
          size: context.scaleFont(28),
        ),
      ),
    );
  }
}
