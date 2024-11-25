import '../config/app_event_widget.dart';

class CourseDetailsScreenReloadNotifier  extends EventNotifier<bool> {
  CourseDetailsScreenReloadNotifier._();
  static CourseDetailsScreenReloadNotifier get instance=> _instance;
  static final CourseDetailsScreenReloadNotifier _instance = CourseDetailsScreenReloadNotifier._();


  ///Generate post likes key
  String get key =>"course_details_page_reload";
  ///notify count all the subscribers for update like count
  void notifyToReload() {
    notifyListeners(key,true);
  }
}