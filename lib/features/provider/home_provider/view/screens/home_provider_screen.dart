import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:start/features/provider/home_provider/bloc/home_provider_bloc.dart';
import 'package:start/features/provider/home_provider/bloc/submit_location_provider_bloc.dart';
import 'package:start/features/provider/home_provider/view/screens/working_screen.dart';
import 'package:start/main.dart';

class HomeProviderPage extends StatefulWidget {
  static const routeName = 'Home_page_provider';
  const HomeProviderPage({super.key});

  @override
  State<HomeProviderPage> createState() => _HomeProviderPageState();
}

class _HomeProviderPageState extends State<HomeProviderPage> {
  int _selectedIndex = 0;


    @override
  void initState() {
    print('jajhfjahsjhashfashfjsahfahfash');
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      PermissionStatus status = await  Permission.locationAlways.request();

      if (status == PermissionStatus.granted) {
        print('starting submiting location');
        BlocProvider.of<SubmitLocationProviderBloc>(
                navigatorKey.currentState!.overlay!.context)
            .add(StartSubmittingLocation());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeProviderBloc, HomeProviderState>(
      builder: (context, state) {
        if (state is ChangeindexbuttonbarState) {
          _selectedIndex = state.index;
        }
        return Scaffold(
          body: _selectedIndex == 0
              ? const WorkingScreen()
              : _selectedIndex == 1
                  ? Container(
                      child: const Center(
                        child: Text("NOTIFICATIONS"),
                      ),
                    )
                  : Container(
                      child: const Center(
                        child: Text("SETTINGS"),
                      ),
                    ),
          bottomNavigationBar: FlashyTabBar(
            selectedIndex: _selectedIndex,
            showElevation: true,
            onItemSelected: (index) {
              BlocProvider.of<HomeProviderBloc>(context)
                  .add(Changeindexbuttonbar(index: index));
            },
            items: [
              FlashyTabBarItem(
                icon: const Icon(Icons.home),
                title: const Text('home'),
              ),
              FlashyTabBarItem(
                icon: const Icon(Icons.notifications),
                title: const Text('Notification'),
              ),
              FlashyTabBarItem(
                icon: const Icon(Icons.settings),
                title: const Text('Settings'),
              ),
            ],
          ),
        );
      },
    );
  }
}
