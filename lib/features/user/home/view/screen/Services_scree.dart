// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/features/user/home/home_bloc/service_bloc/service_bloc.dart';
import 'package:start/features/user/home/view/widgets/Custom_service.dart';

class ServicesScreen extends StatelessWidget {
  static const routeName = 'Services_Screen';
  final int id;
  const ServicesScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceBloc(client: NetworkApiServiceHttp())
        ..add(
          GetServices(id: id),
        ),
      child: Scaffold(
        body: BlocBuilder<ServiceBloc, ServiceState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case LoadingServices:
                return LoadingWidget();
                break;
              case LoadedServices:
                final successState = state as LoadedServices;
                print(successState.services.length);
                return Scaffold(
                  appBar: AppBar(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    title: Text('data'),
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          itemCount: successState.services.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            // mainAxisExtent: 1,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: ((context, index) {
                            return ServiceItem(
                              name: state.services[index].name,
                              price: successState.services[index].price,
                              image: successState.services[index].image,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
                break;

              case ErrorGetServices:
                final errorState = state as ErrorGetServices;
                return Scaffold(
                  body: NetworkErrorWidget(
                    message: errorState.message,
                    onPressed: () {
                      BlocProvider.of<ServiceBloc>(context).add(
                        (GetServices(id: id)),
                      );
                    },
                  ),
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
