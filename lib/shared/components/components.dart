// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, duplicate_ignore, import_of_legacy_library_into_null_safe, constant_identifier_names, curly_braces_in_flow_control_structures

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defultButton(
        {double width = double.infinity,
        bool isUpper = true,
        double raduis = 0.0,
        required VoidCallback? function,
        required String Name}) =>
    Container(
      height: 40.0,
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpper ? Name.toUpperCase() : Name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: Colors.deepPurple,
      ),
    );

Widget defaultformField({
  required String lable,
  required TextEditingController controller,
  FormFieldValidator<String>? validate,
  required TextInputType? type,
  bool isPassword = false,
  ValueChanged<String>? onSubmit,
  IconData? prefix,
  IconData? suffix,
  ValueChanged<String>? onChange,
  VoidCallback? suffixpressed,
  GestureTapCallback? onTap,
  bool? isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      enabled: isClickable,
      validator: validate,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      obscureText: isPassword,
      keyboardType: type,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        suffixIcon: suffix != null
            ? IconButton(icon: Icon(suffix), onPressed: suffixpressed)
            : null,
        labelText: lable,
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.grey)),
      ),
      onTap: onTap,
    );

Widget MyDivider() {
  return Padding(
    padding: const EdgeInsetsDirectional.only(start: 10.0),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    ),
  );
}

void NavigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return widget;
    }),
  );
}

void NavigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
    return widget;
  }), (rout) => false);
}

void ShowToast({required String message, required ToastStates state}) {
  Color? color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red[800];
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }

  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastStates { SUCCESS, ERROR, WARNING }
