import 'dart:async';

import 'package:flutter/material.dart';

Future<dynamic> Showalert(
  BuildContext context,
) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  Future.delayed(
    const Duration(seconds: 1),
    () {
      Navigator.of(context).pop(true);
    },
  );

  return showDialog(
      barrierColor: Colors.transparent.withOpacity(0.1),
      context: context,
      builder: (_) => AlertDialog(
            insetPadding: EdgeInsets.only(top: height * 0.2),
            alignment: Alignment.topCenter,
            backgroundColor: Colors.transparent.withOpacity(0.2),
            shape: const RoundedRectangleBorder(),
            content: Builder(
              builder: (context) {
                return SizedBox(
                  height: height * 0.15,
                  width: width * 0.7,
                  child: SizedBox(
                    width: width * 0.4,
                    height: height * 0.14,
                    child: Column(children: const [
                      Text(
                        'กดปุ่มสีที่ตรงกันค้างไว้ 2 วินาที เพื่อทำลาย Block',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )
                    ]),
                  ),
                );
              },
            ),
          ));
}

Future<dynamic> Showalertlastitem(
  BuildContext context,
) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  Future.delayed(
    const Duration(seconds: 1),
    () {
      Navigator.of(context).pop(true);
    },
  );

  return showDialog(
      barrierColor: Colors.transparent.withOpacity(0.1),
      context: context,
      builder: (_) => AlertDialog(
            insetPadding: EdgeInsets.only(top: height * 0.2),
            alignment: Alignment.topCenter,
            backgroundColor: Colors.transparent.withOpacity(0.2),
            shape: const RoundedRectangleBorder(),
            content: Builder(
              builder: (context) {
                return SizedBox(
                  height: height * 0.15,
                  width: width * 0.7,
                  child: SizedBox(
                    width: width * 0.4,
                    height: height * 0.14,
                    child: Column(children: const [
                      Text(
                        'กรุณากดสองปุ่มเพื่อทำลาย Block',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )
                    ]),
                  ),
                );
              },
            ),
          ));
}
