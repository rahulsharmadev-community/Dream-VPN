//ignore_for_file: file_names
import '/routes/proRoute.dart';
import '/routes/settingsRoute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../model/themeCollection.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  customListTile(BuildContext context, String title, String icon,
          {Widget? trailing, String? subtitle, VoidCallback? onTap}) =>
      ListTile(
          onTap: onTap ?? null,
          minLeadingWidth: 35,
          dense: true,
          title:
              Text(title, style: Theme.of(context).primaryTextTheme.subtitle1),
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  style: Theme.of(context).primaryTextTheme.caption,
                )
              : null,
          leading: SvgPicture.asset(
            icon,
            color: Theme.of(context).accentColor,
            width: 24,
            alignment: Alignment.centerRight,
          ),
          trailing: trailing ?? null);

  upgradeButton(context) => GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (builder) => const ProRoute())),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(65),
            gradient: const LinearGradient(
                colors: [Color(0xff6622CC), Color(0xff030026)],
                transform: GradientRotation(5))),
        child: Text(
          'Upgrade',
          style: Theme.of(context)
              .primaryTextTheme
              .bodyText1!
              .copyWith(color: Colors.white),
        ),
      ));

  Divider get divider => const Divider(
      indent: 16, endIndent: 16, color: Colors.grey, thickness: 1);

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Provider.of<ThemeCollection>(context).isDarkActive;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            isDarkTheme
                ? 'assets/darkNoResults.svg'
                : 'assets/lightNoResults.svg',
            width: MediaQuery.of(context).size.width * 0.75,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Looks like You’re not signed in yet.',
              style: Theme.of(context).primaryTextTheme.bodyText1,
            ),
          ),
          FlatButton(
              color: const Color(0xff353351),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(64)),
              onPressed: () {},
              child: const Text('SIGN IN')),
          customListTile(context, 'User ID', 'assets/id.svg',
              subtitle: '284529462',
              trailing: IconButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {},
                  icon: Icon(Icons.copy_all_rounded))),
          divider,
          customListTile(context, 'Base Plan', 'assets/active.svg',
              trailing: upgradeButton(context)),
          divider,
          customListTile(
            context,
            'Restore',
            'assets/history.svg',
          ),
          divider,
          customListTile(context, 'Settings', 'assets/settings.svg',
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => const SettingsRoute())))
        ],
      ),
    );
  }
}
