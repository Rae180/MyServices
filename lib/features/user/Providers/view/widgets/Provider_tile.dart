import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/features/user/Providers/Providers_bloc/Provider_Like/bloc/provider_like_bloc.dart';
import 'package:start/features/user/Providers/view/Screen/Provider_Details._Screen.dart';
import 'package:start/features/user/order_details/view/screen/order_details_screen.dart';
import 'package:animated_react_button/animated_react_button.dart';

class ProviderTile extends StatefulWidget {
  final int? providerId;
  final String? image;
  final String name;
  final String? lastname;
  final String status;
  final int? hourleyrate;
  final int rating;
  final bool isLiked;
  final VoidCallback onLike;
  final VoidCallback onUnlike;

  ProviderTile({
    required this.providerId,
    required this.image,
    required this.rating,
    required this.name,
    required this.lastname,
    required this.status,
    required this.hourleyrate,
    required this.isLiked,
    required this.onLike,
    required this.onUnlike,
  });

  @override
  State<ProviderTile> createState() => _ProviderTileState();
}

class _ProviderTileState extends State<ProviderTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
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
                      builder: (context) => ProviderDetailsScren(
                        providerId: widget.providerId,
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundImage: widget.image != null
                      ? NetworkImage('${ApiConstants.STORAGE_URL}${widget.image!}')
                      : AssetImage('assets/profile.jpg') as ImageProvider,
                  radius: 24,
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.name} ${widget.lastname ?? ''}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Status: ${widget.status}',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  if (widget.hourleyrate != null)
                    Text(
                      'Hourly Rate: \$${widget.hourleyrate}',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < widget.rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              AnimatedReactButton(
                defaultColor: widget.isLiked ? Colors.red : Colors.grey,
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
                  Icons.reviews_outlined,
                  color: Color.fromARGB(255, 143, 201, 101),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
