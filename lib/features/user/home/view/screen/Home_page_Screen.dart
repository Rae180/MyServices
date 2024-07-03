import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/language_item.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/core/ui/logout_item.dart';
import 'package:start/features/user/home/home_bloc/Category_bloc/category_bloc.dart';
import 'package:start/features/user/home/view/screen/Close_Orders_Screen.dart';
import 'package:start/features/user/home/view/widgets/Custom_grid.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryBloc(client: NetworkApiServiceHttp())..add(GetCategory()),
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
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case LoadingCategory:
                return const LoadingWidget();

              case LoadedCategory:
                final successState = state as LoadedCategory;

                return Scaffold(
                  body: Column(
                    children: [
                      Expanded(
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
                      )
                    ],
                  ),
                );
                break;
              case ErrorGetCategory:
                final errorstate = state as ErrorGetCategory;
                return Scaffold(
                  body: NetworkErrorWidget(
                    message: errorstate.message,
                    onPressed: () {
                      BlocProvider.of<CategoryBloc>(context).add(GetCategory());
                    },
                  ),
                );
                break;
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
