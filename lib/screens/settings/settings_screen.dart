import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:mcluck_app/router/router.dart';
import 'package:mcluck_app/theme/colors.dart';
import 'package:mcluck_app/widgets/app_container.dart';
import 'package:share_plus/share_plus.dart';

class Termxa extends StatelessWidget {
  final String usage;

  const Termxa({Key? key, required this.usage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(usage)),
        ),
      ),
    );
  }
}

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      appBar: AppBar(
        backgroundColor: AppColors.bgBlack,
        leadingWidth: 110,
        leading: GestureDetector(
          onTap: () {
            context.router.push(HomeRoute());
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios_new, color: AppColors.accentGreen),
                SizedBox(width: 4),
                Text(
                  'Back',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: AppColors.accentGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 34,
                    color: AppColors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Stack(
                  children: [
                    AppContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Give us 5 star!',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: AppColors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  'Your feedback helps us to improve',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: AppColors.lightGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset('assets/images/settings/image.png'))
                  ],
                ),
              ),
              SizedBox(height: 15),
              AppContainer(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const Termxa(
                              usage:
                                  'https://docs.google.com/document/d/18TyQmVnIW27dcCniF1rJXeZjqDXnFGI9_4eE-Ykxj6I/edit?usp=sharing',
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Terms & Conditions',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.lightGrey,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 20, color: AppColors.white)
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(thickness: 0.2, color: AppColors.lightGrey),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const Termxa(
                              usage:
                                  'https://docs.google.com/document/d/10wnBGL2v3Ltiq219H-SG-KtOdXBm_1g-SKLOgEBpxb0/edit?usp=sharing',
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Privacy Policy',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.lightGrey,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 20, color: AppColors.white)
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(thickness: 0.2, color: AppColors.lightGrey),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const Termxa(
                              usage: 'https://forms.gle/S2b4ueZev8qeUoYGA',
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Support Page',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.lightGrey,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 20, color: AppColors.white)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              AppContainer(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        InAppReview.instance
                            .openStoreListing(appStoreId: '6499268030');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rate Us',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.lightGrey,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 20, color: AppColors.white)
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(thickness: 0.2, color: AppColors.lightGrey),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        _share();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Share App',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.lightGrey,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 20, color: AppColors.white)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _share() async {
  final deviceData = DeviceInfoPlugin();
  if (Platform.isIOS) {
    final iosDeviceInfo = await deviceData.iosInfo;
    if (iosDeviceInfo.model.contains('iPad')) {
      Share.share(
        'Download Poker prediction - Take luck in AppStore!',
        sharePositionOrigin: Rect.fromLTWH(0, 0, 100, 100),
      );
    } else {
      Share.share(
        'Download Poker prediction - Take luck in AppStore!',
      );
    }
  } else {
    Share.share(
      'Download Poker prediction - Take luck in AppStore! https://apps.apple.com/us/app/the-cbep-my-pocket/id6499197177',
    );
  }
}
