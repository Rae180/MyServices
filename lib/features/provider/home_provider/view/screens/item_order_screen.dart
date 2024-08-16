import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/features/provider/home_provider/bloc/managecurrentorder_bloc.dart';
import 'package:start/features/provider/order/model/details_order_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemListPage extends StatefulWidget {
  final int id;
  const ItemListPage({super.key, required this.id});

  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  List<Item> items = [];
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _itemControllers = [];
  final List<TextEditingController> _priceControllers = [];

  @override
  void dispose() {
    for (var controller in _itemControllers) {
      controller.dispose();
    }
    for (var controller in _priceControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addNewFields() {
    setState(() {
      _itemControllers.add(TextEditingController());
      _priceControllers.add(TextEditingController());
    });
  }

  void _removeFields(int index) {
    setState(() {
      _itemControllers[index].dispose();
      _priceControllers[index].dispose();
      _itemControllers.removeAt(index);
      _priceControllers.removeAt(index);
    });
  }

  void _saveItems() {
    if (_formKey.currentState!.validate()) {
      items = [];
      for (int i = 0; i < _itemControllers.length; i++) {
        items.add(Item(_itemControllers[i].text,
            (double.tryParse(_priceControllers[i].text) ?? 0.0).toString(),0));
      }
      print(items);
      BlocProvider.of<ManagecurrentorderBloc>(context)
          .add(AdditemEvent(items: items, id: widget.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.addmaterials),
        ),
        body: BlocConsumer<ManagecurrentorderBloc,ManagecurrentorderState>(builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: _itemControllers.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _itemControllers[index],
                                decoration: const InputDecoration(
                                  labelText: 'Item',
                                  labelStyle:
                                      TextStyle(color: Colors.lightGreen),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .lightGreen), // Change this color as needed
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .grey), // Change this color as needed
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an item';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: _priceControllers[index],
                                decoration: const InputDecoration(
                                  labelText: 'Price',
                                  labelStyle:
                                      TextStyle(color: Colors.lightGreen),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .lightGreen), // Change this color as needed
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .grey), // Change this color as needed
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a price';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Please enter a valid number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _removeFields(index);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.lightGreen)),
                        onPressed: _addNewFields,
                        child: const Text(
                          'Add More Fields',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.lightGreen)),
                        onPressed: _saveItems,
                        child: state is LoadingState
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Save Items',
                                style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }, listener: (context, state) {
          if (state is DonemanageState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("sdadsad")));
            Navigator.of(context).pop();
          }
        }));
  }
}
