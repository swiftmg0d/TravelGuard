import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoadingAnimationWidget.progressiveDots(
          color: Color.fromARGB(255, 21, 57, 55),
          size: 75,
        ),
      ],
    );
  }
}
