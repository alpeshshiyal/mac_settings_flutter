import 'package:flutter/material.dart';
import 'loading_widget.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.isLoading = false,
      this.onTap,
      this.width,
      required this.title,
      this.margin,
      this.backColor,
      this.textColor,
      this.height,
      this.titleStyle,
      this.buttonBorderColor});
  final bool isLoading;
  final GestureTapCallback? onTap;
  final double? width;
  final double? height;
  final String title;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? margin;
  final Color? backColor;
  final Color? textColor;
  final Color? buttonBorderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: isLoading
            ? const LoadingWidget(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              )
            : Container(
                height: height ?? 50,
                margin: margin ??
                    const EdgeInsets.only(right: 15, top: 15, bottom: 30, left: 15),
                width: width ?? double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            backColor ?? Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            side: BorderSide(
                                width: 0.6,
                                color:
                                    buttonBorderColor ?? Colors.transparent))),
                    onPressed: () {
                      if (onTap != null) {
                        onTap!();
                      }
                    },
                    child: FittedBox(
                      child: Text(
                        title,
                        style: titleStyle ??
                            Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: textColor ?? Colors.white),
                      ),
                    )),
              ),
      ),
    );
  }
}
