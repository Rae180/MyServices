import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/features/provider/home_provider/bloc/managecurrentorder_bloc.dart';
import 'package:start/features/provider/order/model/details_order_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvoiceScreen extends StatelessWidget {
  final DetailsOrderProvider data;

  const InvoiceScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.invoice),
        backgroundColor: Colors.lightGreen,
      ),
      body: BlocConsumer<ManagecurrentorderBloc, ManagecurrentorderState>(
        listener: (context, state) {
          if (state is DonemanageState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("sdadsad")));
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                buildOrderDetailCard(AppLocalizations.of(context)!.numberorder,
                    data.complateOrder!.id),
                buildOrderDetailCard(AppLocalizations.of(context)!.startWork,
                    data.complateOrder!.startWork),
                if (data.complateOrder!.pauseWork != null)
                  buildOrderDetailCard(AppLocalizations.of(context)!.pause,
                      data.complateOrder!.pauseWork),
                if (data.complateOrder!.resumeWork != null)
                  buildOrderDetailCard(AppLocalizations.of(context)!.resumework,
                      data.complateOrder!.resumeWork),
                buildOrderDetailCard(AppLocalizations.of(context)!.endwork,
                    data.complateOrder!.endWork),
                buildOrderDetailCard(AppLocalizations.of(context)!.totaltime,
                    data.complateOrder!.totalWorkHours),
                if (data.complateOrder!.bill != null) ...[
                  buildOrderDetailCard(
                      AppLocalizations.of(context)!.totalhoursinvoice,
                      data.complateOrder!.bill!.workHours),
                  buildOrderDetailCard(AppLocalizations.of(context)!.total,
                      data.complateOrder!.bill!.total),
                  buildOrderDetailCard(
                      AppLocalizations.of(context)!.totalwithmaterial,
                      data.complateOrder!.bill!.totalWithItem),
                  if (data.complateOrder!.bill!.items != null)
                    ...data.complateOrder!.bill!.items!.map<Widget>((item) {
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildItemDetailRow(
                                  AppLocalizations.of(context)!.idmaterial,
                                  item.id),
                              buildItemDetailRow(
                                  AppLocalizations.of(context)!.material,
                                  item.item),
                              buildItemDetailRow(
                                  AppLocalizations.of(context)!.price,
                                  item.price),
                            ],
                          ),
                        ),
                      );
                    }),
                ],
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.lightGreen)),
                    onPressed: () {
                      BlocProvider.of<ManagecurrentorderBloc>(context)
                          .add(PaidEvent(id: data.id!));
                    },
                    child: state is LoadingState
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            AppLocalizations.of(context)!.paid,
                            style: const TextStyle(color: Colors.white),
                          ))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildOrderDetailCard(String title, dynamic value) {
    return value != null
        ? Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(value.toString()),
            ),
          )
        : Container();
  }

  Widget buildItemDetailRow(String title, dynamic value) {
    return value != null
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(value.toString()),
              ],
            ),
          )
        : Container();
  }
}
