import 'package:flutter/material.dart';
import 'package:fooddelivery/support_files/constants.dart';

class UnderlinedTextField extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final TextEditingController editingController;
  final TextInputType keyBoardType;
  final bool isSecureText;
  final TextInputAction inputAction;
  final FocusNode focusNode;
  final Function onSubmitted;

  UnderlinedTextField(
      {this.hintText,
      this.onChanged,
      this.editingController,
      this.keyBoardType,
      this.isSecureText,
      this.inputAction,
      this.focusNode,
      this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.bottom,
      maxLines: 1,
      controller: editingController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:
            kBodyLabelTextStyle.copyWith(color: Colors.grey, fontSize: 20.0),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      onChanged: onChanged,
      style: kBodyLabelTextStyle.copyWith(
        color: Colors.black,
        fontSize: 20.0,
      ),
      keyboardType: keyBoardType,
      obscureText: isSecureText,
      textInputAction: inputAction,
      focusNode: focusNode,
      onSubmitted: onSubmitted,
    );
  }
}
