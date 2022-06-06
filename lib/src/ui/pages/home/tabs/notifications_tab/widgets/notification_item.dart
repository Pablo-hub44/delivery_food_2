// ignore_for_file: prefer_const_constructors

import 'package:delivery_food/src/data/modelos/notification.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationItem extends StatelessWidget {
  // propiedaes
  final AppNotification notification; //tipo de dato de nuestro modelo

  // constructor
  const NotificationItem({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {},
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // widget q crea un circulo q representa al usuario
            CircleAvatar(
              child: Text("AD"),
            ),
            SizedBox(width: 10),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // <->
              children: [
                Text(
                  notification.description,
                  style: FontStyles.normal.copyWith(
                    color: Colors.black87,
                  ),
                ),
                Text(
                  timeago.format(
                    notification.createdAt,
                  ),
                  style: FontStyles.normal.copyWith(color: Colors.black54),
                ), //ocupando dependencia externa, pa darle formato
              ],
            )),
          ],
        ),
      ),
    );
  }
}
