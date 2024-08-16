import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:start/features/user/home/view/widgets/Cancel_Function_widget_for_close_orders.dart';
import 'package:start/features/user/home/view/widgets/Re-Scedule_Function_widget_for_close_orders.dart';

class CloseOrderWidget extends StatelessWidget {
  const CloseOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      elevation: 12,
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Text(
            'ID\'s Number : 1',
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                30,
              ),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  'assets/waiting.jpg',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Descreption :',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4,
            ),
            child: Text(
              'The ceiling need to be fixed, so can you see it ???',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
          Text(
            ' Adress :',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4,
            ),
            child: Text(
              'Damascus, Syria',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
          Text(
            'Date & Time :',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4,
            ),
            child: Text(
              '4th of May, 2024 ; 12:14 PM ',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
          Text(
            'Payment :',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4,
            ),
            child: Text(
              'Wallet',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
          Text(
            'Provider :',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4,
            ),
            child: Text(
              'Ali Hassn',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
          Text(
            'Phone Number\'s Provider :',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4,
            ),
            child: Text(
              '09923232322',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
          Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 143, 201, 101),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ReScheduleWidgetForClosedOrders();
                      });
                },
                child: Text(
                  'Re-Scheudeule',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CancelFunctionWidgetForClosedOrders();
                      });
                },
                child: Text(
                  'Cancel',
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
    );
  }
}
