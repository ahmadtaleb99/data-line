import 'package:flutter/material.dart';

class LoadingOverlay {
  OverlayEntry ? _overlay;

  void show(BuildContext context, String msg)
  {
    if (_overlay == null) {
      _overlay = OverlayEntry(
        // replace with your own layout
        builder: (context) => ColoredBox(
          color: Color(0x80000000),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),

                ),
                SizedBox(height: 15,),
                DefaultTextStyle(
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                  child: Text(msg)
                ),

              ],
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