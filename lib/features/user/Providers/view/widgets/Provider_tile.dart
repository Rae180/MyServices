// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:start/features/user/Providers/view/Screen/Provider_Details._Screen.dart';
import 'package:start/features/user/order_details/view/screen/order_details_screen.dart';

class ProviderTile extends StatefulWidget {
  final int? providerId;
  final String? image;
  final String name;
  final String status;
  final int? hourleyrate;
  const ProviderTile(
      {required this.providerId,
      required this.image,
      required this.name,
      required this.status,
      required this.hourleyrate});

  @override
  State<ProviderTile> createState() => _ProviderTileState();
}

class _ProviderTileState extends State<ProviderTile> {
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
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => ProviderDetailsScren(
                            providerId: widget.providerId,
                          )),
                    ),
                  );
                  print('the id in the circle avatr is :${widget.providerId}');
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.jpg'),
                  radius: 24,
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Stutas: ${widget.status}'),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(OrderDetailsScreen.routeName, arguments: {
                'providerId': widget.providerId,
              });
              print('the id is ${widget.providerId}');
            },
            icon: Icon(
              Icons.reviews_outlined,
              color: Color.fromARGB(255, 143, 201, 101),
            ),
          ),
        ],
      ),
    );
  }
}
