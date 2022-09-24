import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../ui/theme.dart';
import '../../models/task.dart';
import '../size_config.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(this._task, {Key? key}) : super(key: key);

  final Task _task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(12)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(
            SizeConfig.orientation != Orientation.landscape ? 12 : 8),
      ),
      width: SizeConfig.orientation == Orientation.landscape
          ? SizeConfig.screenWidth / 2.08
          : SizeConfig.screenWidth,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(_task.color),
        ),
        child: Row(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_task.title}',
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${_task.startTime} - ${_task.endTime}',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[50],
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${_task.note}',
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                  ),
                ],
              ),
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                _task.isCompleted == 0 ? 'TODO' : 'Completed',
                style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getBGClr(int? color) {
    switch (color) {
      case 0:
        return bluishClr;
      case 1:
        return orangeClr;
      case 2:
        return pinkClr;
      default:
        return bluishClr;
    }
  }
}
