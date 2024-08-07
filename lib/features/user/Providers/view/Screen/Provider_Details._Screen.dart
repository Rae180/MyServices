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
          title: const Text('data'),
        ),
        body: BlocBuilder<ProviderDetailsBloc, ProviderDetailsState>(
            builder: (context, state) {
          switch (state.runtimeType) {
            case ProviderDetailsLoading:
              return const LoadingWidget();
              break;
            case ProviderDetailsLoaded:
              final successState = state as ProviderDetailsLoaded;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      maxRadius: 70,
                      child: Image.network(
                          successState.providerDetails.user!.image!),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'First Name : ',
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(successState.providerDetails.user!.firstName!)
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Last Name : ',
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(successState.providerDetails.user!.lastName!)
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Job descreption : ',
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(successState.providerDetails.jobDescription!)
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Email : ',
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(successState.providerDetails.user!.email!)
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Phone number : ',
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(successState.providerDetails.user!.phoneNum!)
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Adress : ',
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(successState.providerDetails.user!.gender!)
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Status : ',
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(successState.providerDetails.status!)
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
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
              return const SizedBox();
          }
        }),
      ),
    );
  }
}
