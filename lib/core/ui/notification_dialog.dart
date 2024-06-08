import 'package:flutter/material.dart';

class NotificationDialog extends StatelessWidget {
  final String image;
  final String message;
  final String button;
  final Function() ontap;
  const NotificationDialog({
    Key? key,
    required this.image,
    required this.message,
    required this.button,
    required this.ontap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image),
            Text(message
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(
                      10,
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 143, 201, 101),
                  ),
                ),
                onPressed: ontap,
                child: Text(
                  button,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
