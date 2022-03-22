import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '/screens/tabs/feeds.dart';
import '/screens/tabs/profile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/models/user.dart';
import 'tabs/placenames.dart';

List<Color> _mainColor() {
  return [Colors.blue.shade500, Colors.blue.shade700, Colors.blue.shade800];
}

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final storage = const FlutterSecureStorage();

  User a = User(name: "aa");
  int _selectedTab = 0;
  Color _backgroundColorAppbar = Colors.grey.shade200;

  List tabs = [
    {
      'title': 'Feeds',
      'icon': Icons.home_rounded,
      'page': Feeds(),
    },
    {
      'title': 'Placename',
      'icon': Icons.location_on_sharp,
      'page': Placenames(),
    },
    {
      'title': 'Notication',
      'icon': Icons.notifications,
      'page': Text('Đang phát triển'),
    },
    {'title': 'Profile', 'icon': Icons.person, 'page': Profile()},
  ];

  List<IconData> tabIcons = [
    Icons.home_rounded,
    Icons.location_on_sharp,
    Icons.notifications,
    Icons.person
  ];
  void readToken() async {
    String token = await storage.read(key: 'token').toString();
    Provider.of<AuthcubitCubit>(context, listen: false).tryToken(token: token);
    // print(token);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedTab = index;
      if (_selectedTab != 0) {
        _backgroundColorAppbar = Colors.white;
      } else {
        _backgroundColorAppbar = Colors.grey.shade200;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    readToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      body: Center(
        child: tabs.elementAt(_selectedTab)['page'],
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        elevation: 0,
        icons: tabIcons,
        activeIndex: _selectedTab,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        splashColor: Colors.blue.shade800,
        activeColor: Colors.blue.shade800,
        inactiveColor: Colors.grey.shade600,
        iconSize: 25,
        onTap: (index) => setState(
          () => _onItemTapped(index),
          //other params
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        splashColor: Colors.blue,
        backgroundColor: Colors.white,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return RadialGradient(
              center: Alignment.topLeft,
              radius: 1.0,
              colors: _mainColor(),
              tileMode: TileMode.mirror,
            ).createShader(bounds);
          },
          child: const Icon(Icons.add),
        ),
        onPressed: () => Navigator.pushNamed(context, '/creter_post'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
