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
import 'package:start/features/provider/profile/view/screens/post_screen.dart';
import 'package:start/features/provider/profile/view/widgets/details_profile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:start/features/user/Profile/Profile_bloc/bloc/my_profile_bloc.dart';
import 'package:start/features/user/Profile/view/widgets/user_details_widget.dart';
import 'package:start/features/user/Settings/Settings_bloc/Addig_new_Suggest_bloc/bloc/adding_new_suggest_bloc.dart';
import 'package:start/features/user/Settings/view/screen/Adding_new_Suggest_Screen.dart';
import 'package:start/features/wallet/view/screens/wallet_screen.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: BlocProvider(
        create: (context) => MyProfileBloc(client: NetworkApiServiceHttp())
          ..add(GetProfileEvent()),
        child: BlocBuilder<MyProfileBloc, MyProfileState>(
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
                                        BlocProvider.of<MyProfileBloc>(context),
                                    child: UserDetailsWidget(
                                      userData: state.profileModel,
                                    ),
                                  )))
                          .then((value) =>
                              BlocProvider.of<MyProfileBloc>(context)
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
                        icon: Icons.wallet,
                        text: AppLocalizations.of(context)!.wallet,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TransactionPage()));
                        }),
                    ProfileItem(
                      icon: Icons.add,
                      text: AppLocalizations.of(context)!.addingNewSuggest,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AddingNewSuggestScreen.routeName,
                        );
                      },
                    ),
                    const LanguageItem(),
                    BlocProvider.value(
                      value: BlocProvider.of<MyProfileBloc>(context),
                      child: const DeleteAccountItem(),
                    ),
                    const LogOutItem(),
                  ],
                ),
              );
            } else if (state is ErrorState) {
              return NetworkErrorWidget(
                message: state.error,
                onPressed: () {
                  BlocProvider.of<MyProfileBloc>(context).add(
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
