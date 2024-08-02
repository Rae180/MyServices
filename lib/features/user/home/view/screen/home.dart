import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:start/core/ui/language_item.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:start/features/user/Favorites/view/Screen/Favorites_screen.dart';
import 'package:start/features/user/Orders/view/screen/Orders_screen.dart';
import 'package:start/features/user/Profile/view/screen/Profie_screen.dart';
import 'package:start/features/user/Settings/view/screen/Settings_screen.dart';
import 'package:start/features/user/home/home_bloc/Navigator/bloc/navigation_bloc.dart';
import 'package:start/features/user/home/view/screen/Home_page_Screen.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'Home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currenIndex = 0;

  final List<Widget> _pages = [
    const HomePageScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
    const OrdersScreen(),
    const SettingsScreen(),
  ];
  //Navigator.of(cotnext).push(MaterialPageRoute() => Categor() )
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
          builder: ((context, state) {
            print('Current Page: ${state.currentPage}');
            return SalomonBottomBar(
              currentIndex: state.currentPage,
              onTap: (i) {
                print('i is :$i');
                BlocProvider.of<NavigationBloc>(context).add(NavigateToPage(i));
              },
              //=> setState(() => _currenIndex = i),
              items: [
                SalomonBottomBarItem(
                  selectedColor: const Color.fromARGB(255, 143, 201, 101),
                  icon: const Icon(
                    Icons.home_outlined,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.home,
                  ),
                ),
                SalomonBottomBarItem(
                  selectedColor: const Color.fromARGB(255, 143, 201, 101),
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.favorites,
                  ),
                ),
                SalomonBottomBarItem(
                  selectedColor: const Color.fromARGB(255, 143, 201, 101),
                  icon: const Icon(
                    Icons.person_2_outlined,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.profile,
                  ),
                ),
                SalomonBottomBarItem(
                  selectedColor: const Color.fromARGB(255, 9, 10, 9),
                  icon: const Icon(
                    Icons.request_page_outlined,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.orders,
                  ),
                ),
                SalomonBottomBarItem(
                  selectedColor: const Color.fromARGB(255, 143, 201, 101),
                  icon: const Icon(
                    Icons.settings_outlined,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.settings,
                  ),
                ),
              ],
            );
          }),
        ),
        body: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
          print('Rendering Page: ${state.currentPage}');
          return _pages[state.currentPage];
        }),
      ),
    );
  }
}
