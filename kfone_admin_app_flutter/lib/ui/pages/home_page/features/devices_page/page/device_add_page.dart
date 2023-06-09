import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/devices_page/page/device_add_page_arguments.dart';

import '../../../../../../util/ui_util.dart';
import '../../../../../widgets/common/error_page.dart';
import '../../../../../widgets/common/unauthorized_widget.dart';
import '../../../bloc/home_page_bloc.dart';
import '../../../page/home_page.dart';
import '../../../page/home_page_arguements.dart';
import '../bloc/device_page_bloc.dart';

class DeviceAddPage extends StatelessWidget {
  static const String routeName = "/devices/add";

  DeviceAddPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _imageUriController = TextEditingController();
  final _qtyController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  void _submitForm(BuildContext context) async {
    String name = _nameController.text;
    String imageUri = _imageUriController.text;
    int qty = int.parse(_qtyController.text.toString());
    String description = _descriptionController.text;
    double price = double.parse(_priceController.text.toString());

    context.read<DevicePageBloc>().add(
          CreateDevice(
            name: name,
            imageUri: imageUri,
            qty: qty,
            description: description,
            price: price,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final DeviceAddPageArguments args =
        ModalRoute.of(context)!.settings.arguments as DeviceAddPageArguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Device'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<HomePageBloc>(
                create: (BuildContext context) => HomePageBloc()
                  ..add(
                    CheckAccess(drawerItem: args.drawerItem),
                  ),
              ),
              BlocProvider<DevicePageBloc>(
                  create: (BuildContext context) => DevicePageBloc()),
            ],
            child: BlocBuilder<HomePageBloc, HomePageState>(
                builder: (context, state) {
              if (state is HomePageInitial || state is Loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is Authorized) {
                return _createBody(args);
              } else if (state is Unauthorized) {
                return const UnauthorizedWidget();
              } else {
                return ErrorPage(
                  buttonText: 'Try Again',
                  onPressed: () {},
                );
              }
            }),
          ),
        ),
      ),
    );
  }

  BlocListener<DevicePageBloc, DevicePageState> _createBody(
      DeviceAddPageArguments arguments) {
    return BlocListener<DevicePageBloc, DevicePageState>(
      listener: (context, state) {
        if (state is CreateDeviceSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            UiUtil.getSnackBar("Device Created Successfully"),
          );

          Navigator.pushNamed(
            context,
            HomePage.routeName,
            arguments: HomePageArguments(arguments.sessionToken,
                drawerItem: arguments.drawerItem),
          );
        } else if (state is DevicePageError) {
          ScaffoldMessenger.of(context).showSnackBar(
            UiUtil.getSnackBar("Device Creation Failed"),
          );
        }
      },
      child: BlocBuilder<DevicePageBloc, DevicePageState>(
          builder: (context, state) {
        if (state is DevicePageLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextFormField(
                  controller: _imageUriController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Image URL',
                  ),
                ),
                TextFormField(
                  controller: _qtyController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                  ),
                ),
                TextFormField(
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Descpription',
                  ),
                ),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => _submitForm(context),
                  child: const Text('Submit'),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
