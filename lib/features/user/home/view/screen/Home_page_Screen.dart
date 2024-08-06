import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/language_item.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/core/ui/logout_item.dart';
import 'package:start/features/user/Orders/Orders_bloc/Order_Details/deatils_for_order_bloc.dart';
import 'package:start/features/user/home/home_bloc/Category_bloc/category_bloc.dart';
import 'package:start/features/user/home/home_bloc/Close_Orders_Bloc/bloc/close_orders_home_bloc_bloc.dart';
import 'package:start/features/user/home/home_bloc/Navigator/bloc/navigation_bloc.dart';
import 'package:start/features/user/home/view/screen/Close_Orders_Screen.dart';
import 'package:start/features/user/home/view/screen/home.dart';
import 'package:start/features/user/home/view/widgets/Custom_grid.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CategoryBloc(client: NetworkApiServiceHttp())..add(GetCategory()),
        ),
        BlocProvider(
          create: (context) =>
              CloseOrdersHomeBlocBloc(client: NetworkApiServiceHttp())
                ..add(FetchPendingAndInprogressOrders()),
        ),
        // BlocProvider(
        //   create: (context) => NavigationBloc(),
        // ),
      ],
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CloesdOrdersScreen.routeName);
              },
              icon: Icon(
                Icons.notifications,
                color: Colors.black,
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
        ),
        drawer: const Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [LanguageItem(), LogOutItem()],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<CloseOrdersHomeBlocBloc, CloseOrdersHomeBlocState>(
                builder: ((context, state) {
                  switch (state.runtimeType) {
                    // case PendingAndInprogressOrdersHomeLoadingOrdersState:
                    //   return const LoadingWidget();

                    case PendingAndInprogressOrdersHomeLoadedState:
                      final successState =
                          state as PendingAndInprogressOrdersHomeLoadedState;
                      print('ui:${state.isInPending}');
                      print(state.isInProgress);
                      if (state.isInPending == false &&
                          state.isInProgress == false) {
                        return SizedBox.shrink();
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<NavigationBloc>(context)
                                    .add(NavigateToPage(3));
                                BlocProvider.of<NavigationBloc>(context).add(
                                    SelectFilterChip(OrderFilterState.pending));
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => HomePage()),
                                // );
                              },
                              child: Card(
                                color: Colors.blueAccent,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.pending,
                                          size: 40, color: Colors.white),
                                      SizedBox(height: 10),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .pendingOrders,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                print('pressing');
                                BlocProvider.of<NavigationBloc>(context)
                                    .add(NavigateToPage(3));
                                BlocProvider.of<NavigationBloc>(context).add(
                                  SelectFilterChip(OrderFilterState.inProgress),
                                );
                              },
                              child: Card(
                                color: Colors.orangeAccent,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.work,
                                          size: 40, color: Colors.white),
                                      SizedBox(height: 10),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .inProgressOrders,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      break;
                    case ErrorGetDetails:
                      final errorState = state as ErrorGetDetails;
                      return NetworkErrorWidget(
                          message: errorState.message,
                          onPressed: () {
                            BlocProvider.of<CloseOrdersHomeBlocBloc>(context)
                                .add(FetchPendingAndInprogressOrders());
                          });
                      break;
                    default:
                      return const SizedBox();
                  }
                }),
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case LoadingCategory:
                      return const LoadingWidget();

                    case LoadedCategory:
                      final successState = state as LoadedCategory;

                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: GridView.builder(
                          itemCount: successState.categories.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            crossAxisSpacing: 10, // Spacing between columns
                            mainAxisSpacing: 10, // Spacing between rows
                            childAspectRatio: 1, // Aspect ratio of the children
                          ),
                          itemBuilder: (context, index) {
                            return CategoryItem(
                              title: successState.categories[index].name,
                              id: successState.categories[index].id!,
                              imagePath: successState.categories[index].image,
                            );
                          },
                        ),
                      );
                      break;
                    case ErrorGetCategory:
                      final errorstate = state as ErrorGetCategory;
                      return Scaffold(
                        body: NetworkErrorWidget(
                          message: errorstate.message,
                          onPressed: () {
                            BlocProvider.of<CategoryBloc>(context)
                                .add(GetCategory());
                          },
                        ),
                      );
                      break;
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
