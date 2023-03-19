import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:test_chomchob_final/alert.dart';

import 'models.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  List<Box> items = [];
  bool isLastitem = false;
  List lastiem = [];
  bool isFinish = false;
  Duration duration = Duration();
  math.Random random = new math.Random();
  int time = 0;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 6; i++) {
      items.add(Box(index: i, indexcolor: random.nextInt(10)));
      _key.currentState
          ?.insertItem(items.length, duration: const Duration(seconds: 1));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffD8D8D8),
        bottomNavigationBar: _bottombar(context),
        body: _buildbody(context));
  }

  Widget _buildbody(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    const String imgPath = 'assets/images/';
    final bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return landscape
        ? Container()
        : isFinish
            ? Center(
                child: Container(
                  width: width * 0.80,
                  height: height * 0.25,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Total Time ',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          '${time}s',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        )
                      ]),
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(vertical: height * 0.03),
                child:
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  SizedBox(
                    width: width * 0.2,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        child: SvgPicture.asset(
                          '${imgPath}cursor_left.svg',
                          width: 30,
                          height: 30,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: isLastitem ? height * 0.079 : height * 0.02,
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      child: _containeritem(context),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        child: SvgPicture.asset(
                          '${imgPath}cursor_right.svg',
                          width: 30,
                          height: 30,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: isLastitem ? height * 0.079 : height * 0.02,
                      )
                    ],
                  ),
                  SizedBox(
                    width: width * 0.2,
                  ),
                ]),
              );
  }

  Widget _containeritem(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedList(
          key: _key,
          initialItemCount: items.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index, animation) {
            Box item = items[index];
            return SizeTransition(
                key: UniqueKey(),
                sizeFactor: animation,
                child: Boxitem(
                  index: index,
                  indexbox: item.indexcolor,
                ));
          },
        )
      ],
    );
  }

  Widget _bottombar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.15,
      color: Colors.white,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        InkWell(
          excludeFromSemantics: true,
          onTap: () {
            Showalert(context);
          },
          onLongPress: () {
            Box itemindex = items[items.length - 1];
            if (itemindex.index == 0) {
              Showalertlastitem(context);
              lastiem.add(1);
              Future.delayed(
                const Duration(milliseconds: 800),
                () {
                  lastiem.clear();
                },
              );
              if (lastiem.length == 2) {
                items.removeAt(items.length - 1);
                setState(() {
                  timer?.cancel();
                });
                setState(() {
                  isFinish = true;
                });
                _key.currentState!.removeItem(items.length,
                    (context, animation) {
                  return SizeTransition(
                      key: UniqueKey(),
                      sizeFactor: animation,
                      child: Boxitem());
                }, duration: const Duration(milliseconds: 500));
              }
            }
            if (itemindex.indexcolor % 2 != 0 && itemindex.index != 0) {
              items.removeAt(items.length - 1);
              if (items.length == 5) {
                timer = Timer.periodic(Duration(seconds: 1), (timer) {
                  setState(() {
                    time++;
                    if (items.length == 0) {
                      timer.cancel();
                    }
                  });
                });
              }
              if (items.length == 1) {
                Future.delayed(
                  const Duration(milliseconds: 350),
                  () {
                    setState(() {
                      isLastitem = true;
                    });
                  },
                );
              }
              _key.currentState!.removeItem(items.length, (context, animation) {
                return SizeTransition(
                    key: UniqueKey(), sizeFactor: animation, child: Boxitem());
              }, duration: const Duration(milliseconds: 500));
            } else {
              return;
            }
          },
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xffF9DFFF),
                border: Border.all(width: 1, color: const Color(0xff707070))),
          ),
        ),
        SizedBox(
          width: width * 0.15,
        ),
        InkWell(
          onTap: () {
            Showalert(context);
          },
          onLongPress: () {
            Box itemindex = items[items.length - 1];
            if (itemindex.index == 0) {
              Showalertlastitem(context);
              lastiem.add(2);
              Future.delayed(
                const Duration(milliseconds: 800),
                () {
                  lastiem.clear();
                },
              );
              if (lastiem.length == 2) {
                items.removeAt(items.length - 1);
                setState(() {
                  timer?.cancel();
                });
                setState(() {
                  isFinish = true;
                });
                _key.currentState!.removeItem(items.length,
                    (context, animation) {
                  return SizeTransition(
                      key: UniqueKey(),
                      sizeFactor: animation,
                      child: Boxitem());
                }, duration: const Duration(milliseconds: 500));
              }
            }
            if (itemindex.indexcolor % 2 == 0 && itemindex.index != 0) {
              items.removeAt(items.length - 1);
              if (items.length == 5) {
                timer = Timer.periodic(Duration(seconds: 1), (timer) {
                  setState(() {
                    time++;
                    if (items.length == 0) {
                      timer.cancel();
                    }
                  });
                });
              }
              if (items.length == 1) {
                Future.delayed(
                  const Duration(milliseconds: 350),
                  () {
                    setState(() {
                      isLastitem = true;
                    });
                  },
                );
              }
              _key.currentState!.removeItem(items.length, (context, animation) {
                return SizeTransition(
                    key: UniqueKey(), sizeFactor: animation, child: Boxitem());
              }, duration: const Duration(milliseconds: 500));
            } else {
              return;
            }
          },
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xff90E5FF),
                border: Border.all(width: 1, color: const Color(0xff707070))),
          ),
        ),
      ]),
    );
  }
}

class Boxitem extends StatelessWidget {
  Boxitem({Key? key, this.index, this.indexbox = 0});
  int? index;
  int indexbox;

  @override
  Widget build(BuildContext context) {
    print(indexbox);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return index == 0
        ? Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: height * 0.03),
              child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationZ(
                    math.pi / 4,
                  ),
                  child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xffD27AFF),
                        border: Border.all(
                            width: 1, color: const Color(0xffF9DFFF)),
                      ))),
            ),
          )
        : Center(
            child: Container(
              margin: const EdgeInsets.all(2),
              width: width * 0.35,
              height: height * 0.08,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: const Color(0xff707070),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: indexbox % 2 == 0
                      ? const Color(0xff90E5FF)
                      : const Color(0xffF9DFFF)),
            ),
          );
  }
}
