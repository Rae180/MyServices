import 'package:flutter/material.dart';
import 'package:start/features/user/home/view/widgets/Close_Order_Widget.dart';

class CloesdOrdersScreen extends StatefulWidget {
  static const String routeName = 'close_orders_screen';
  const CloesdOrdersScreen({super.key});

  @override
  State<CloesdOrdersScreen> createState() => _CloesdOrdersScreenState();
}

class _CloesdOrdersScreenState extends State<CloesdOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Color.fromARGB(255, 143, 201, 101),
            ],
          ),
        ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return CloseOrderWidget();
          },
          itemCount: 3,
        ),
      ),
    );
  }
}
