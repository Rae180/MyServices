// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/features/user/Providers/Providers_bloc/provider_service_bloc.dart';
import 'package:start/features/user/Providers/view/widgets/Provider_tile.dart';

class ProvidersScreen extends StatefulWidget {
  static const routeName = 'Providers_Screen';
  final int? id;
  const ProvidersScreen({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<ProvidersScreen> createState() => _ProvidersScreenState();
}

class _ProvidersScreenState extends State<ProvidersScreen> {
  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;
  bool isSelected4 = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProviderServiceBloc(client: NetworkApiServiceHttp())
        ..add(GetProvoiders(id: widget.id!)),
      child: Scaffold(
        body: BlocBuilder<ProviderServiceBloc, ProviderServiceState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case LoadingProvidersService:
                return LoadingWidget();
                break;
              case LoadedProvidersService:
                final sucessState = state as LoadedProvidersService;
                return Scaffold(
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
                  body: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 4,
                              ),
                              FilterChip(
                                checkmarkColor: Colors.black,
                                selectedColor:
                                    Color.fromARGB(255, 143, 201, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ),
                                  side: BorderSide(
                                    color: Color.fromARGB(255, 144, 201, 100),
                                  ),
                                ),
                                avatarBorder: CircleBorder(
                                  side: BorderSide(
                                    color: Color.fromARGB(255, 144, 201, 100),
                                  ),
                                ),
                                selected: isSelected1,
                                label: Text(
                                  AppLocalizations.of(context)!.onlineState,
                                ),
                                onSelected: (value) {
                                  setState(() {
                                    isSelected1 = !isSelected1;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FilterChip(
                                checkmarkColor: Colors.black,
                                selectedColor:
                                    Color.fromARGB(255, 143, 201, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ),
                                  side: BorderSide(
                                    color: Color.fromARGB(255, 144, 201, 100),
                                  ),
                                ),
                                avatarBorder: CircleBorder(
                                  side: BorderSide(
                                    color: Color.fromARGB(255, 144, 201, 100),
                                  ),
                                ),
                                selected: isSelected2,
                                label: Text(
                                  AppLocalizations.of(context)!.instant,
                                ),
                                onSelected: (value) {
                                  setState(() {
                                    isSelected2 = !isSelected2;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FilterChip(
                                checkmarkColor: Colors.black,
                                selectedColor:
                                    Color.fromARGB(255, 143, 201, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ),
                                  side: BorderSide(
                                    color: Color.fromARGB(255, 144, 201, 100),
                                  ),
                                ),
                                avatarBorder: CircleBorder(
                                  side: BorderSide(
                                    color: Color.fromARGB(255, 144, 201, 100),
                                  ),
                                ),
                                selected: isSelected3,
                                label: Text(
                                  AppLocalizations.of(context)!.nearby,
                                ),
                                onSelected: (value) {
                                  setState(() {
                                    isSelected3 = !isSelected3;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FilterChip(
                                checkmarkColor: Colors.black,
                                selectedColor:
                                    Color.fromARGB(255, 143, 201, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ),
                                  side: BorderSide(
                                    color: Color.fromARGB(255, 144, 201, 100),
                                  ),
                                ),
                                avatarBorder: CircleBorder(
                                  side: BorderSide(
                                    color: Color.fromARGB(255, 144, 201, 100),
                                  ),
                                ),
                                selected: isSelected4,
                                label: Text(
                                  AppLocalizations.of(context)!.ratings,
                                ),
                                onSelected: (value) {
                                  setState(() {
                                    isSelected4 = !isSelected4;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return ProviderTile(
                              providerId: sucessState.providers[index].providerId,
                              image: sucessState.providers[index].image,
                              name: sucessState.providers[index].firstName!,
                              status: sucessState.providers[index].status!,
                            );
                          },
                          itemCount: sucessState.providers.length,
                        ),
                      )
                    ],
                  ),
                );
                break;
              case ErrorGetProvidersService:
                final errorState = state as ErrorGetProvidersService;
                return Scaffold(
                  body: NetworkErrorWidget(
                      message: errorState.messsage,
                      onPressed: () {
                        BlocProvider.of<ProviderServiceBloc>(context).add(
                          GetProvoiders(id: widget.id!),
                        );
                      }),
                );
                break;
              default:
                return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
