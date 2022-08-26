import 'dart:developer';

import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class BottomPanel extends StatelessWidget {
  const BottomPanel({
    Key? key,
    required this.screenshotController,
  }) : super(key: key);

  final ScreenshotController screenshotController;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height / 4;
    return Align(
        // left: 0,
        // bottom: 0,
        alignment: Alignment.bottomLeft,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
                width: screenSize.width * 0.3,
                height: height,
                child: OutlinedButton(
                  onPressed: () {
                    screenshotController
                        .capture(delay: const Duration(milliseconds: 10))
                        .then((capturedImage) async {
                      Share.file('내 OPI! 너의 OPI는? ', 'Win.jpg', capturedImage!,
                          'image/jpg',
                          text: '내 OPI! 너의 OPI는? ');
                      // Share.files(
                      //   'esys images',
                      //   {
                      //       'esys.png': capturedImage.,
                      //       'bluedan.png': capturedImage.buffer.asUint8List(),
                      //       'addresses.csv': bytes3.buffer.asUint8List(),
                      //   },
                      //   '*/*',
                      //   text: 'My optional text.');
                      // ShowCapturedWidget(context, capturedImage!);
                    }).catchError((onError) {
                      log(onError);
                    });
                  },
                  // ignore: prefer_const_constructors
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.share,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(height: 20),
                      Text("공유하기",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ],
                  ),
                )),
            Container(
              width: screenSize.width * 0.7,
              height: height,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(color: Colors.black),
              child: Padding(
                padding: const EdgeInsets.all(8.0), //Color(0xFFD7C8E6)
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFD7C8E6),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    // border: Border.all(
                    //   width: 3,
                    //   color: Colors.green,
                    //   style: BorderStyle.solid,
                    // ),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("OPI 50% 란?",
                          style: TextStyle(color: Colors.black, fontSize: 32)),
                      Text(
                          "Over Powerful Inspiration 50%, \n줄여서 OPI 50%, 번역하면 강력한 영감을 50% 초과하여",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                      SizedBox(
                        height: 15,
                      ),
                      Text("made by 박건, 김선호",
                          style: TextStyle(fontSize: 12, color: Colors.black)),
                    ],
                  )),
                ),
              ),
            )
          ],
        ));
  }
}
