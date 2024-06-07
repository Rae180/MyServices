
import 'package:flutter/material.dart';

class Markeri extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.pin_drop_outlined,
          color: Colors.black,
        ),
      ),
    );
  }
}
