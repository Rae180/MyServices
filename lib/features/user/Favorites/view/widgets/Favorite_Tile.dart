import 'package:flutter/material.dart';
import 'package:animated_react_button/animated_react_button.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/features/user/Providers/view/Screen/Provider_Details._Screen.dart';
import 'package:start/features/user/order_details/view/screen/order_details_screen.dart';

class FavoriteTile extends StatefulWidget {
  final int? providerId;
  final String? image;
  final String name;
  final String status;
  final int? hourleyrate;
  final bool isLiked;
  final VoidCallback onLike;
  final VoidCallback onUnlike;

  const FavoriteTile({
    required this.providerId,
    required this.image,
    required this.name,
    required this.status,
    required this.hourleyrate,
    required this.isLiked,
    required this.onLike,
    required this.onUnlike,
  });

  @override
  State<FavoriteTile> createState() => _FavoriteTileState();
}

class _FavoriteTileState extends State<FavoriteTile> {
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
                  backgroundImage: widget.image != null
                      ? NetworkImage(
                          '${ApiConstants.STORAGE_URL}${widget.image!}')
                      : AssetImage('assets/profile.jpg') as ImageProvider,
                  radius: 24,
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Status: ${widget.status}'),
                ],
              ),
            ],
          ),
          Row(
            children: [
              AnimatedReactButton(
                defaultColor: Colors.red,
                reactColor: widget.isLiked ? Colors.grey : Colors.red,
                onPressed: () {
                  if (widget.isLiked) {
                    widget.onUnlike();
                  } else {
                    widget.onLike();
                  }
                },
                showSplash: true,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    OrderDetailsScreen.routeName,
                    arguments: {
                      'providerId': widget.providerId,
                    },
                  );
                },
                icon: Icon(
                  Icons.add_outlined,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
