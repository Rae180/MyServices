// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/features/user/Orders/Orders_bloc/Handling_Order/bloc/handling_order_bloc.dart';
import 'package:start/features/user/Orders/Orders_bloc/Order_Details/deatils_for_order_bloc.dart';
import 'package:start/features/user/Orders/model/Details_For_Order.dart';
import 'package:start/features/user/Orders/view/widgets/Current_Order_Details.dart';

class OrdersNotAcceptedYetTile extends StatelessWidget {
  final int? numberOfOrder;
  final String? serviceName;
  final String? dateTime;

  const OrdersNotAcceptedYetTile(
      {super.key,
      required this.numberOfOrder,
      required this.serviceName,
      required this.dateTime});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Number of order : $numberOfOrder'),
                  Text('Service Name : $serviceName',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Date Time : $dateTime'),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              final handlingOrderbloc =
                  BlocProvider.of<HandlingOrderBloc>(context);
              showDialog(
                  context: context,
                  builder: (context) {
                    return CurrentOrderDetailsWidget(
                      handlingOrderBloc: handlingOrderbloc,
                      id: numberOfOrder,
                    );
                  });
            },
            icon: const Icon(
              Icons.access_alarms_outlined,
              color: Color.fromARGB(255, 143, 201, 101),
            ),
          ),
        ],
      ),
    );
  }
}
