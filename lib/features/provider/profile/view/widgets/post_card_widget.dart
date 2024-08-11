import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/ui/app_dialog.dart';
import 'package:start/features/provider/profile/bloc/mypost_bloc.dart';
import 'package:start/features/provider/profile/model/Post_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      post.description!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Created at: ${post.createdAt}",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext cxt) {
                          return DialogItem(
                            icon: Icon(
                              Icons.remove_circle,
                              size: 40,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: AppLocalizations.of(context)?.delete ?? "",
                            // paragraph: AppLocalizations.of(context)
                            //         ?.doYouWantToDeleteAccount ??
                            //     "",
                            cancelButtonText:
                                AppLocalizations.of(context)?.cancel ?? "",
                            nextButtonText:
                                AppLocalizations.of(context)?.delete ?? "",
                            nextButtonFunction: () async {
                              // PreferenceUtils.setBool('isonline', false);
                              BlocProvider.of<MypostBloc>(context)
                                  .add(DeleteMyPostEvent(id: post.id!));
                              Navigator.pop(context);
                            },
                            cancelButtonFunction: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                        barrierDismissible: false,
                      ).then((value) => BlocProvider.of<MypostBloc>(context)
                          .add(GetMyPostEvent()));
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            ),
            if (post.imagePaths != null) ...[
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: post.imagePaths!.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      ApiConstants.STORAGE_URL + post.imagePaths![index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
