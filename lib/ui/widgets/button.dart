import 'package:flutter/material.dart';
import 'package:todo_app/ui/theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const MyButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryClr),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          )),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 25,vertical: 20))
        ),
        child:  Text(
          label,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
    );
  }
}


/*
InkWell(
      borderRadius: BorderRadius.circular(2),
      splashColor: Colors.black45,
      onTap: onTap,
      child: Container(
        width: 100,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryClr,
        ),
        child: Text(
          lable,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
 */