// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class OrdersNotAcceptedYetTile extends StatefulWidget {
  @override
  State<OrdersNotAcceptedYetTile> createState() => _OrdersNotAcceptedYetTileState();
}

class _OrdersNotAcceptedYetTileState extends State<OrdersNotAcceptedYetTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Number of order : 1'),
                  Text('Service Name', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Date Time : 12/12/2024'),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.access_alarms_outlined,
              color: Color.fromARGB(255, 143, 201, 101),
            ),
          ),
        ],
      ),
    );
  }
}
