import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/theme.dart';

class NotificationScreen extends StatefulWidget {
  final String? payLode;

  const NotificationScreen({Key? key, required this.payLode}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        elevation: 0.0,
        title: const Text('Notifications'),
        titleTextStyle: const TextStyle(
          color: Colors.white ,
          fontSize: 24,
          fontWeight: FontWeight.w300,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
          color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            Text(
              'Hello, Ibrahim',
              style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'you have a new reminder',
              style: TextStyle(
                color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr,
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30 , vertical: 10),
          margin: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
          decoration: BoxDecoration(
            color: primaryClr,
            borderRadius: BorderRadius.circular(30),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.text_format,
                      size: 35,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 200,
                      child: const Text(
                        'Title',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.payLode!.split('|')[0],
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.description,
                      color: Colors.white,
                      size: 35,

                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 200,
                      child: const Text(
                        'Description',
                        style:
                            TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.payLode!.split('|')[1],
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 200,
                      child: const Text(
                        'Date',
                        style:
                        TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.payLode!.split('|')[2],
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),

              ],
            ),
          ),
        )),
      ])),
    );
  }
}
