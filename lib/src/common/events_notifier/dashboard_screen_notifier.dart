
import '../config/app_event_widget.dart';

class TabDashboardScreenReloadNotifier  extends EventNotifier<bool> {
  TabDashboardScreenReloadNotifier._();
  static TabDashboardScreenReloadNotifier get instance=> _instance;
  static final TabDashboardScreenReloadNotifier _instance = TabDashboardScreenReloadNotifier._();


  ///Generate post likes key
  String get key =>"tab_dashboard_page_reload";
  ///notify count all the subscribers for update like count
  void notifyToReload() {
    notifyListeners(key,true);
  }
}