import 'package:flutter/material.dart';

import '../theme.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hient;
  final TextEditingController? controller;
  final Widget? child;

  const InputField(
      {Key? key,
      required this.title,
      required this.hient,
      this.controller,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 2),
              margin: const EdgeInsets.only(top: 8),
              child: Text(title, style: titleStyle,textAlign: TextAlign.start)),
          TextFormField(
            controller: controller,
            autofocus: false,
            cursorColor: primaryClr,
            readOnly: child != null ? true : false,
            decoration: InputDecoration(
              hintText: hient,
              hintStyle: subTitle,
              suffixIcon: child ?? const SizedBox(width: 5,height: 5,),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                )
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
