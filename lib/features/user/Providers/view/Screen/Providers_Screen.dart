// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/features/user/Providers/Providers_bloc/Provider_Like/bloc/provider_like_bloc.dart';
import 'package:start/features/user/Providers/Providers_bloc/Providers_service_bloc/provider_service_bloc.dart';
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
  Set<ProviderStatus> selectedStatues = {};

  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;
  bool isSelected4 = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProviderServiceBloc(client: NetworkApiServiceHttp())
                ..add(GetProvoiders(id: widget.id!)),
        ),
        BlocProvider(
          create: (context) =>
              ProviderLikeBloc(client: NetworkApiServiceHttp()),
        ),
      ],
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
                                selected: selectedStatues
                                    .contains(ProviderStatus.online),
                                label: Text(
                                  AppLocalizations.of(context)!.onlineState,
                                ),
                                onSelected: (value) {
                                  setState(() {
                                    if (value) {
                                      selectedStatues
                                          .add(ProviderStatus.online);
                                    } else {
                                      selectedStatues
                                          .remove(ProviderStatus.online);
                                    }
                                  });
                                  context.read<ProviderServiceBloc>().add(
                                      SelectOrderType(
                                          orderType: selectedStatues));
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
                                selected: selectedStatues
                                    .contains(ProviderStatus.the_closest),
                                label: Text(
                                  AppLocalizations.of(context)!.closest,
                                ),
                                onSelected: (value) {
                                  setState(() {
                                    if (value) {
                                      selectedStatues
                                          .add(ProviderStatus.the_closest);
                                    } else {
                                      selectedStatues
                                          .remove(ProviderStatus.the_closest);
                                    }
                                  });
                                  context.read<ProviderServiceBloc>().add(
                                      SelectOrderType(
                                          orderType: selectedStatues));
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
                                selected: selectedStatues
                                    .contains(ProviderStatus.highest_rated),
                                label: Text(
                                  AppLocalizations.of(context)!.highestRate,
                                ),
                                onSelected: (value) {
                                  setState(() {
                                    if (value) {
                                      selectedStatues
                                          .add(ProviderStatus.highest_rated);
                                    } else {
                                      selectedStatues
                                          .remove(ProviderStatus.highest_rated);
                                    }
                                  });
                                  context.read<ProviderServiceBloc>().add(
                                      SelectOrderType(
                                          orderType: selectedStatues));
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
                            final provider = sucessState.providers[index];
                            return BlocBuilder<ProviderLikeBloc,
                                ProviderLikeState>(
                              builder: (context, Likestate) {
                                bool isLiked = provider.isFav!;

                                return ProviderTile(
                                  hourleyrate: provider.hourlyRate,
                                  providerId: provider.providerId,
                                  image: provider.image,
                                  name: provider.firstName!,
                                  status: provider.status!,
                                  isLiked: isLiked,
                                  onLike: () {
                                    context.read<ProviderLikeBloc>().add(
                                        LikeProvider(
                                            providerId: provider.providerId));
                                    if (selectedStatues.isEmpty) {
                                      BlocProvider.of<ProviderServiceBloc>(
                                              context)
                                          .add(GetProvoiders(id: widget.id!));
                                    } else {
                                      BlocProvider.of<ProviderServiceBloc>(
                                              context)
                                          .add(SelectOrderType(
                                              orderType: selectedStatues));
                                    }
                                  },
                                  onUnlike: () {
                                    context.read<ProviderLikeBloc>().add(
                                        UnlikeProvider(
                                            providerId: provider.providerId));
                                    if (selectedStatues.isEmpty) {
                                      BlocProvider.of<ProviderServiceBloc>(
                                              context)
                                          .add(GetProvoiders(id: widget.id!));
                                    } else {
                                      BlocProvider.of<ProviderServiceBloc>(
                                              context)
                                          .add(SelectOrderType(
                                              orderType: selectedStatues));
                                    }
                                  },
                                );
                              },
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
