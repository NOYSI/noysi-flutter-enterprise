import 'package:code/ui/_base/bloc_base.dart';
import 'package:flutter/widgets.dart';
import '../../_di/bloc_provider.dart';
import '../../_di/injector.dart';

///This state already setups a [BlocProvider] as it's main child.
abstract class StateWithBloCAndNotReloadAbleMixin<W extends StatefulWidget, B extends BaseBloC>
    extends State<W> with AutomaticKeepAliveClientMixin<W>{


  // ignore: close_sinks
 // static PublishSubject<bool> onReloginResult = PublishSubject();

  ///Current bloc instance
  late B bloc;
  //static bool alreadyNavigate = false;

  ///If the current widget is able to navigate forward to login again. Usually this is true if the widget is a page
  //bool shouldReLogin() => false;

  bool _keepAlive = false;

  @override
  bool get wantKeepAlive => _keepAlive;

  @override
  void initState() {
    bloc = Injector.instance.getNewBloc();
    // if (shouldReLogin())
    //   Injector.instance.networkHandler.on401 = () {
    //     if (!alreadyNavigate) on401();
    //     alreadyNavigate = true;
    //   };
    print('initState $this');
    super.initState();
  }

  void changeKeepAlive(bool k) {
    _keepAlive = k;
    updateKeepAlive();
  }

  // void on401() async {
  //   final res = await NavigationUtils.pushModal(
  //       context,
  //       LoginPage(
  //         navigateBack: true,
  //       ));
  //   alreadyNavigate = false;
  //   if (res != null && res == true) {
  //     onReloginResult.sink.add(true);
  //   }
  // }

  @override
  void dispose(){
    print('dispose $this');
    if(_keepAlive) changeKeepAlive(false);
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      bloc: bloc,
      child: buildWidget(context),
    );
  }

  ///Use this one instead of [build]
  Widget buildWidget(BuildContext context);
}
