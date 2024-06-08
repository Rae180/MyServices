// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:start/core/constants/api_constants.dart';
import 'package:start/features/user/Providers/view/Screen/Providers_Screen.dart';

class ServiceItem extends StatelessWidget {
  final int id;
  final String? name;
  final String? image;
  final double? price;
  const ServiceItem({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProvidersScreen(id: id),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 2,
            color: Color.fromARGB(255, 143, 201, 101),
          ),
          borderRadius: BorderRadius.circular(
            17,
          ),
        ),
        elevation: 4.0,
        margin: const EdgeInsets.all(
          17,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                8,
              ),
              child: Image.network(
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null ||
                      loadingProgress.expectedTotalBytes == null) {
                    return child;
                  }
                  return const Center(
                    child: SpinKitCircle(
                      color: Color.fromARGB(255, 143, 201, 101),
                      size: 84,
                    ),
                  );
                },
                '${ApiConstants.STORAGE_URL}$image',
                fit: BoxFit.cover,
                height: 70,
                width: double.infinity,
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    name!,
                  ),
                  Text(
                    '$price S.P',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
