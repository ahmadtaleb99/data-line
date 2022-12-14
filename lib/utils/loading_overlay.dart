import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class LoadingService {
  LoadingService._privateConstructor();

  static final LoadingService _instance = LoadingService._privateConstructor();

  static LoadingService get instance => _instance;
  OverlayEntry ? _overlay;
  void show(BuildContext context, {String ? msg})
  {

    double width = MediaQuery.of(context).size.width;

    if (_overlay == null) {
      _overlay = OverlayEntry(
        // replace with your own layout
        builder: (context) => ColoredBox(
          color: const Color(0x80000000),
          child: Center(
            child: SizedBox(
              width: width / 2,
              child: Material(

                borderRadius: BorderRadius.circular(10),
                clipBehavior: Clip.antiAlias,
                color: Colors.white.withOpacity(0.9),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        msg ?? 'Please Wait..' ,
                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: CupertinoColors.black,
                          fontWeight: FontWeight.bold,

                        ),

                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      Overlay.of(context)!.insert(_overlay!);
    }
  }

  void hide() {
    if (_overlay != null) {
      _overlay!.remove();
      _overlay = null;
    }
  }
}