
import '../config/app_event_widget.dart';

class TabHomeScreenReloadNotifier  extends EventNotifier<bool> {
  TabHomeScreenReloadNotifier._();
  static TabHomeScreenReloadNotifier get instance=> _instance;
  static final TabHomeScreenReloadNotifier _instance = TabHomeScreenReloadNotifier._();


  ///Generate post likes key
  String get key =>"tab_home_page_reload";
  ///notify count all the subscribers for update like count
  void notifyToReload() {
    notifyListeners(key,true);
  }
}