import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/features/notification/bloc/notification_bloc.dart';
import 'package:start/features/notification/view/widgets/notifcation_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.notificatons),
      ),
      body: BlocProvider(
        create: (context) => NotificationBloc(client: NetworkApiServiceHttp())
          ..add(GetNotificationEvent()),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const LoadingWidget();
            } else if (state is SuccessLoadednotifications) {
              return state.data.isEmpty ? Center(child: Text(AppLocalizations.of(context)!.empty)) :ListView.builder(
                itemBuilder: (context, item) {
                  return NotificationCard(notificationData: state.data[item]);
                },
                itemCount: state.data.length,
              );
            } else if (state is ErrorState) {
              return NetworkErrorWidget(
                message: state.error,
                onPressed: () {
                  BlocProvider.of<NotificationBloc>(context).add(
                    (GetNotificationEvent()),
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
