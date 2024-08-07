import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/features/user/Profile/Profile_bloc/bloc/my_profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MyProfileBloc(client: NetworkApiServiceHttp())..add(FetchProfile()),
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          title: Text('Profile'),
        ),
        body: BlocBuilder<MyProfileBloc, MyProfileState>(
          builder: (context, state) {
            if (state is LoadingMyProfile) {
              return LoadingWidget();
            } else if (state is LoadedMyProfile) {
              final successState = state as LoadedMyProfile;
              return Center(
                child: Column(
                  children: [
                    CircleAvatar(

                      child: Image.network(height: 100,
                          '${ApiConstants.STORAGE_URL}${successState.profile.image}'),
                    ),
                    Text(successState.profile.firstName!),
                    Text(successState.profile.lastName!),
                    Text(successState.profile.gender!),
                    Text(successState.profile.email!),
                    Text(successState.profile.mainAddress!),
                    Text(successState.profile.phoneNum!),
                  ],
                ),
              );
            } else {
              final errorState = state as ErrorMyProfile;
              return NetworkErrorWidget(
                  message: errorState.message,
                  onPressed: () {
                    BlocProvider.of<MyProfileBloc>(context).add(FetchProfile());
                  });
            }
          },
        ),
      ),
    );
  }
}
