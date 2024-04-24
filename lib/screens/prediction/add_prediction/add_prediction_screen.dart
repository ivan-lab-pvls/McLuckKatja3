import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcluck_app/models/prediction_model.dart';
import 'package:mcluck_app/router/router.dart';
import 'package:mcluck_app/screens/prediction/prediction_bloc/prediction_bloc.dart';
import 'package:mcluck_app/theme/colors.dart';
import 'package:mcluck_app/widgets/action_button_widget.dart';
import 'package:mcluck_app/widgets/button_selection_component.dart';
import 'package:mcluck_app/widgets/textfield_app_widget.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

@RoutePage()
class AddPredictionScreen extends StatefulWidget {
  const AddPredictionScreen({super.key});

  @override
  State<AddPredictionScreen> createState() => _AddPredictionScreenState();
}

class _AddPredictionScreenState extends State<AddPredictionScreen> {
  final List<String> messages = [
    'You are a good bluffer and have a lot of experience in the game - this will increase your likelihood of winning!',
    'You are a bluffer with experience in the game - this could influence your likelihood of winning.',
    'You are a good bluffer and have a lot of experience in the game - this will increase your likelihood of winning!'
  ];

  final controller = PageController();

  int _currentIndex = 0;

  final dateController = TextEditingController();
  DateTime date = DateTime.now();

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (_picked != null) {
      date = _picked;
      setState(() {
        dateController.text = _picked.toString().split(' ')[0];
      });
    }
  }

  final List<String> games = [
    'Poker',
    'Baccarat',
    'Brag',
    'Badugi',
    'Texas hold\'em',
    'Pai Gow poker'
  ];
  String game = '';

  final amountController = TextEditingController();

  final List<String> opponents = ['1', '2', '3', '4', '5', '5+'];
  String opponent = '';

  final List<String> levels = [
    'Novice',
    'Beginner',
    'Intermediate',
    'Advanced',
    'Expert',
    'Grandmaster'
  ];
  String level = '';

  String bluffAnswer = '';

  final timesWonController = TextEditingController();

  final List<String> colors = [
    'Red',
    'Green',
    'Blue',
    'Black',
    'Yellow',
    'Idon’t know'
  ];
  String color = '';

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'New prediction',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 34,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${_currentIndex + 1}/7',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: StepProgressIndicator(
                            totalSteps: 7,
                            currentStep: _currentIndex + 1,
                            selectedColor: AppColors.accentGreen,
                            unselectedColor: Colors.grey,
                            size: 6,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  controller: controller,
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Please enter a date',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  style: TextStyle(color: AppColors.white),
                                  controller: dateController,
                                  readOnly: true,
                                  onTap: () {
                                    _selectDate();
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Date',
                                    hintStyle:
                                        TextStyle(color: AppColors.lightGrey),
                                    filled: true,
                                    fillColor: AppColors.grey,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 12),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            ActionButtonWidget(
                                text: 'Next',
                                width: MediaQuery.of(context).size.width * 0.8,
                                onTap: () {
                                  if (dateController.text.isNotEmpty) {
                                    controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.accentRed,
                                        content: Text(
                                          'Firstly, enter information',
                                          style:
                                              TextStyle(color: AppColors.white),
                                        ),
                                      ),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Select a game',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ButtonSelectionComponent(
                                    buttonValues: games, value: game),
                              ],
                            ),
                            SizedBox(height: 20),
                            ActionButtonWidget(
                                text: 'Next',
                                width: MediaQuery.of(context).size.width * 0.8,
                                onTap: () {
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                }),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextFieldAppWidget(
                              controller: amountController,
                              title: 'Your bank',
                              hintText: 'Sum',
                            ),
                            SizedBox(height: 20),
                            ActionButtonWidget(
                                text: 'Next',
                                width: MediaQuery.of(context).size.width * 0.8,
                                onTap: () {
                                  if (amountController.text.isNotEmpty &&
                                      int.tryParse(amountController.text) !=
                                          null) {
                                    controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.accentRed,
                                        content: Text(
                                          'Firstly, enter information',
                                          style:
                                              TextStyle(color: AppColors.white),
                                        ),
                                      ),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'How many opponents do you have?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ButtonSelectionComponent(
                                    buttonValues: opponents, value: opponent),
                              ],
                            ),
                            SizedBox(height: 20),
                            ActionButtonWidget(
                                text: 'Next',
                                width: MediaQuery.of(context).size.width * 0.8,
                                onTap: () {
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                }),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'What is your level of play?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ButtonSelectionComponent(
                                    buttonValues: levels, value: level),
                              ],
                            ),
                            SizedBox(height: 20),
                            ActionButtonWidget(
                                text: 'Next',
                                width: MediaQuery.of(context).size.width * 0.8,
                                onTap: () {
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                }),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Can you bluff?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ButtonSelectionComponent(
                                    buttonValues: ['Yes', 'No'],
                                    value: bluffAnswer),
                              ],
                            ),
                            SizedBox(height: 15),
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Have you won when you bluffed?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ButtonSelectionComponent(
                                    buttonValues: ['Yes', 'No'],
                                    value: bluffAnswer),
                              ],
                            ),
                            SizedBox(height: 15),
                            TextFieldAppWidget(
                                controller: timesWonController,
                                title: 'How many times have you won?',
                                hintText: 'Quantity'),
                            SizedBox(height: 25),
                            ActionButtonWidget(
                                text: 'Next',
                                width: MediaQuery.of(context).size.width * 0.8,
                                onTap: () {
                                  if (timesWonController.text.isNotEmpty &&
                                      int.tryParse(timesWonController.text) !=
                                          null) {
                                    controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.accentRed,
                                        content: Text(
                                          'Firstly, enter information',
                                          style:
                                              TextStyle(color: AppColors.white),
                                        ),
                                      ),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'What color is the card table?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ButtonSelectionComponent(
                                    buttonValues: colors, value: color),
                              ],
                            ),
                            SizedBox(height: 20),
                            ActionButtonWidget(
                                text: 'Next',
                                width: MediaQuery.of(context).size.width * 0.8,
                                onTap: () {
                                  final double percent =
                                      Random().nextDouble() * 100;
                                  final double roundedPercent =
                                      double.parse(percent.toStringAsFixed(2));

                                  String message = '';

                                  if (roundedPercent < 30) {
                                    message = messages[2];
                                  } else if (30.01 > roundedPercent &&
                                      roundedPercent < 70) {
                                    message = messages[1];
                                  } else {
                                    message = messages[0];
                                  }

                                  context.read<PredictionBloc>().add(
                                      AddPredictionEvent(
                                          prediction: PredictionModel(
                                              prediction: roundedPercent,
                                              message: message)));
                                  context.router.push(HomeRoute());
                                }),
                          ],
                        ),
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
