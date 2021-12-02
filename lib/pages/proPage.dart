//ignore_for_file: file_names
import 'package:dreamvpn/model/themeCollection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProPage extends StatelessWidget {
  const ProPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> _list = [
      {
        'title': 'Anonymous',
        'icon': 'assets/fi-sr-incognito.svg',
        'description': 'Hide your ip with anonymous surfing'
      },
      {
        'title': 'Fast',
        'icon': 'assets/fi-sr-rocket.svg',
        'description': 'Up to 1000 Mb/s bandwidth to explore'
      },
      {
        'title': 'Remove Ads',
        'icon': 'assets/fi-sr-add.svg',
        'description': 'Enjoy the app without annoying ads'
      },
      {
        'title': 'Secure',
        'icon': 'assets/fi-sr-shield-check.svg',
        'description': 'Transfer traffic via encrypted tunnel'
      }
    ];
    bool isDarkTheme = Provider.of<ThemeCollection>(context).isDarkActive;
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          SvgPicture.asset(
            'assets/logo.svg',
            cacheColorFilter: true,
          ),
          const SizedBox(height: 12),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Pro ',
                  style: TextStyle(
                      fontFamily: 'Aquire',
                      color: isDarkTheme ? Colors.white : Colors.black,
                      fontSize: 24),
                  children: const [
                    TextSpan(
                        text: 'Features',
                        style: TextStyle(
                            fontFamily: 'Roboto', fontWeight: FontWeight.w500))
                  ])),
          const SizedBox(height: 32),
          GridView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 16 / 9,
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 24),
              children: List.generate(
                  _list.length,
                  (index) => Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(_list[index]['icon'] as String),
                              const SizedBox(width: 8.0),
                              Text(
                                _list[index]['title'] as String,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline6,
                              )
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text(_list[index]['description'] as String,
                              overflow: TextOverflow.fade,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText2)
                        ],
                      ))),
          decoratedButton(context, '1 MONTH', '9.99', '\$/month', false),
          decoratedButton(context, '1 YEAR', '4.99', '\$/month', true),
          GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              height: kToolbarHeight,
              margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(65),
                  color: const Color(0xff353351).withOpacity(0.3)),
              child: Text(
                'TRY FOR FREE',
                style: Theme.of(context).primaryTextTheme.headline6!.copyWith(
                    color: isDarkTheme ? null : const Color(0xff828282)),
              ),
            ),
          ),
          Text(
            '7-day free trial. Then 9.99 \$/month',
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.caption,
          ),
        ],
      ),
    );
  }

  Container decoratedButton(BuildContext context, String lt, String rt_1,
      String rt_2, bool isDiscount) {
    return Container(
      height: kToolbarHeight,
      margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(65),
          gradient: const LinearGradient(
              colors: [Color(0xff6622CC), Color(0xff030026)],
              transform: GradientRotation(5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                lt,
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
              if (isDiscount)
                Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Text(
                    '50% OFF',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
            ],
          ),
          RichText(
              text: TextSpan(
                  text: rt_1,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline6!
                      .copyWith(color: Colors.white),
                  children: [
                TextSpan(
                  text: ' $rt_2',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                )
              ])),
        ],
      ),
    );
  }
}
