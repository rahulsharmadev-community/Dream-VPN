import 'package:dreamvpn/model/UserPreference.dart';
import 'package:dreamvpn/routes/proRoute.dart';
import 'package:provider/provider.dart';

import 'pages/accountPage.dart';
import 'pages/homePage.dart';
import '/model/themeCollection.dart';
import 'pages/proPage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ThemeCollection>.value(value: ThemeCollection()),
    ChangeNotifierProvider<UserPreference>.value(value: UserPreference())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dream VPN',
      theme: Provider.of<ThemeCollection>(context).getActiveTheme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;
  final List<Map<String, dynamic>> _itemsList = const [
    {'name': 'Home', 'iconPath': 'assets/home.svg', 'route': HomePage()},
    {'name': 'Pro', 'iconPath': 'assets/logo.svg', 'route': ProPage()},
    {
      'name': 'Account',
      'iconPath': 'assets/profile.svg',
      'route': AccountPage()
    }
  ];

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Provider.of<ThemeCollection>(context).isDarkActive;

    return Scaffold(
        appBar: AppBar(
            shadowColor: Colors.transparent,
            title: currentPage == 2
                ? const Text('My Account')
                : SvgPicture.asset(
                    'assets/text.svg',
                    height: 18,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
            actions: currentPage == 0
                ? [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (builder) => const ProRoute())),
                        child: SvgPicture.asset(
                          'assets/gopro.svg',
                          height: 18,
                        ),
                      ),
                    ),
                  ]
                : null),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
          padding: const EdgeInsets.only(top: 8.0),
          decoration: BoxDecoration(
              color:
                  const Color(0xff353351).withOpacity(isDarkTheme ? 0.3 : 0.05),
              borderRadius: BorderRadius.circular(20)),
          child: BottomNavigationBar(
              enableFeedback: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              selectedLabelStyle:
                  TextStyle(color: Theme.of(context).primaryColor),
              selectedItemColor: Theme.of(context).primaryColor,
              currentIndex: currentPage,
              onTap: (value) => setState(() {
                    currentPage = value;
                  }),
              items: List.generate(
                  _itemsList.length,
                  (index) => BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                            _itemsList[index]['iconPath'] as String,
                            height: index != currentPage ? 20 : 24,
                            color: index != currentPage
                                ? const Color(0xffB5AEBE)
                                : Theme.of(context).primaryColor),
                        label: _itemsList[index]['name'] as String,
                      ))),
        ),
        body: _itemsList[currentPage]['route'] as Widget);
  }
}
