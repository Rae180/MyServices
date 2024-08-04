// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/features/user/Providers/Providers_bloc/Provider_Details/bloc/provider_details_bloc.dart';

class ProviderDetailsScren extends StatelessWidget {
  static const String routeName = 'Providers_Details_Screen';
  final int? providerId;
  const ProviderDetailsScren({
    Key? key,
    this.providerId,
  }) : super(key: key);

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
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          title: Text('data'),
        ),
        body: BlocBuilder<ProviderDetailsBloc, ProviderDetailsState>(
            builder: (context, state) {
          switch (state.runtimeType) {
            case ProviderDetailsLoading:
              return LoadingWidget();
              break;
            case ProviderDetailsLoaded:
              final successState = state as ProviderDetailsLoaded;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      child: Image.network(
                          successState.providerDetails.user!.image!),
                      maxRadius: 70,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'First Name : ',
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(successState.providerDetails.user!.firstName!)
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Last Name : ',
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(successState.providerDetails.user!.lastName!)
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Job descreption : ',
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(successState.providerDetails.jobDescription!)
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Email : ',
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(successState.providerDetails.user!.email!)
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Phone number : ',
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(successState.providerDetails.user!.phoneNum!)
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Adress : ',
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(successState.providerDetails.user!.gender!)
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Status : ',
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(successState.providerDetails.status!)
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Hourly Rate : ',
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(
                            successState.providerDetails.hourlyRate!.toString())
                      ],
                    ),
                  ],
                ),
              );
              break;
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
              break;
            default:
              return SizedBox();
          }
        }),
      ),
    );
  }
}
