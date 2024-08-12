import 'package:flutter/material.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/features/user/Providers/view/Screen/Provider_Details._Screen.dart';
import 'package:start/features/user/order_details/view/screen/order_details_screen.dart';

class SearchResultTile extends StatelessWidget {
  final int id;
  final String firstName;
  final String lastName;
  final String status;
  final int hourlyRate;
  final String service;
  final String imageUrl;
  final int averageRating;

  const SearchResultTile({
    Key? key,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.status,
    required this.hourlyRate,
    required this.service,
    required this.imageUrl,
    required this.averageRating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => ProviderDetailsScren(
                          providerId: id,
                        )),
                  ),
                );
                print('the id in the circle avatr is :${id}');
              },
              child: CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage('${ApiConstants.STORAGE_URL}${imageUrl}'),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$firstName $lastName',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    status,
                    style: TextStyle(
                      color: status == 'online' ? Colors.green : Colors.red,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text('Service: $service'),
                  SizedBox(height: 4.0),
                  Text('Hourly Rate: \$${hourlyRate.toStringAsFixed(2)}'),
                  SizedBox(height: 4.0),
                ],
              ),
            ),
            Column(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Text(
                  averageRating.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      OrderDetailsScreen.routeName,
                      arguments: {
                        'providerId': id,
                      },
                    );
                  },
                  icon: Icon(
                    Icons.add_outlined,
                    color: Colors.green,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
