// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/features/user/Orders/Orders_bloc/Handling_Order/bloc/handling_order_bloc.dart';
import 'package:start/features/user/Orders/Orders_bloc/Order_Details/deatils_for_order_bloc.dart';
import 'package:start/features/user/Orders/view/widgets/Cancel_Functional.dart';
import 'package:start/features/user/Orders/view/widgets/Re-Reschedule.dart';

class CurrentOrderDetailsWidget extends StatelessWidget {
  static const String routeName = '/Current_Order_Details';
  final int? id;
 final HandlingOrderBloc handlingOrderBloc;

  const CurrentOrderDetailsWidget({
    super.key,
    this.id,
    required this.handlingOrderBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HandlingOrderBloc(NetworkApiServiceHttp())
        ..add(FetchOrderDetailsById(id)),
      child: BlocBuilder<HandlingOrderBloc, HandlingOrderState>(
        builder: (context, state) {
          if (state is GettingDetailsById) {
            return const Center(child: LoadingWidget());
          } else if (state is SuccessGettingOrderDetailsById) {
            final successState = state;
            return Dialog(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'ID\'s Order : $id',
                      ),
                      if(successState.order.imageUrls != null)
                      Container(
                        height: 300,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                height: 300,
                                width: 300,
                                child: Image.network(
                                  successState.order.imageUrls![index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          itemCount: successState.order.imageUrls!.length,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'Descreption',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Text(
                          // descreption,
                          successState.order.notes!,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'Adress',
                      ),
                      Text(
                        // adress,
                        successState.order.address!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'Date & Time',
                      ),
                      Text(
                        // datetime,
                        successState.order.scheduleDate!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'Payment',
                      ),
                      Text(
                        // payment,
                        successState.order.paymentMethod!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'Provider',
                      ),
                      Text(
                        // providerName,
                        successState.order.provider!.user!.firstName ?? '',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'Provider\'s Phone Number',
                      ),
                      Text(
                        //phoneNumber.toString(),
                        successState.order.provider!.user!.phoneNum!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black12,
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // ElevatedButton(
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: Color.fromARGB(255, 143, 201, 101),
                            //   ),
                            //   onPressed: () {
                            //     showDialog(
                            //         context: context,
                            //         builder: (context) {
                            //           return ReScheduleWidget();
                            //         });
                            //   },
                            //   child: Text(
                            //     'Re-Schedule',
                            //     style: TextStyle(
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                // handlingOrderBloc
                                //     .add(CancelOrderRequested(id.toString()));
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CancelFunctionWidget(
                                        handlingOrderBloc: handlingOrderBloc,
                                        id: id,
                                      );
                                    });
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (state is ErrorGettingDetailsOrderDetailsById) {
            final errorState = state;
            return Center(
              child: NetworkErrorWidget(
                message: errorState.message,
                onPressed: () {
                  BlocProvider.of<HandlingOrderBloc>(context)
                      .add(FetchOrderDetailsById(id));
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
