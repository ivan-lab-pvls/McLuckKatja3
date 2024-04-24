import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:mcluck_app/router/router.dart';
import 'package:mcluck_app/screens/prediction/prediction_list/prediction_list_screen.dart';
import 'package:mcluck_app/screens/profile/profile_screen.dart';
import 'package:mcluck_app/theme/colors.dart';
import 'package:mcluck_app/widgets/button_selection_component.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = PageController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      appBar: AppBar(
        backgroundColor: AppColors.bgBlack,
        leadingWidth: 110,
        leading: GestureDetector(
          onTap: () {
            context.router.push(SettingsRoute());
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                Text(
                  'Settings',
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
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Poker predictions',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 34,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              FlutterToggleTab(
                height: 35,
                width: MediaQuery.of(context).size.width * 0.22,
                borderRadius: 8,
                selectedBackgroundColors: [AppColors.white],
                unSelectedBackgroundColors: [AppColors.grey],
                selectedTextStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.accentRed,
                ),
                unSelectedTextStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.lightGrey,
                ),
                labels: ['My Prediction', 'Profile'],
                selectedIndex: _currentIndex,
                selectedLabelIndex: (index) {
                  _currentIndex = index;
                  if (_currentIndex == 0) {
                    controller.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  } else {
                    controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  }
                },
              ),
              SizedBox(height: 15),
              Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {});
                  },
                  controller: controller,
                  children: [
                    PredictionListScreen(),
                    ProfileScreen(),
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

