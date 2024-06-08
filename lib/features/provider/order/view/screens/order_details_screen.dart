import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/core/utils/helpers/launching_map.dart';
import 'package:start/features/provider/order/bloc/details_order_bloc.dart';
import 'package:start/features/user/home/home_bloc/Category_bloc/category_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderDetailsProviderScreen extends StatelessWidget {
  static const routeName = 'Order_detials_Screen';
  final int id;
  const OrderDetailsProviderScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.neworder),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => DetailsOrderBloc(client: NetworkApiServiceHttp())
          ..add(GetDetailsOrderEvent(id: id)),
        child: BlocBuilder<DetailsOrderBloc, DetailsOrderState>(
          builder: (context, state) {
            if (state is LoadingDetailsOrderState) {
              return const LoadingWidget();
            } else if (state is ErrorGetDetailsOrderState) {
              return NetworkErrorWidget(
                  message: state.message,
                  onPressed: () {
                    BlocProvider.of<DetailsOrderBloc>(context)
                        .add(GetDetailsOrderEvent(id: id));
                  });
            } else if (state is LoadedDetailsOrderState) {
              return Column(
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
                              point: LatLng(double.parse(state.data.latitude!),
                                  double.parse(state.data.longitude!)),
                              child: const Icon(Icons.home,size: 35,color: Colors.lightGreen,))
                        ])
                      ],
                    ),
                  ),
                  _buildDirectionBtn(context,state)
                ],
              );
            } else {
              return NetworkErrorWidget(
                  message: AppLocalizations.of(context)!.tryagain,
                  onPressed: () {
                    BlocProvider.of<DetailsOrderBloc>(context)
                        .add(GetDetailsOrderEvent(id: id));
                  });
            }
          },
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
