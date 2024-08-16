import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/ui/app_dialog.dart';
import 'package:start/core/ui/app_text.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/loading_dialog.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/core/utils/helpers/launching_map.dart';
import 'package:start/core/utils/helpers/toast_flutter.dart';
import 'package:start/features/provider/order/bloc/details_order_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:start/features/provider/order/bloc/mangeorder_bloc.dart';

class OrderDetailsProviderScreen extends StatefulWidget {
  static const routeName = 'Order_detials_Screen';
  final int id;
  const OrderDetailsProviderScreen({super.key, required this.id});

  @override
  State<OrderDetailsProviderScreen> createState() =>
      _OrderDetailsProviderScreenState();
}

class _OrderDetailsProviderScreenState
    extends State<OrderDetailsProviderScreen> {
  var dateTime = DateTime.now();
  final DateController = TextEditingController();

  Future<DateTime?> ShowDate() => showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        initialDate: DateTime.now(),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

  Future pickDateTime(BuildContext context1) async {
    DateTime? date = await ShowDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() => this.dateTime = dateTime);

    DateController.text = DateFormat.yMMMd().add_jm().format(dateTime);
    BlocProvider.of<MangeorderBloc>(context1)
        .add(RescheduleorderEvent(id: widget.id, dateTime: dateTime));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.neworder),
        centerTitle: true,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => 
                DetailsOrderBloc(client: NetworkApiServiceHttp())
                  ..add(GetDetailsOrderEvent(id: widget.id)),
          ),
          BlocProvider(
            create: (context2) =>
                MangeorderBloc(client: NetworkApiServiceHttp()),
          ),
        ],
        child: BlocListener<MangeorderBloc, MangeorderState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showLoadingDialog(context);
            } else if (state is DonemanageState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.white,
                margin: const EdgeInsets.only(bottom: 600, left: 10, right: 10),
                content: Text(
                  AppLocalizations.of(context)!.doneorder,
                  style: const TextStyle(color: Colors.black),
                ),
              ));
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            } else if (state is ErrormanageState) {
              // ToastUtils.showErrorToastMessage(state.error);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.white,
                margin: const EdgeInsets.only(bottom: 600, left: 10, right: 10),
                content: Text(
                  state.error,
                  style: const TextStyle(color: Colors.black),
                ),
              ));
            }
          },
          child: BlocBuilder<DetailsOrderBloc, DetailsOrderState>(
            builder: (context, state) {
              if (state is LoadingDetailsOrderState) {
                return const LoadingWidget();
              } else if (state is ErrorGetDetailsOrderState) {
                return NetworkErrorWidget(
                    message: state.message,
                    onPressed: () {
                      BlocProvider.of<DetailsOrderBloc>(context)
                          .add(GetDetailsOrderEvent(id: widget.id));
                    });
              } else if (state is LoadedDetailsOrderState) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: FlutterMap(
                            options: MapOptions(
                                center: LatLng(
                                    double.parse(state.data.latitude!),
                                    double.parse(state.data.longitude!)),
                                zoom: 13),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.start',
                              ),
                              MarkerLayer(markers: [
                                Marker(
                                    point: LatLng(
                                        double.parse(state.data.latitude!),
                                        double.parse(state.data.longitude!)),
                                    child: const Icon(
                                      Icons.home,
                                      size: 35,
                                      color: Colors.lightGreen,
                                    ))
                              ])
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDirectionBtn(context, state),
                              const SizedBox(
                                height: 4,
                              ),
                              AppText(
                                  "${AppLocalizations.of(context)!.servicename} : ${state.data.provider?.service!.name}"),
                              const SizedBox(
                                height: 4,
                              ),
                              AppText(
                                  "${AppLocalizations.of(context)!.type} : ${state.data.type}"),
                              const SizedBox(
                                height: 4,
                              ),
                              AppText(
                                  "${AppLocalizations.of(context)!.scheduleDate} : ${state.data.scheduleDate}"),
                              const SizedBox(
                                height: 4,
                              ),
                              AppText(
                                  "${AppLocalizations.of(context)!.notes} : ${state.data.notes}"),
                              const SizedBox(
                                height: 4,
                              ),
                              AppText(
                                  "${AppLocalizations.of(context)!.paymentMethod} : ${state.data.paymentMethod}"),
                              const SizedBox(
                                height: 4,
                              ),
                              // Row(
                              //   children: [
                              //     AppText(
                              //         "${AppLocalizations.of(context)!.nameCustomer}:"),
                              //     const SizedBox(
                              //       width: 8,
                              //     ),
                              //     AppText(state.data.user!.firstName!),
                              //     const SizedBox(
                              //       width: 4,
                              //     ),
                              //     AppText(state.data.user!.lastName!)
                              //   ],
                              // ),

                              // const SizedBox(
                              //   height: 4,
                              // ),
                              if(state.data.imageUrls!= null)
                              SizedBox(
                                height: 100,
                                child: ListView.separated(
                                  itemCount: state.data.imageUrls!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: Image.network(
                                          state.data.imageUrls![index]),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      width: 10,
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.grey)),
                                    onPressed: () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context2) => DialogItem(
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .areyousure,
                                                cancelButtonText:
                                                    AppLocalizations.of(
                                                            context)!
                                                        .no,
                                                nextButtonText:
                                                    AppLocalizations.of(
                                                            context)!
                                                        .yes,
                                                cancelButtonFunction: () {
                                                  Navigator.of(context).pop();
                                                },
                                                nextButtonFunction: () async {
                                                  state.data.type == "schedule"
                                                      ? BlocProvider.of<
                                                                  MangeorderBloc>(
                                                              context)
                                                          .add(
                                                              RejectrescheduleorderEvent(
                                                                  id: state.data
                                                                      .id!))
                                                      : BlocProvider.of<
                                                                  MangeorderBloc>(
                                                              context)
                                                          .add(RejectorderEvent(
                                                              id: state
                                                                  .data.id!));
                                                  Navigator.of(context).pop();
                                                },
                                              ));
                                    },
                                    child: AppText(
                                        AppLocalizations.of(context)!.reject))),
                            if (state.data.type == "schedule")
                              Expanded(
                                  child: ElevatedButton(
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.lightGreen)),
                                      onPressed: () => pickDateTime(context),
                                      child: AppText(
                                          fontSize: 15,
                                          AppLocalizations.of(context)!
                                              .reschedule))),
                            Expanded(
                                child: ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.red)),
                                    onPressed: () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context2) => DialogItem(
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .areyousure,
                                                cancelButtonText:
                                                    AppLocalizations.of(
                                                            context)!
                                                        .no,
                                                nextButtonText:
                                                    AppLocalizations.of(
                                                            context)!
                                                        .yes,
                                                cancelButtonFunction: () {
                                                  Navigator.of(context).pop();
                                                },
                                                nextButtonFunction: () async {
                                                  state.data.type == "schedule"
                                                      ? BlocProvider.of<
                                                                  MangeorderBloc>(
                                                              context)
                                                          .add(
                                                              AcceptrescheduleorderEvent(
                                                                  id: state.data
                                                                      .id!))
                                                      : BlocProvider.of<
                                                                  MangeorderBloc>(
                                                              context)
                                                          .add(AcceptorderEvent(
                                                              id: state
                                                                  .data.id!));
                                                  Navigator.of(context).pop();
                                                },
                                              ));
                                    },
                                    child: AppText(
                                        AppLocalizations.of(context)!.accept))),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return NetworkErrorWidget(
                    message: AppLocalizations.of(context)!.tryagain,
                    onPressed: () {
                      BlocProvider.of<DetailsOrderBloc>(context)
                          .add(GetDetailsOrderEvent(id: widget.id));
                    });
              }
            },
          ),
        ),
      ),
    );
  }

  ElevatedButton _buildDirectionBtn(
      BuildContext context, LoadedDetailsOrderState state) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.send_rounded, color: Colors.white),
      label: Text(
        AppLocalizations.of(context)!.directions,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      onPressed: () async {
        final lat = double.parse(state.data.latitude!);
        final lng = double.parse(state.data.longitude!);

        if (Platform.isAndroid) {
          await LaunchingMapHelper.showGoogleMap(lat, lng);
        } else if (Platform.isIOS) {
          await LaunchingMapHelper.showAppleMap(lat, lng);
        }
      },
    );
  }
}
