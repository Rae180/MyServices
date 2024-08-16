import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/features/provider/profile/bloc/mypost_bloc.dart';
import 'package:start/features/provider/profile/model/Post_model.dart';
import 'package:start/features/provider/profile/view/screens/add_post_screen.dart';
import 'package:start/features/provider/profile/view/widgets/post_card_widget.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MypostBloc(client: NetworkApiServiceHttp())..add(GetMyPostEvent()),
      child: BlocBuilder<MypostBloc, MypostState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.lightGreen,
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (cxt) => BlocProvider.value(
                                value: BlocProvider.of<MypostBloc>(context),
                                child: const AddPostScreen(),
                              )))
                      .then((value) => BlocProvider.of<MypostBloc>(context)
                          .add(GetMyPostEvent()));
                }),
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.businessexhibition),
            ),
            body: BlocBuilder<MypostBloc, MypostState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const LoadingWidget();
                } else if (state is SuccessLoadedPost) {
                  return ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (cxt, index) {
                      return BlocProvider.value(
                        value: BlocProvider.of<MypostBloc>(context),
                        child: PostCard(post: state.data[index]),
                      );
                    },
                  );
                } else if (state is ErrorState) {
                  return NetworkErrorWidget(
                    message: state.error,
                    onPressed: () {
                      BlocProvider.of<MypostBloc>(context).add(
                        (GetMyPostEvent()),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
