
import '../config/app_event_widget.dart';

class TabMoreScreenReloadNotifier  extends EventNotifier<bool> {
  TabMoreScreenReloadNotifier._();
  static TabMoreScreenReloadNotifier get instance=> _instance;
  static final TabMoreScreenReloadNotifier _instance = TabMoreScreenReloadNotifier._();


  ///Generate post likes key
  String get key =>"tab_more_page_reload";
  ///notify count all the subscribers for update like count
  void notifyToReload() {
    notifyListeners(key,true);
  }
}