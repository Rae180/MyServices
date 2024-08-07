// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                        '${AppLocalizations.of(context)!.idsorder} : $id',
                      ),
                      if (successState.order.imagePaths != null)
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
                                    '${ApiConstants.STORAGE_URL}${successState.order.imagePaths![index]}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            itemCount: 2,
                            //successState.order.imageUrls!.length,
                          ),
                        ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        AppLocalizations.of(context)!.description,
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
                      Text(
                        AppLocalizations.of(context)!.address,
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
                      Text(
                        AppLocalizations.of(context)!.dateandTime,
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
                      Text(
                        AppLocalizations.of(context)!.paymentMethod,
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
                      Text(
                        AppLocalizations.of(context)!.provider,
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
                      Text(
                        AppLocalizations.of(context)!.providerPhoneNum,
                      ),
                      Text(
                        //phoneNumber.toString(),
                        successState.order.provider!.user!.phoneNum ?? '',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      if (successState.order.status == 'completed') ...[
                        Divider(
                          color: Colors.black38,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          AppLocalizations.of(context)!.thebill,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          AppLocalizations.of(context)!.workhours,
                        ),
                        Text(
                          // providerName,
                          successState.order.completeorder!.bill!.workHours
                              .toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          AppLocalizations.of(context)!.totalPrice,
                        ),
                        Text(
                          // providerName,
                          successState.order.completeorder!.bill!.total
                              .toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          AppLocalizations.of(context)!.totalWithItems,
                        ),
                        Text(
                          // providerName,
                          successState.order.completeorder!.bill!.totalWithItem
                              .toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          AppLocalizations.of(context)!.items,
                        ),
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width / 2,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              return Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: Column(
                                      children: [
                                        Text(AppLocalizations.of(context)!
                                            .theItem),
                                        Text(
                                          successState.order.completeorder!
                                              .bill!.items![index].item!,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .thePrice,
                                        ),
                                        Text(
                                          successState.order.completeorder!
                                              .bill!.items![index].price
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                            itemCount: successState
                                .order.completeorder!.bill!.items!.length,
                          ),
                        ),
                        Divider(
                          color: Colors.black38,
                        ),
                      ],
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black12,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                AppLocalizations.of(context)!.back,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            if (successState.order.status == 'pending')
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CancelFunctionWidget(
                                          handlingOrderBloc: handlingOrderBloc,
                                          id: id,
                                        );
                                      });
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.cancel,
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
