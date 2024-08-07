import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:start/features/user/Providers/Providers_bloc/Provider_Details/bloc/provider_details_bloc.dart';

class ProviderDetailsScren extends StatelessWidget {
  static const String routeName = 'Providers_Details_Screen';
  final int? providerId;
  const ProviderDetailsScren({
    super.key,
    this.providerId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProviderDetailsBloc(client: NetworkApiServiceHttp())
        ..add(
          FetchProviderDetails(providerId),
        ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          title: Text(AppLocalizations.of(context)!.details),
        ),
        body: BlocBuilder<ProviderDetailsBloc, ProviderDetailsState>(
            builder: (context, state) {
          switch (state.runtimeType) {
            case ProviderDetailsLoading:
              return LoadingWidget();
            case ProviderDetailsLoaded:
              final successState = state as ProviderDetailsLoaded;
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ClipOval(
                        child: Image.network(
                          '${ApiConstants.STORAGE_URL}${successState.providerDetails.user!.image!}',
                          fit: BoxFit.cover,
                          width: 140,
                          height: 140,
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      _buildInfoField(
                        context,
                        label: AppLocalizations.of(context)!.firstname,
                        value: successState.providerDetails.user!.firstName!,
                      ),
                      _buildInfoField(
                        context,
                        label: AppLocalizations.of(context)!.lastname,
                        value: successState.providerDetails.user!.lastName!,
                      ),
                      _buildInfoField(
                        context,
                        label: AppLocalizations.of(context)!.jobDescreption,
                        value: successState.providerDetails.jobDescription!,
                      ),
                      _buildInfoField(
                        context,
                        label: AppLocalizations.of(context)!.email,
                        value: successState.providerDetails.user!.email!,
                      ),
                      _buildInfoField(
                        context,
                        label: AppLocalizations.of(context)!.phonenumber,
                        value: successState.providerDetails.user!.phoneNum!,
                      ),
                      _buildInfoField(
                        context,
                        label: AppLocalizations.of(context)!.address,
                        value: successState.providerDetails.user!.mainAddress!,
                      ),
                      _buildInfoField(
                        context,
                        label: AppLocalizations.of(context)!.status,
                        value: successState.providerDetails.status!,
                      ),
                      _buildInfoField(
                        context,
                        label: AppLocalizations.of(context)!.hourlyrate,
                        value:
                            successState.providerDetails.hourlyRate!.toString(),
                      ),
                      if (successState.providerDetails.posts != null &&
                          successState.providerDetails.posts!.isNotEmpty)
                        Container(
                          height: 340,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                successState.providerDetails.posts!.length,
                            itemBuilder: (context, postIndex) {
                              final post = successState
                                  .providerDetails.posts![postIndex];

                              if (post == null ||
                                  post.imagePaths == null ||
                                  post.imagePaths!.isEmpty) {
                                return Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    height: 300,
                                    width: 300,
                                    child: Center(
                                      child: Text(AppLocalizations.of(context)!
                                          .noImageAvailable),
                                    ),
                                  ),
                                );
                              }

                              return Container(
                                width: 300,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: post.imagePaths!.length,
                                  itemBuilder: (context, imageIndex) {
                                    final imagePath =
                                        post.imagePaths![imageIndex];
                                    final completeImageUrl = imagePath
                                            .startsWith('http')
                                        ? imagePath
                                        : '${ApiConstants.STORAGE_URL}${imagePath}';

                                    return Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4),
                                            height: 300,
                                            width: 300,
                                            child: Image.network(
                                              completeImageUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          post.description!,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              );
            case ProviderDetailsError:
              final errorState = state as ProviderDetailsError;
              return Scaffold(
                body: NetworkErrorWidget(
                    message: errorState.message,
                    onPressed: () {
                      BlocProvider.of<ProviderDetailsBloc>(context).add(
                        FetchProviderDetails(providerId),
                      );
                    }),
              );
            default:
              return const SizedBox();
          }
        }),
      ),
    );
  }

  Widget _buildInfoField(BuildContext context,
      {required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: TextFormField(
        readOnly: true,
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
