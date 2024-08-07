import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/features/user/order_details/order_details_bloc/Order_bloc/order_bloc.dart';

import 'package:start/features/user/order_details/view/widgets/the_map.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const routeName = 'order_details_screen';

  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final Descriptionecontroller = TextEditingController();
  final DateController = TextEditingController();
  final TimeController = TextEditingController();
  final MapController = TextEditingController();
  final AdressController = TextEditingController();
  File? image;
  var cordinates;
  var lat;
  var lng;
  List<File>? images = [];

  var dateTime = DateTime.now();

  Future<DateTime?> ShowDate() => showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        initialDate: DateTime.now(),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

  Future pickDateTime() async {
    DateTime? date = await ShowDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() => this.dateTime = dateTime);

    DateController.text = DateFormat.yMMMd().add_jm().format(dateTime);
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        print('image is null');
        return;
      }

      final ImageTemporary = File(image.path);
      setState(() => images!.add(ImageTemporary));
      // setState(() => this.image = ImageTemporary);
      print(image);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
  // String get _selectedOption => AppLocalizations.of(context)!.wallet;

  @override
  Widget build(BuildContext context) {
    var _selectedType = AppLocalizations.of(context)!.schedule;
    var _selectedOption = AppLocalizations.of(context)!.wallet;
    var items = [
      AppLocalizations.of(context)!.cash,
      AppLocalizations.of(context)!.wallet
    ];
    var types = [
      AppLocalizations.of(context)!.instant,
      AppLocalizations.of(context)!.schedule
    ];
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    print(ModalRoute.of(context)?.settings.arguments);
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final providerId = routeArgs['providerId'];

    return BlocProvider(
      create: (context) => OrderBloc(client: NetworkApiServiceHttp()),
      child: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderSucces) {
            Navigator.of(context).pop();
          }
          if (state is OrderError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
              ),
              centerTitle: true,
              title: Text(AppLocalizations.of(context)!.orders),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...images!.map(
                              (image) => Padding(
                                padding: EdgeInsets.all(8),
                                child: image != null
                                    ? DottedBorder(
                                        strokeWidth: 3,
                                        color: const Color.fromARGB(
                                            255, 142, 201, 84),
                                        child: Container(
                                          height: 200,
                                          width: 200,
                                          child: Image.file(
                                            image,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                            DottedBorder(
                              radius: const Radius.circular(
                                20,
                              ),
                              strokeWidth: 3,
                              color: const Color.fromARGB(255, 142, 201, 84),
                              child: InkWell(
                                splashColor: Colors.black12,
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      AppLocalizations.of(context)!
                                          .choseOneOption,
                                    ),
                                    actions: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TextButton(
                                            onPressed: () =>
                                                pickImage(ImageSource.camera),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.camera,
                                                  color: Color.fromARGB(
                                                      255, 143, 201, 101),
                                                  size: 60,
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .camera,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                pickImage(ImageSource.gallery),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.photo_album_outlined,
                                                  color: Color.fromARGB(
                                                      255, 143, 201, 101),
                                                  size: 60,
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .gallery,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  width: 200,
                                  height: 200,
                                  child: image == null
                                      ? const Icon(
                                          Icons.add_a_photo_outlined,
                                          color: Colors.blueGrey,
                                        )
                                      : Image.file(
                                          image!,
                                          width: 170,
                                          height: 170,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: Descriptionecontroller,
                          decoration: InputDecoration(
                            label:  Row(
                              children: [
                                Icon(
                                  Icons.description_outlined,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.description,
                                ),
                              ],
                            ),
                            labelStyle: TextStyle(
                              color: Colors.grey[800],
                            ),
                            fillColor: const Color.fromARGB(8, 0, 0, 0),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 143, 201, 101),
                                  width: 2.0),
                            ),
                          ),
                          cursorColor: Colors.greenAccent,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: AdressController,
                          decoration: InputDecoration(
                            label:  Row(
                              children: [
                                Icon(
                                  Icons.location_city_outlined,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.address,
                                ),
                              ],
                            ),
                            labelStyle: TextStyle(
                              color: Colors.grey[800],
                            ),
                            fillColor: const Color.fromARGB(8, 0, 0, 0),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 143, 201, 101),
                                  width: 2.0),
                            ),
                          ),
                          cursorColor: Colors.greenAccent,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          radius: 20,
                          splashColor: Colors.black12,
                          onTap: pickDateTime,
                          child: TextFormField(
                            enabled: false,
                            controller: DateController,
                            decoration: InputDecoration(
                              label:  Row(
                                children: [
                                  Icon(
                                    Icons.date_range_outlined,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.dateOfBooking,
                                  ),
                                ],
                              ),
                              labelStyle: TextStyle(
                                color: Colors.grey[800],
                              ),
                              fillColor: const Color.fromARGB(8, 0, 0, 0),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 143, 201, 101),
                                    width: 2.0),
                              ),
                            ),
                            cursorColor: Colors.greenAccent,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          radius: 20,
                          splashColor: Colors.black12,
                          onTap: () async {
                            cordinates = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MapScreen(),
                              ),
                            );
                            if (cordinates != null) {
                              lat = cordinates.latitude;
                              lng = cordinates.longitude;

                              final formattedCoordinates =
                                  'Latitude: $lat, Longitude: $lng';
                              setState(() {
                                MapController.text = formattedCoordinates;
                              });
                            }
                          },
                          child: TextFormField(
                            enabled: false,
                            controller: MapController,
                            decoration: InputDecoration(
                              label:  Row(
                                children: [
                                  Icon(
                                    Icons.map_outlined,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.location,
                                  ),
                                ],
                              ),
                              labelStyle: TextStyle(
                                color: Colors.grey[800],
                              ),
                              fillColor: const Color.fromARGB(8, 0, 0, 0),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 143, 201, 101),
                                    width: 2.0),
                              ),
                            ),
                            cursorColor: Colors.greenAccent,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Container(
                          width: double.infinity,
                          height: 58,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                          child: DropdownButton<String>(
                            padding: const EdgeInsets.all(14),
                            items: items.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              print('Selected: $newValue');
                              setState(() {
                                _selectedOption = newValue!;
                              });
                              print('Selecting: $_selectedOption');
                            },
                            value: _selectedOption,
                            borderRadius: BorderRadius.circular(20),
                            underline: Container(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Container(
                          width: double.infinity,
                          height: 58,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                          child: DropdownButton<String>(
                            padding: const EdgeInsets.all(14),
                            items: types.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              print('Selected: $newValue');
                              setState(() {
                                _selectedType = newValue!;
                              });
                              print('Selecting: $_selectedType');
                            },
                            value: _selectedType,
                            borderRadius: BorderRadius.circular(20),
                            underline: Container(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final bool isValid =
                              _formKey.currentState!.validate();
                          FocusScope.of(context).unfocus();
                          print(images);

                          if (isValid) {
                            _formKey.currentState!.save();
                            BlocProvider.of<OrderBloc>(context).add(
                              OrderPostEvent(
                                  type: _selectedType,
                                  providerId: providerId,
                                  image: images!,
                                  adress: AdressController.text.trim(),
                                  descreption:
                                      Descriptionecontroller.text.trim(),
                                  dateTime: dateTime,
                                  longtitude: lng.toString(),
                                  latitude: lat.toString(),
                                  payment: _selectedOption),
                            );
                          }
                        },
                        style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                horizontal: 149, vertical: 12),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 143, 201, 101),
                          ),
                        ),
                        child:  Text(AppLocalizations.of(context)!.bookNow),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
