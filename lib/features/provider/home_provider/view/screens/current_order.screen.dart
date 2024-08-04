import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/ui/app_text.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/core/ui/small_button.dart';
import 'package:start/core/utils/helpers/launching_map.dart';
import 'package:start/features/provider/home_provider/bloc/managecurrentorder_bloc.dart';
import 'package:start/features/provider/home_provider/view/screens/invoice_screen.dart';
import 'package:start/features/provider/home_provider/view/screens/item_order_screen.dart';
import 'package:start/features/provider/order/bloc/details_order_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:start/features/user/Orders/Orders_bloc/Order_Details/deatils_for_order_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CurrentOrderScreen extends StatefulWidget {
  final int id;
  const CurrentOrderScreen({super.key, required this.id});

  @override
  State<CurrentOrderScreen> createState() => _CurrentOrderScreenState();
}

class _CurrentOrderScreenState extends State<CurrentOrderScreen> {
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
    BlocProvider.of<ManagecurrentorderBloc>(context1)
        .add(postpomentorderEvent(id: widget.id, dateTime: dateTime));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DetailsOrderBloc(client: NetworkApiServiceHttp())
            ..add(GetDetailsOrderEvent(id: widget.id)),
        ),
        BlocProvider(
          create: (context) =>
              ManagecurrentorderBloc(client: NetworkApiServiceHttp()),
        ),
      ],
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
                            center: LatLng(double.parse(state.data.latitude!),
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
                          Row(
                            children: [
                              _buildDirectionBtn(context, state),
                              const SizedBox(
                                width: 10,
                              ),
                              _buildCallBtn(context, state.data.user!.phoneNum!)
                            ],
                          ),
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
                          if (state.data.imageUrls != null)
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
                if (state.data.inprogressstatus == "waiting")
                  BlocConsumer<ManagecurrentorderBloc, ManagecurrentorderState>(
                    listener: (context, state) {
                      if (state is DonemanageState) {
                        BlocProvider.of<DetailsOrderBloc>(context)
                            .add(GetDetailsOrderEvent(id: widget.id));
                        BlocProvider.of<DeatilsForOrderBloc>(context)
                            .add(FilterOrdersByStatus("in progress"));
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(9),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.lightGreen)),
                              onPressed: () {
                                BlocProvider.of<ManagecurrentorderBloc>(context)
                                    .add(ArriveorderEvent(id: widget.id));
                              },
                              child: state is LoadingState
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      AppLocalizations.of(context)!.arrived,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )),
                        ),
                      );
                    },
                  ),
                if (state.data.inprogressstatus == "arrived")
                  BlocConsumer<ManagecurrentorderBloc, ManagecurrentorderState>(
                    listener: (context, state) {
                      if (state is DonemanageState) {
                        BlocProvider.of<DetailsOrderBloc>(context)
                            .add(GetDetailsOrderEvent(id: widget.id));
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(9),
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.lightGreen)),
                                    onPressed: () {
                                      BlocProvider.of<ManagecurrentorderBloc>(
                                              context)
                                          .add(StartWorkorderEvent(
                                              id: widget.id));
                                    },
                                    child: state is LoadingState
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            AppLocalizations.of(context)!
                                                .startWork,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.redAccent)),
                                    onPressed: () => pickDateTime(context),
                                    child: state is LoadingState2
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            AppLocalizations.of(context)!
                                                .postponememt,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                if (state.data.inprogressstatus == "start" ||
                    state.data.inprogressstatus == "resume")
                  BlocConsumer<ManagecurrentorderBloc, ManagecurrentorderState>(
                    listener: (context, state) {
                      if (state is DonemanageState) {
                        BlocProvider.of<DetailsOrderBloc>(context)
                            .add(GetDetailsOrderEvent(id: widget.id));
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(9),
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.lightGreen)),
                                    onPressed: () {
                                      BlocProvider.of<ManagecurrentorderBloc>(
                                              context)
                                          .add(
                                              EndWorkorderEvent(id: widget.id));
                                    },
                                    child: state is LoadingState
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            AppLocalizations.of(context)!
                                                .endwork,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.redAccent)),
                                    onPressed: () {
                                      BlocProvider.of<ManagecurrentorderBloc>(
                                              context)
                                          .add(PauseWorkorderEvent(
                                              id: widget.id));
                                    },
                                    child: state is LoadingState2
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            AppLocalizations.of(context)!.pause,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                if (state.data.inprogressstatus == "pause")
                  BlocConsumer<ManagecurrentorderBloc, ManagecurrentorderState>(
                    listener: (context, state) {
                      if (state is DonemanageState) {
                        BlocProvider.of<DetailsOrderBloc>(context)
                            .add(GetDetailsOrderEvent(id: widget.id));
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(9),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.lightGreen)),
                              onPressed: () {
                                BlocProvider.of<ManagecurrentorderBloc>(context)
                                    .add(ResumeWorkorderEvent(id: widget.id));
                              },
                              child: state is LoadingState
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      AppLocalizations.of(context)!.resumework,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )),
                        ),
                      );
                    },
                  ),
                if (state.data.inprogressstatus == "end")
                  Padding(
                    padding: const EdgeInsets.all(9),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.lightGreen)),
                                onPressed: () {
                                  // BlocProvider.of<ManagecurrentorderBloc>(
                                  //         context)
                                  //     .add(ResumeWorkorderEvent(id: widget.id));
                                  Navigator.of(context)
                                      .push(
                                        MaterialPageRoute(
                                          builder: (ctx) => BlocProvider.value(
                                            value: BlocProvider.of<
                                                    ManagecurrentorderBloc>(
                                                context),
                                            child: ItemListPage(
                                              id: state.data.id!,
                                            ),
                                          ),
                                        ),
                                      )
                                      .then((value) => {
                                            BlocProvider.of<DetailsOrderBloc>(
                                                    context)
                                                .add(GetDetailsOrderEvent(
                                                    id: widget.id))
                                          });
                                },
                                child: state is LoadingState
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        AppLocalizations.of(context)!
                                            .addmaterials,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.lightGreen)),
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                        builder: (ctx) => BlocProvider.value(
                                            value: BlocProvider.of<
                                                    ManagecurrentorderBloc>(
                                                context),
                                            child: InvoiceScreen(
                                              data: state.data,
                                            )),
                                      ))
                                      .then((value) =>
                                          BlocProvider.of<DeatilsForOrderBloc>(
                                                  context)
                                              .add(FilterOrdersByStatus(
                                                  "in progress")));
                                },
                                child: state is LoadingState
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        AppLocalizations.of(context)!.invoice,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            );
          } else {
            return Container();
            //  NetworkErrorWidget(
            //     message: AppLocalizations.of(context)!.tryagain,
            //     onPressed: () {
            //       BlocProvider.of<DetailsOrderBloc>(context)
            //           .add(GetDetailsOrderEvent(id: id));
            //     });
          }
        },
      ),
    );
  }

  SmallButton _buildCallBtn(BuildContext context, String phone) {
    return SmallButton(
      icon: Icons.call,
      width: 110,
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      textColor: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      onTap: () async {
        var url = "tel:00963$phone";

        if (await canLaunchUrlString(url)) {
          await launchUrlString(url);
        }
      },
      title: AppLocalizations.of(context)?.call ?? "",
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
