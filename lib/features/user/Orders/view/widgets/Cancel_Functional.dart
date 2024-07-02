// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/features/user/Orders/Orders_bloc/Handling_Order/bloc/handling_order_bloc.dart';
import 'package:start/features/user/Orders/Orders_bloc/Order_Details/deatils_for_order_bloc.dart';
import 'package:start/features/user/Orders/view/screen/Orders_screen.dart';
import 'package:start/features/user/Orders/view/widgets/orders_ot_accepted_yet.dart';

class CancelFunctionWidget extends StatelessWidget {
  final int? id;
  final HandlingOrderBloc handlingOrderBloc;
  const CancelFunctionWidget({
    Key? key,
    required this.id,
    required this.handlingOrderBloc,
  }) : super(key: key);

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
                'Are you sure you want to cancel the order ?',
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
                    handlingOrderBloc.add(
                      CancelOrderRequested(
                        id.toString(),
                      ),
                    );
                    // Navigator.of(context)
                    //     .popAndPushNamed(NotAcceptedYetOrders.routeName);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    
                    // Navigator.of(context)
                    //     .pushReplacementNamed(OrdersScreen.routeName);
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
