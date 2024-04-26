import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputFormatter? inputFormatter;
  final Function? validator;
  final String? label;
  final int? minLines;
  final double? borderRadius;
  final int? maxLines;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final String? hintText;
  final TextCapitalization textCapitalization;
  final Function? onTap;
  final Function? onEditingComplete;
  final Function? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLength;
  final double? height;
  final bool? readOnly;
  final FocusNode? focusNode;
  final Color? borderSideColor;
  final bool isPasswordField;
  const TextFieldWidget(
      {Key? key,
        required this.controller,
        required this.textInputType,
        this.obscureText = false,
        this.validator,
        this.minLines,
        this.maxLines,
        this.suffixIcon,
        this.textInputAction,
        this.inputFormatter,
        this.hintText,
        this.onTap,
        this.onChanged,
        this.textCapitalization = TextCapitalization.sentences,
        this.label,
        this.onEditingComplete,
        this.prefixIcon,
        this.borderRadius,
        this.maxLength,
        this.readOnly,
        this.focusNode,
        this.borderSideColor,
        this.isPasswordField = false,
        this.height})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(0.08),
          offset: const Offset(0, 4),
          spreadRadius: 0,
          blurRadius: 24,
        )],
      ),
      child: TextFormField(
        focusNode: widget.focusNode,
        onTap: widget.onTap as void Function()?,
        onChanged: widget.onChanged as void Function(String)?,
        obscureText: widget.isPasswordField,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        //style: TextStyle(fontSize: 12),
        minLines: widget.minLines ?? 1,
        maxLines: widget.maxLines ?? 1,
        controller: widget.controller,
        onEditingComplete: widget.onEditingComplete as void Function()?,
        inputFormatters:
        widget.inputFormatter == null ? [] : [widget.inputFormatter!],
        textCapitalization: widget.textCapitalization,
        validator: widget.validator as String? Function(String?)?,
        cursorColor: Colors.black,
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        style: TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
            errorMaxLines: 4,
            suffixIcon: widget.suffixIcon,
            filled: true,
            fillColor: Colors.white,
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            labelText: widget.label,
            labelStyle: TextStyle(color: Colors.black, fontSize: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 30.0),
              borderSide: widget.borderSideColor != null
                  ? BorderSide(color: widget.borderSideColor ?? Colors.green)
                  : const BorderSide(),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 30.0)),
              borderSide: BorderSide(
                  width: 1.5, color: widget.borderSideColor ?? Colors.green),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 30.0)),
              borderSide:
              const BorderSide(width: 1.5, color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 30.0)),
              borderSide: const BorderSide(width: 1.5, color: Colors.green),
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 30.0)),
                borderSide: const BorderSide(width: 1.5, color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 30.0)),
                borderSide:
                const BorderSide(width: 1.5, color: Colors.redAccent)),
            counterText: ""

          /// Except counter text is added to any field in design
        ),
        maxLength: widget.maxLength,
        readOnly: widget.readOnly ?? false,
      ),
    );
  }
}