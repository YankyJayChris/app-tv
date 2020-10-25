import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPhoneFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final String initialValue;

  MyPhoneFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initialValue,
        // autofocus: true,
         maxLength: 10,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: validator,
        onSaved: onSaved,
        keyboardType: TextInputType.number,
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      ),
    );
  }
}
