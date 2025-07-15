import 'package:flutter/material.dart';

import '../theme/apptheme.dart';

class search_textbox extends StatelessWidget {
  final String hintText;

  var iconSuf;
  var iconPref;
  var onTap;
  bool autofocus;
  var focus;
  var onTapText;
  bool readOnly;
  final Function(String) onChanged;
    final Function(String) onsubmit;
  final TextEditingController? textEditingController;

  search_textbox(
      {super.key,
      this.onTap,
      required this.onsubmit,
      this.onTapText,
      this.focus,
      this.readOnly = false,
      this.autofocus = false,
      required this.hintText,
      this.iconPref,
      this.iconSuf,
      this.textEditingController,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onTap: onTapText, focusNode: focus,
      textInputAction: TextInputAction.search,
      readOnly: readOnly,
      //   if (_serach.text != "") {
      //     Get.to(
      //       SearchDetail(
      //         searchText: _serach.text,
      //       ),
      //       arguments: [_serach.text],
      //       fullscreenDialog: true,
      //       transition: Transition.fadeIn,
      //       duration: const Duration(milliseconds: 200),
      //       curve: Curves.easeInBack,
      //     );
      //   }
      // },

      autofocus: autofocus,
      cursorColor: AppTheme.lightPrimaryColor,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
        fontSize: 14,
      ),
      onSubmitted: onsubmit,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: iconPref,
        contentPadding: EdgeInsets.all(8),
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).hoverColor,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).hoverColor,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Theme.of(context).hoverColor,
            width: 0,
          ),
        ),
        hintStyle:
            Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13),
        suffixIcon: InkWell(
          onTap: onTap,
          child: iconSuf,
        ),
        prefixIconColor: Theme.of(context).textTheme.displaySmall!.color,
        suffixIconColor: Theme.of(context).textTheme.displaySmall!.color,
        filled: true,
        fillColor: Colors.white,
        //  fillColor: Theme.of(context).hoverColor,
        hintText: hintText,
      ),
    );
  }
}
