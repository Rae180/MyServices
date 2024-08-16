// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/utils/services/location_service.dart';
import 'package:start/core/utils/services/shared_preferences.dart';

part 'submit_location_provider_event.dart';
part 'submit_location_provider_state.dart';

class SubmitLocationProviderBloc
    extends Bloc<SubmitLocationProviderEvent, SubmitLocationProviderState> {
  final BaseApiService client;

  Timer? timer;

  SubmitLocationProviderBloc({
    required this.client,
  }) : super(SubmitLocationProviderInitial()) {
    on<StartSubmittingLocation>((event, emit) async {
      bool online = PreferenceUtils.getbool('isonline') ?? false;
      if (online) {
        timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
          print('calling provider location');
          GeoLoc? location = await LocationService.getLocationCoords();
          if (location != null) {
            await client.postRequestAuth(
                url: ApiConstants.updatelocationprovider,
                jsonBody: {
                  "address": "empty",
                  "longitude": location.lng,
                  "latitude": location.lat
                });
          }
        });
      }
    });

    on<StopSubmittingLocation>((event, emit) {
      if (timer != null) {
        timer!.cancel();
      }
    });
  }
}
