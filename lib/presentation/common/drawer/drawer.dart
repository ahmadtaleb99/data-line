import 'package:datalines/app/authtication_bloc/authentication_bloc.dart';
import 'package:datalines/presentation/resources/assets_manager.dart';
import 'package:datalines/presentation/resources/color_manager.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:  ColorManager.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
           DrawerHeader(
            decoration: BoxDecoration(
              color: ColorManager.white,
            ),
            child: Image.asset(ImageAssets.flexLogo),

          ),

          ListTile(
            title: const Text(AppStrings.logout),
            leading: const Icon(Icons.logout),
            onTap: () {
              context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
            },
          ),
        ],
      ),
    );
  }
}
