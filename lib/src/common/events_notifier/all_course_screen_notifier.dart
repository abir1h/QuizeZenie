
import '../config/app_event_widget.dart';

class AllCoursesScreenReloadNotifier  extends EventNotifier<bool> {
  AllCoursesScreenReloadNotifier._();
  static AllCoursesScreenReloadNotifier get instance=> _instance;
  static final AllCoursesScreenReloadNotifier _instance = AllCoursesScreenReloadNotifier._();


  ///Generate post likes key
  String get key =>"all_courses_screen_reload";
  ///notify count all the subscribers for update like count
  void notifyToReload() {
    notifyListeners(key,true);
  }
}