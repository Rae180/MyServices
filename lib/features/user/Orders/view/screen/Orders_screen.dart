import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/features/user/Orders/Orders_bloc/Handling_Order/bloc/handling_order_bloc.dart';
import 'package:start/features/user/Orders/Orders_bloc/Order_Details/deatils_for_order_bloc.dart';
import 'package:start/features/user/Orders/view/widgets/Order_Tile_Not_Accepted.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = 'Orders_Screen';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  OrderFilterState selectedFilter = OrderFilterState.pending; // Default filter

  void _handleChipSelection(BuildContext context, OrderFilterState filter) {
    setState(() {
      selectedFilter = filter;
    });
    String fltredName = filter == OrderFilterState.allCanceled
        ? "All canceled"
        : filter == OrderFilterState.inProgress
            ? "in progress"
            : describeEnum(filter);

    context.read<DeatilsForOrderBloc>().add(FilterOrdersByStatus(filter));
  }

  Future<void> _refreshOrders(BuildContext context) async {
    BlocProvider.of<DeatilsForOrderBloc>(context)
        .add(FilterOrdersByStatus(selectedFilter));
  }

  @override
  Widget build(BuildContext context) {
    const String defaultfilter = 'pending';
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                DeatilsForOrderBloc(client: NetworkApiServiceHttp())
                  ..add(FilterOrdersByStatus(selectedFilter)),
          ),
          BlocProvider(
            create: (context) => HandlingOrderBloc(NetworkApiServiceHttp()),
          ),
        ],
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children:
                      OrderFilterState.values.map((OrderFilterState filter) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Builder(builder: (context) {
                        return FilterChip(
                          checkmarkColor: Colors.black,
                          selectedColor: const Color.fromARGB(255, 143, 201, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(
                              color: Color.fromARGB(255, 144, 201, 100),
                            ),
                          ),
                          selected: selectedFilter == filter,
                          label: Text(describeEnum(filter)),
                          onSelected: (bool selected) {
                            _handleChipSelection(context, filter);
                          },
                        );
                      }),
                    );
                  }).toList(),
                ),
              ),
            ),
            BlocBuilder<DeatilsForOrderBloc, DeatilsForOrderState>(
              builder: (context, state) {
                if (state is DeatilsForOrderLoading) {
                  return const Center(child: LoadingWidget());
                } else if (state is DeatilsForOrderLoaded) {
                  print('success');
                  final successState = state;
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => _refreshOrders(context),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return OrdersNotAcceptedYetTile(
                            numberOfOrder: successState.orders[index].id!,
                            serviceName: successState.orders[index].type,
                            dateTime: successState.orders[index].scheduleDate,
                          );
                        },
                        itemCount: successState.orders.length,
                      ),
                    ),
                  );
                } else if (state is DeatilsForOrderEmpty) {
                  return const Center(
                    child: Text('No Orders available'),
                  );
                } else if (state is DetailsForOrderError) {
                  print('error');
                  final errorState = state;
                  return Center(
                    child: NetworkErrorWidget(
                      message: errorState.message,
                      onPressed: () {
                        BlocProvider.of<DeatilsForOrderBloc>(context).add(
                            FilterOrdersByStatus(selectedFilter));
                      },
                    ),
                  );
                } else {
                  print('elseing');
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
