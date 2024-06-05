import 'package:acquire_lms_mobile_app/config/app_router.gr.dart';
import 'package:acquire_lms_mobile_app/provider/login_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildAppDrawer extends StatelessWidget {
  const BuildAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Books'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          // Add other ListTiles for the rest of the menu items
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Book Request'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.collections_bookmark),
            title: const Text('Book Collection'),
            onTap: () {
              //  CollectionRoute here
              context.router.replace(const CollectionScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text('Book Catalog'),
            onTap: () {
              context..router.navigate(const CatalogScreen());
              
            },
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Department Curriculum'),
            onTap: () {
              // context.pushRoute(LibraryCardScreen(user: user)); 
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
            onTap: () async {
              await loginProvider.signOutUser();
                Navigator.pop(context); // This pops the drawer
                // Add navigation to the login screen or home screen
                context.router.replace(const LoginRoute());
            },
          ),
        ],
      ),
    );
  }
}