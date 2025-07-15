import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/apptheme.dart';

class ReusableDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final Function(T?) onChanged;  var validation;
  final String? hintText;
  String? mapkey;String? mapvalue;
 var listmap;
   ReusableDropdown({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onChanged, this.mapkey="key", this.mapvalue="value",
    this.hintText, required this.listmap, this.validation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isExpanded: true,
      value: selectedItem == "" ? null : selectedItem,
      onChanged: onChanged,
      hint: hintText != null
          ? Text(
              hintText!,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            )
          : null,
      items: listmap!.map<DropdownMenuItem<String>>((list) {
        return DropdownMenuItem<String>(
          value: list[mapvalue].toString(),
          child: Text(list[mapkey].toString()),
        );
      }).toList(),

      validator:validation,
      // items: items.map<DropdownMenuItem<T>>((T value) {
      //   if (value is Map<String, String>) {
      //     return DropdownMenuItem<T>(
      //       value: value,
      //       child: Text(value["key"] ?? "Unknown"), // Display the map value
      //     );
      //   }

      //   return DropdownMenuItem<T>(
      //     value: value,
      //     child: Text(value.toString()),
      //   );
      // }).toList(),
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        isDense: true,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(0, 0, 0, .25),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(0, 0, 0, .25),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder:  OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(0, 0, 0, .25),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
         focusedErrorBorder:  OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(0, 0, 0, .25),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      iconEnabledColor: Colors.black,
      dropdownColor: Colors.white,
    );
  }
}
