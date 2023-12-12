// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:xth_app/widgets/list.dart';

void main() {
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFFFFFFFF),
        canvasColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFF3F7FB),
        iconTheme: ThemeData.light().iconTheme.copyWith(
              color: const Color(0xFF373737),
            ),
        textTheme: ThemeData.light().textTheme.apply(
              bodyColor: const Color(0xFF373737),
              displayColor: const Color(0xFF373737),
            ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFFFFC107)),
      ),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.of(context),
            home: const ProfileScreen(),
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(896, 414), allowFontScaling: true);

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: 10.w * 10,
            width: 10.w * 10,
            margin: EdgeInsets.only(top: 10.w * 3),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 10.w * 5,
                  backgroundImage: const AssetImage('assets/images/icon.png'),
                  backgroundColor: const Color(0xFFFFC107),
                  foregroundColor: const Color(0xFFFFC107),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 10.w * 2.5,
                    width: 10.w * 2.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      heightFactor: 10.w * 1.5,
                      widthFactor: 10.w * 1.5,
                      child: const Icon(
                        LineAwesomeIcons.pen,
                        color: Color(0xFF212121),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.w * 2),
          Text(
            'John Doe',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(10.w * 1.7),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.w * 0.5),
          Text(
            'john.doe@example.com',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(10.w * 1.3),
              fontWeight: FontWeight.w100,
            ),
          ),
          SizedBox(height: 10.w * 2),
          Container(
            height: 10.w * 4,
            width: 10.w * 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w * 3),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Center(
              child: Text(
                'Upgrade to PRO',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(10.w * 1.5),
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF212121),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    var themeSwitcher = ThemeSwitcher(
      builder: (context) {
        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState:
              ThemeProvider.of(context).brightness == Brightness.dark
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
          firstChild: GestureDetector(
            onTap: () => ThemeSwitcher.of(context).changeTheme(),
            child: const Icon(
              LineAwesomeIcons.sun,
            ),
          ),
          secondChild: GestureDetector(
            onTap: () => ThemeSwitcher.of(context).changeTheme(),
            child: const Icon(
              LineAwesomeIcons.moon,
            ),
          ),
        );
      },
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 10.w * 3),
        const Icon(
          LineAwesomeIcons.arrow_left,
        ),
        profileInfo,
        themeSwitcher,
        SizedBox(width: 10.w * 3),
      ],
    );

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                SizedBox(height: 10.w * 5),
                header,
                Expanded(
                  child: ListView(
                    children: const <Widget>[
                      List(
                        icon: LineAwesomeIcons.user_shield,
                        text: 'Privacy',
                      ),
                      List(
                        icon: LineAwesomeIcons.history,
                        text: 'Purchase History',
                      ),
                      List(
                        icon: LineAwesomeIcons.question_circle,
                        text: 'Help & Support',
                      ),
                      List(
                        icon: LineAwesomeIcons.cog,
                        text: 'Settings',
                      ),
                      List(
                        icon: LineAwesomeIcons.user_plus,
                        text: 'Invite a Friend',
                      ),
                      List(
                        text: 'Logout',
                        hasNavigation: false,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
