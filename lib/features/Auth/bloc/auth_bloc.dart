import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/utils/services/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final BaseApiService client;
  AuthBloc({required this.client}) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async{
      String? token = PreferenceUtils.getString('token');
      if (token == null) {
        emit(UnauthenticatedState());
      } else {
        bool provider = PreferenceUtils.getbool('provider')!;

        if (provider)  {
          print(token);
          var data = await client.getRequestAuth(url: ApiConstants.checkactiveaccountprovider);
          
          if (data['success'] == '0') {
         emit(UnactiveAccount());
          }else{
            emit(AuthenticatedProviderState());
          }
          
        } else {
          emit(AuthenticatedUserState());
        }
      }
    });
    on<LogOutEvent>((event, emit) async{
      await client.getRequestAuth(url: ApiConstants.logout);
     PreferenceUtils.removeValue('token');
     emit(UnauthenticatedState());
    });
  }
}
