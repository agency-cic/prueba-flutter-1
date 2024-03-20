import 'package:flutter/material.dart';

class ScreenWrapperResult extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ScreenWrapperResult({
    Key? key,
    required this.headerColor,
    required this.headerWidget,
    required this.bodyWidget,

  });
  final Color headerColor;
  final Widget headerWidget;
  final Widget bodyWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: headerColor,
      width: double.infinity,
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        headerWidget,
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: Container(
              color: Colors.white,
              width: double.infinity,
              child: bodyWidget,
            ),
          ),
        ),
      ]),
    );
  }
}
