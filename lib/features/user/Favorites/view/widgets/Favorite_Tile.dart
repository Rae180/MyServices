import 'package:flutter/material.dart';
import 'package:animated_react_button/animated_react_button.dart';
import 'package:start/core/constants/api_constants.dart';

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
              CircleAvatar(
                backgroundImage: widget.image != null
                    ? NetworkImage(
                        '${ApiConstants.STORAGE_URL}${widget.image!}')
                    : AssetImage('assets/profile.jpg') as ImageProvider,
                radius: 24,
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
                reactColor: widget.isLiked ? Colors.red : Colors.grey,
                onPressed: () {
                  if (widget.isLiked) {
                    widget.onUnlike();
                  } else {
                    widget.onLike();
                  }
                },
                showSplash: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
