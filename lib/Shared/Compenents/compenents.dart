import 'package:flutter/material.dart';

void navigateTo({required context, required Widget widget}) {
  
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ));
  
}

void replaceWith({required context, required Widget widget}) {
  
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        (route) => false);
  
}

typedef Valid = String? Function(String? value);
Widget defaultFromFiled({
  required TextEditingController control,
  TextInputType? type,
  Function? Function(String? value)? submit,
  Function? Function(String? value)? change,
  Function? Function()? ontap,
  Valid? valid,
  Icon? prefix,
  IconButton? suffix,
  required String lable,
  bool secure = false,
  GlobalKey<FormState>? key,
  bool isEnable = true,
}) =>
    TextFormField(
      key: key,
      onChanged: change,
      onFieldSubmitted: submit,
      validator: valid,
      onTap: ontap,
      controller: control,
      keyboardType: type,
      obscureText: secure,
      enabled: isEnable,
      decoration: InputDecoration(
        prefixIcon: prefix,
        suffixIcon: suffix,
        labelText: lable,
        border: const OutlineInputBorder(),
      ),
    );

Widget defaultTextButton({required Function function, required String text}) {
  return TextButton(onPressed: function(), child: Text(text));
}

Widget defaultButton({
  double width = double.infinity,
  required VoidCallback function,
  Color color = Colors.teal,
  required String text,
  bool isUpperCase = true,
}) {
  return Container(
    width: width,
    color: color,
    child: MaterialButton(
      onPressed: function,
      child: Text(text),
    ),
  );
}
