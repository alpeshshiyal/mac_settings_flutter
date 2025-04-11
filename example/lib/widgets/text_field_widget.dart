import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController? controller;
  final bool isPass;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final String? labelText;
  final TextStyle? labelStyle;
  final String hintText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final EdgeInsetsGeometry? padding;
  final FocusNode? focusNode;
  final bool noBorder;
  final bool autofocus;
  const TextFieldInput({
    super.key,
    this.controller,
    this.isPass = false,
    required this.hintText,
    this.textInputType = TextInputType.text,
    this.validator,
    this.suffixIcon, this.labelText,
    this.maxLines,
    this.readOnly=false, this.onTap,
    this.onFieldSubmitted, this.prefixIcon,
    this.labelStyle,
    this.onChanged,
    this.padding,
    this.focusNode,
    this.maxLength,
    this.inputFormatters,
    this.noBorder=false,
    this.autofocus=false,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context).copyWith(
          width: 0.6,color:noBorder?Colors.transparent :Theme.of(context).colorScheme.primary),
      borderRadius: BorderRadius.all(Radius.circular(8))
    );

    return Padding(
      padding:padding?? const EdgeInsets.only(bottom: 20,left: 15,right: 15),
      child: Column(
        children: [
          Visibility(
            visible: labelText!=null,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(labelText??"",
                    style:labelStyle??Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 14,color: Colors.black,
                      fontWeight: FontWeight.w500
                  ),
                  ),
                ),
                SizedBox(width: 5,),
                if(validator!=null)
                Text("*",style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.red
                ),),
              ],
            ),
          ),
          TextFormField(
            autofocus: autofocus,
            readOnly: readOnly,
            onTap: onTap,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            controller: controller,
            maxLines: maxLines??1,
            onChanged: onChanged,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            style: TextStyle(color: Colors.white),
            onTapOutside: (p) {
              FocusScope.of(context).requestFocus(FocusNode());
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            decoration: InputDecoration(
                // label:Text(hintText) ,
                hintText: hintText,
                border: inputBorder,
                focusedBorder: inputBorder,
                enabledBorder: inputBorder,
                hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey
                ),
                fillColor: Colors.brown,
                filled: true,
                contentPadding: const EdgeInsets.all(8),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: suffixIcon,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 5),
                  child: prefixIcon,
                ),
              prefixIconConstraints: const BoxConstraints(maxHeight: 30,minHeight: 10),
              suffixIconConstraints: const BoxConstraints(maxHeight: 30,minHeight: 10)
            ),
            keyboardType: textInputType,
            obscureText: isPass,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ],
      ),
    );
  }
}

class CustomTextEditingController extends TextEditingController {
  final Map<String, TextStyle> map;
  final Pattern pattern;

  CustomTextEditingController(this.map)
      : pattern = RegExp(
      map.keys.map((key) {
        return key;
      }).join('|'),
      multiLine: true);

  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
      composing: TextRange.empty,
    );
  }

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, bool? withComposing}) {
    final List<InlineSpan> children = [];
    String? patternMatched;
    String? formatText;
    TextStyle? myStyle;
    text.splitMapJoin(
      pattern,
      onMatch: (Match match) {
        myStyle = map[map.keys.firstWhere(
              (e) {
            bool ret = false;
            RegExp(e).allMatches(text).forEach((element) {
              if (element.group(0) == match[0]) {
                patternMatched = e;
                ret = true;
              }
            });
            return ret;
          },
        )];

        if (patternMatched == r"_(.*?)\_") {
          formatText = match[0]!.replaceAll("_", " ");
        } else if (patternMatched == r'\*(.*?)\*') {
          formatText = match[0]!.replaceAll("*", " ");
        } else if (patternMatched == "~(.*?)~") {
          formatText = match[0]!.replaceAll("~", " ");
        } else if (patternMatched == r'```(.*?)```') {
          formatText = match[0]!.replaceAll("```", "   ");
        } else {
          formatText = match[0];
        }

        children.add(TextSpan(
          text: formatText,
          style: style!.merge(myStyle),
        ));
        return "";
      },
      onNonMatch: (String text) {
        children.add(TextSpan(text: text, style: style));
        return "";
      },
    );

    return TextSpan(style: style, children: children);
  }
}