import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ScreenWrapper({
    Key? key,
    required this.headerColor,
    required this.headerWidget,
    required this.bodyWidget,
    required this.today,
    required this.nit,
    required this.name,
  });
  final Color headerColor;
  final Widget headerWidget;
  final Widget bodyWidget;
  final String today;
  final String nit;
  final String name;
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
