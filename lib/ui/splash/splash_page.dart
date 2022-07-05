import 'package:code/_res/R.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/_tx_widget/tx_text_widget.dart';
import 'package:code/ui/login/login_page.dart';
import 'package:code/ui/splash/splash_bloc.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends StateWithBloC<SplashPage, SplashBloC> {
  @override
  void initState() {
    super.initState();
    bloc.loadVersion();
    Future.delayed(Duration(seconds: 3), () {
      NavigationUtils.pushReplacement(context, LoginPage());
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: R.color.primaryColor,
      body: Container(
        child: Stack(
          children: [
            Container(child: Image.asset(R.image.splash, fit: BoxFit.cover,), width: double.infinity,height: double.infinity,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        R.image.logoWhite,
                        height: 130,
                        width: 130,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Image.asset(
                        R.image.noysiWhite,
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        constraints: BoxConstraints(maxWidth: 160),
                        padding: EdgeInsets.all(2),
                        height: 6,
                        decoration: BoxDecoration(
                            color: R.color.grayLightColor,
                            borderRadius: BorderRadius.all(Radius.circular(45))),
                        child: LinearProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>(R.color.grayLightColor),
                          backgroundColor: R.color.grayLightestColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder<String>(
                stream: bloc.appVersionResult,
                initialData: "",
                builder: (ctx, snapshotVersion) {
                  return TXTextWidget(
                    text: snapshotVersion.data ?? '',
                    color: Colors.white,
                  );
                },
              ),
              SizedBox(
                height: 50,
              ),
            ],

            )
          ],
        ),
      ),
    );
  }
}
