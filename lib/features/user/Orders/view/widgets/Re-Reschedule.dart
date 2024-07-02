import 'package:flutter/material.dart';
import 'package:start/features/user/Orders/view/widgets/Current_Order_Details.dart';
import 'package:start/features/user/Orders/view/widgets/orders_ot_accepted_yet.dart';

class ReScheduleWidget extends StatelessWidget {
  const ReScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Are you sure you want to Re-Schedule ?',
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 143, 201, 101),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .popAndPushNamed(NotAcceptedYetOrders.routeName);
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
