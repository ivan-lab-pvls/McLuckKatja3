import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcluck_app/models/prediction_model.dart';
import 'package:mcluck_app/router/router.dart';
import 'package:mcluck_app/screens/prediction/prediction_bloc/prediction_bloc.dart';
import 'package:mcluck_app/theme/colors.dart';
import 'package:mcluck_app/widgets/action_button_widget.dart';

@RoutePage()
class PredictionListScreen extends StatefulWidget {
  const PredictionListScreen({super.key});

  @override
  State<PredictionListScreen> createState() => _PredictionListScreenState();
}

class _PredictionListScreenState extends State<PredictionListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) =>
          PredictionBloc()
            ..add(GetAllPredictionEvent()),
          child: BlocConsumer<PredictionBloc, PredictionState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is EmptyPredictionListState) {
                return SafeArea(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50),
                        Image.asset(
                          'assets/images/predictions/empty-image.png',
                          width: 250,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Get your prediction',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Answer the questions and get your poker prediction!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: AppColors.lightGrey,
                          ),
                        ),
                        SizedBox(height: 40),
                        ActionButtonWidget(
                            text: 'Start',
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.8,
                            onTap: () {
                              context.router.push(AddPredictionRoute());
                            }),
                      ],
                    ),
                  ),
                );
              } else if (state is LoadedAllPredictionState) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Your prediction',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.predictions.length,
                          separatorBuilder:
                              (BuildContext context, int index) =>
                          const SizedBox(height: 15),
                          itemBuilder: (BuildContext context, int index) {
                            final PredictionModel _prediction =
                            state.predictions[index];
                            return Center(
                              child: Container(
                                height: 225,
                                width:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.9,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                        height: 225,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width *
                                            0.9,
                                        child: Image.asset(
                                            'assets/images/predictions/card.png')),
                                    SizedBox(
                                      height: 225,
                                      width:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          0.9,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'win',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                              color: AppColors.accentGreen,
                                            ),
                                          ),
                                          Text(
                                            '${_prediction.prediction}\%',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 36,
                                              color: AppColors.accentGreen,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          SizedBox(
                                            width: 200,
                                            child: Divider(
                                                thickness: 1,
                                                color: AppColors.lightGrey),),
                                          SizedBox(height: 10),
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              _prediction.message,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: AppColors.lightGrey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                      SizedBox(height: 20),
                      ActionButtonWidget(
                          text: 'New predictions', width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.8, onTap: () {
                        context.router.push(AddPredictionRoute());
                      })
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
