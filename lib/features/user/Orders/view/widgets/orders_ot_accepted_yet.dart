import 'package:flutter/material.dart';
import 'package:start/features/user/Orders/view/widgets/Order_Tile_Not_Accepted.dart';

class NotAcceptedYetOrders extends StatelessWidget {
  static const String routeName = 'Orders_Not_Accepted_Yet';
  const NotAcceptedYetOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return OrdersNotAcceptedYetTile();
        },
        itemCount: 3,
      ),
    );
  }
}
