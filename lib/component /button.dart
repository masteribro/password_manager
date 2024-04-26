import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final bool isLoading;
  final String label;
  final Function() submit;
  final Color color;
  final bool disabled;
  final List<Color>? gradientColors;
  final Color? labelColor;
  final double? width;

  const SubmitButton({
    Key? key,
    required this.isLoading,
    required this.label,
    required this.submit,
    required this.color,
    this.gradientColors,
    this.disabled = false,
    this.labelColor,
    this.width,
  }) : super(key: key);

  Color? btnColor() {
    if (disabled) {
      return const Color(0xFF6B6B6B);
    } else {
      if (gradientColors != null) return null;
      if (isLoading) {
        return color.withOpacity(0.7);
      } else {
        return color;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(35),
      onTap: disabled || isLoading ? () {} : submit,
      child: Container(
        height: 65,
        width: width ?? MediaQuery.of(context).size.width / 1.1,
        decoration: BoxDecoration(
          border: Border.all(
            //TODO: make color transparent
            color: Colors.white,
            width: 2.0,
          ),
          color: btnColor(),
          borderRadius: BorderRadius.circular(35),
          gradient: gradientColors != null && disabled == false
              ? LinearGradient(
            colors: gradientColors!,
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          )
              : null,
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
            height: 20,
            width: 20,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
            ),
          )
              : Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: labelColor ?? Colors.white,
                fontWeight: FontWeight.bold),
            // style: TextStyle(
            //     color: labelColor ?? Colors.white,
            //     fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
