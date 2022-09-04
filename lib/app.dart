import 'dart:async';
import 'dart:io';
import 'package:code/_res/values/text/custom_localizations_delegate.dart';
import 'package:code/data/connectivity_manager.dart';
import 'package:code/ui/_tx_widget/tx_alert_dialog.dart';
import 'package:flash/flash.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:code/app_bloc.dart';
import 'package:code/data/api/remote/remote_constants.dart';
import 'package:code/data/in_memory_data.dart';
import 'package:code/domain/app_common_model.dart';
import 'package:code/ui/_base/bloc_global.dart';
import 'package:code/ui/_base/bloc_state.dart';
import 'package:code/ui/_base/navigation_utils.dart';
import 'package:code/ui/home/home_page.dart';
import 'package:code/ui/team/team_page.dart';
import 'package:code/utils/toast_util.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:ui' as ui;
import 'package:code/utils/extensions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:uni_links/uni_links.dart';
import '_res/R.dart';
import 'domain/team/team_model.dart';
import 'fcm/i_fcm_controller.dart';

class NoysiApp extends StatefulWidget {
  final Widget initPage;
  final IFCMController fcmController;
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  const NoysiApp(
      {Key? key, required this.initPage, required this.fcmController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoysiApp();
}

class _NoysiApp extends StateWithBloC<NoysiApp, AppBloC>
    with WidgetsBindingObserver {
  final localizationDelegate = CustomLocalizationsDelegate();
  StreamSubscription? _intentDataMediaStreamSubscription;
  StreamSubscription? _intentDataTextStreamSubscription;
  StreamSubscription? _intentDataLinksStreamSubscription;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print(state);
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed || state == AppLifecycleState.inactive) {
      InMemoryData.isInForeground = true;
    } else {
      InMemoryData.isInForeground = false;
    }
  }

  bool hasInternet = true;
  FlashController? snackBarController;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((value) async {
      await bloc.loadLang();
    });
    widget.fcmController.setUp();
    ConnectivityManager.initConnectivityAndInternetCheckerWithListeners();
    WidgetsBinding.instance.addObserver(this);

    teamThemeController.listen((event) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor:
              event.colors.primaryHeaderColor));
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    initPlatformState();
    hasInternetController.listen((connection) {
      if (hasInternet != connection && InMemoryData.isInForeground) {
        if (!(snackBarController?.isDisposed ?? true)) {
          snackBarController?.dismiss();
        }
        hasInternet = connection;
        hasInternet
            ? txShowInternetEstablished(NoysiApp.navigatorKey.currentContext!,
                controllerCallBack: (controller) {
                snackBarController = controller;
              })
            : txShowInternetLost(NoysiApp.navigatorKey.currentContext!,
                controllerCallBack: (controller) {
                snackBarController = controller;
              });
      }
    });
  }

  // @override
  // void didChangeLocales(List<Locale> locale) {
  //   bloc.setLang(locale[0].languageCode, locale[0].scriptCode);
  // }

  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    _intentDataMediaStreamSubscription?.cancel();
    _intentDataTextStreamSubscription?.cancel();
    _intentDataLinksStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) => _getRefreshConfig(context);


  Widget _getRefreshConfig(BuildContext context) {
    return RefreshConfiguration(
        headerBuilder: () => MaterialClassicHeader(),
        // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
        footerBuilder: () => ClassicFooter(),
        // Configure default bottom indicator
        headerTriggerDistance: 80.0,
        // header trigger refresh trigger distance
        springDescription:
            SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
        // custom spring back animate,the props meaning see the flutter api
        maxOverScrollExtent: 100,
        //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
        maxUnderScrollExtent: 0,
        // Maximum dragging range at the bottom
        enableScrollWhenRefreshCompleted: true,
        //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
        enableLoadingWhenFailed: true,
        //In the case of load failure, users can still trigger more loads by gesture pull-up.
        hideFooterWhenNotFull: false,
        // Disable pull-up to load more functionality when Viewport is less than one screen
        enableBallisticLoad: true,
        // trigger load more by BallisticScrollActivity
        child: _getMaterialApp(context));
  }

  Widget _getMaterialApp(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    return StreamBuilder<AppSettingsModel?>(
      stream: languageCodeResult,
      initialData: AppSettingsModel(languageCode: RemoteConstants.defLang, isDarkMode: false),
      builder: (context, snapshotSettings) {
        return StreamBuilder<TeamTheme>(
            stream: teamThemeController.stream,
            initialData: R.color.defaultTheme,
            builder: (context, snapshot) {
              return MaterialApp(
                navigatorKey: NoysiApp.navigatorKey,
                debugShowCheckedModeBanner: false,
                navigatorObservers: [
                  FirebaseAnalyticsObserver(analytics: analytics),
                ],
                builder: (BuildContext context, Widget? child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaleFactor: Platform.isAndroid ? .85 : .9),
                    child: child!,
                  );
                },
                theme: _getThemData(snapshot.data!),
                darkTheme: _getThemData(snapshot.data!),
                localizationsDelegates: [
                  RefreshLocalizations.delegate,
                  localizationDelegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  SfGlobalLocalizations.delegate
                ],
                supportedLocales: localizationDelegate.supportedLocales,
                localeResolutionCallback: localizationDelegate.resolution(
                  fallback: _getLanguageCode(snapshotSettings.data!.languageCode),
                ),
                locale: _getLanguageCode(snapshotSettings.data!.languageCode),
                home: widget.initPage,
                routes: {
                  NavigationUtils.HomeRoute: (context) => HomePage(),
                },
                onGenerateRoute: (settings) {
                  if (settings.name == NavigationUtils.TeamsRoute) {
                    TeamPageArguments? args;
                    if (settings.arguments != null) {
                      args = settings.arguments as TeamPageArguments;
                    }
                    return MaterialPageRoute(
                        settings: RouteSettings(name: NavigationUtils.TeamsRoute),
                        builder: (_) => TeamPage(
                          memberDisabled: args?.memberDisabledEnabledModel,
                          isFromLogin: args?.fromLogin ?? false,
                          key: args?.key,
                        ));
                  }
                  assert(false, 'Need to implement ${settings.name}');
                  return null;
                },
                initialRoute: NavigationUtils.HomeRoute,
                title: R.string.appName,
//      initialRoute: AppRoutes.SPLASH,
//      routes: AppRoutes.routes(),
              );
            });
      }
    );
  }

  Locale _getLanguageCode(String languageCode) {
    return ui.Locale.fromSubtags(
        languageCode:
            languageCode == "tc" || languageCode == "sc" ? "zh" : languageCode,
        scriptCode: languageCode == 'tc'
            ? "Hant"
            : languageCode == "sc"
                ? "Hans"
                : null);
  }

  ThemeData _getThemData(TeamTheme teamTheme) {
    return ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: teamTheme.colors.textColor),
          backgroundColor: teamTheme.colors.primaryHeaderColor,
        ),
        brightness: Brightness.light,
        fontFamily: RemoteConstants.fontFamily,
        primaryColor: R.color.primaryColor,
        primaryColorDark: R.color.primaryDarkColor,
        toggleableActiveColor: R.color.secondaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: R.color.accentColor,
        ), textSelectionTheme: TextSelectionThemeData(cursorColor: R.color.primaryColor));
  }

  initPlatformState() async {
    // For sharing images coming from outside the app while the app is in the memory
    _intentDataMediaStreamSubscription = ReceiveSharingIntent.getMediaStream()
        .listen((List<SharedMediaFile> sharedFiles) async {
      if (sharedFiles.isNotEmpty) {
        final String path = sharedFiles[0].path;
        sharingContentController
            .sinkAddSafe(ShareContentModel(content: path, isFile: true));
      }
    }, onError: (err) {
      ToastUtil.showToast(err.toString());
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia()
        .then((List<SharedMediaFile> sharedFiles) async {
      if (sharedFiles.isNotEmpty) {
        final String path = sharedFiles[0].path;
        sharingContentController
            .sinkAddSafe(ShareContentModel(content: path, isFile: true));
      }
    }).catchError((err) {
      ToastUtil.showToast(err.toString());
    });

    // For sharing text coming from outside the app while the app is in the memory
    _intentDataTextStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String sharedText) async {
      if (sharedText.isNotEmpty == true) {
        sharingContentController.sinkAddSafe(ShareContentModel(
          content: sharedText,
        ));
      }
    }, onError: (err) {
      ToastUtil.showToast(err.toString());
    });

    // For sharing text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String? sharedText) async {
      if (sharedText?.isNotEmpty == true) {
        sharingContentController.sinkAddSafe(ShareContentModel(
          content: sharedText!,
        ));
      }
    }, onError: (err) {
      ToastUtil.showToast(err?.toString() ?? "");
    });

    //For opening url while the app is closed
    try {
      final initialUri = await getInitialUri();
      if (initialUri != null) appLinksContentController.sinkAddSafe(AppLinksNavigationModel(link: initialUri.toString()));
    } on FormatException {
      ToastUtil.showToast("Uri format error");
    }

    //For opening url while the app is in memory
    _intentDataLinksStreamSubscription = uriLinkStream.listen((Uri? uri) {
      if (uri != null) appLinksContentController.sinkAddSafe(AppLinksNavigationModel(link: uri.toString()));
    }, onError: (err) {
      ToastUtil.showToast(err?.toString() ?? "");
    });
  }
}
