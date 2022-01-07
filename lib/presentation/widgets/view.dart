import 'package:flutter/widgets.dart';

///
final appRouteObserver = RouteObserver<ModalRoute<void>>();

///
abstract class RouteAwareState<T extends StatefulWidget> extends State<T>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appRouteObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    appRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    didViewAppear();
  }

  @override
  void didPush() {
    didViewAppear();
  }

  @override
  void didPop() {
    didViewDisappear();
  }

  @override
  void didPushNext() {
    didViewDisappear();
  }

  void didViewAppear() {}

  void didViewDisappear() {}
}
