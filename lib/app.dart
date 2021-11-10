import 'package:flutter/material.dart';

import 'screens/cosmos/cosmos_screen.dart';
import 'screens/settings/settings.dart';
import 'components/sidenav/side_navigation_bar.dart';
import 'components/sidenav/side_navigation_bar_item.dart';

import 'screens/solana/solana_screen.dart';
import 'services/blockchain_starter.dart';

GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

class BlockchainStarterApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    printTextInConsole("building UI");
    return MaterialApp(
      title: 'Blockchain Starter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(title: 'Blockchain Starter'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> views = [
    SolanaScreen(),
    CosmosScreen(),
    SettingsScreen(),
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _showDrawer(context);
  }

  void _showDrawer(BuildContext context) async {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          SideNavigationBar(
            selectedIndex: selectedIndex,
            items: const [
              SideNavigationBarItem(
                icon: Icons.dashboard,
                label: 'Solana',
              ),
              SideNavigationBarItem(
                icon: Icons.person,
                label: 'Cosmos',
              ),
              SideNavigationBarItem(
                icon: Icons.settings,
                label: 'Settings',
              ),
            ],
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: views.elementAt(selectedIndex),
          )
        ],
      ),
    );
  }
}
