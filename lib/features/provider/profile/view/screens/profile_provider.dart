import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/ui/delete_account_item.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/language_item.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/core/ui/logout_item.dart';
import 'package:start/core/ui/profile_item.dart';
import 'package:start/features/Auth/bloc/auth_bloc.dart';
import 'package:start/features/provider/order/view/screens/filter_order_screen.dart';
import 'package:start/features/provider/profile/bloc/profile_bloc.dart';
import 'package:start/features/provider/profile/view/screens/post_screen.dart';
import 'package:start/features/provider/profile/view/widgets/details_profile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileProvider extends StatelessWidget {
  const ProfileProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: BlocProvider(
        create: (context) => ProfileBloc(client: NetworkApiServiceHttp())
          ..add(GetProfileEvent()),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is SuccessdelelteState) {
              BlocProvider.of<AuthBloc>(context).add(DeleteEvent());
            }
            if (state is LoadingState) {
              return const LoadingWidget();
            } else if (state is SuccessLoadedProfile) {
              print(ApiConstants.STORAGE_URL + state.profileModel.image!);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (cxt) => BlocProvider.value(
                                    value:
                                        BlocProvider.of<ProfileBloc>(context),
                                    child: UserDetailsPage(
                                      userData: state.profileModel,
                                    ),
                                  )))
                          .then((value) => BlocProvider.of<ProfileBloc>(context)
                              .add(GetProfileEvent())),
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  backgroundColor: Colors.lightGreen,
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                      "${ApiConstants.STORAGE_URL}${state.profileModel.image!}")),
                              Text(
                                  '${state.profileModel.firstName} ${state.profileModel.lastName}'),
                              Text(state.profileModel.email!),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ProfileItem(
                        icon: Icons.post_add,
                        text: AppLocalizations.of(context)!.businessexhibition,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PostList()));
                        }),
                    const LanguageItem(),
                    BlocProvider.value(
                      value: BlocProvider.of<ProfileBloc>(context),
                      child: const DeleteAccountItem(),
                    ),
                    const LogOutItem(),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const OrdersScreenProvider()));
                        },
                        child: const Text('order'))
                  ],
                ),
              );
            } else if (state is ErrorState) {
              return NetworkErrorWidget(
                message: state.error,
                onPressed: () {
                  BlocProvider.of<ProfileBloc>(context).add(
                    (GetProfileEvent()),
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
