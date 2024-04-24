import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mcluck_app/router/router.dart';
import 'package:mcluck_app/theme/colors.dart';
import 'package:mcluck_app/widgets/action_button_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/onboarding/onboarding-bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      isLastPage = index == 1;
                    });
                  },
                  controller: controller,
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/onboarding/1.png'),
                          Text(
                            'Your poker predictor',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 34,
                              color: AppColors.white,
                            ),
                          ),
                          Text(
                            'Answer the questions and get your true prediction!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: AppColors.lightGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/onboarding/2.png'),
                          Text(
                            'Be confident of victory',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 34,
                              color: AppColors.white,
                            ),
                          ),
                          Text(
                            'Using our application, analyze your victory and be confident in it',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: AppColors.lightGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ActionButtonWidget(
                  text: 'Continue',
                  width: MediaQuery.of(context).size.width * 0.8,
                  onTap: () {
                    isLastPage ? context.router.push(HomeRoute()) :
                    controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  }),
              SmoothPageIndicator(
                controller: controller,
                count: 2,
                effect: WormEffect(
                  activeDotColor: AppColors.accentGreen,
                  dotColor: AppColors.lightGrey,
                  dotHeight: 4,
                  dotWidth: MediaQuery.of(context).size.width * 0.1,
                  radius: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
