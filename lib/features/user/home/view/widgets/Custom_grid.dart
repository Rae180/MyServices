import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/features/user/home/view/screen/Services_scree.dart';

class CategoryItem extends StatelessWidget {
  final String? title;

  final int id;
  final String? imagePath;
  const CategoryItem({
    super.key,
    required this.id,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.black12,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: ((context) => ServicesScreen(
                  id: id,
                )),
          ),
        );
      },
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 2,
                color: Color.fromARGB(255, 143, 201, 101),
              ),
              borderRadius: BorderRadius.circular(
                17.0,
              ),
            ),
            elevation: 4.0,
            margin: const EdgeInsets.all(
              17.0,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(17),
                      topRight: Radius.circular(17),
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
                          // child: CircularProgressIndicator(
                          //   value: loadingProgress.cumulativeBytesLoaded /
                          //       loadingProgress.expectedTotalBytes!,
                          //   valueColor: AlwaysStoppedAnimation<Color>(
                          //       Color.fromARGB(255, 143, 201, 101)),
                          // ),
                        );
                      },
                      '${ApiConstants.STORAGE_URL}$imagePath',
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: 110,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
