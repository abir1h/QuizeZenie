import 'package:flutter/cupertino.dart';

import '../../video/services/video_upload_info_screen_service.dart';


abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
}

mixin ProfileScreenService<T extends StatefulWidget> on State<T>
implements _ViewModel {
  late _ViewModel _view;
  TextEditingController fullNameController=TextEditingController();
  TextEditingController designationController=TextEditingController();
  TextEditingController contactNumberController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController postalCodeController=TextEditingController();
  TextEditingController permanentAddressController=TextEditingController();
  TextEditingController currentPasswordController=TextEditingController();
  TextEditingController newPasswordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }
  Future<List<FeedBack?>> loadFeedBack() async {
    return [
      FeedBack(id: 1, title: 'Test 1'),
      FeedBack(id: 2, title: 'Test 2'),
      FeedBack(id: 3, title: 'Test 3'),
      FeedBack(id: 4, title: 'Test 4'),
      FeedBack(id: 5, title: 'Test 5'),
      FeedBack(id: 5, title: 'Test 5'),
      FeedBack(id: 5, title: 'Test 5'),
      FeedBack(id: 5, title: 'Test 5'),
      FeedBack(id: 5, title: 'Test 5'),
      FeedBack(id: 5, title: 'Test 5'),
      FeedBack(id: 5, title: 'Test 5'),
      FeedBack(id: 5, title: 'Test 5'),
      FeedBack(id: 5, title: 'Test 5'),
      FeedBack(id: 5, title: 'Test 5'),
      FeedBack(id: 5, title: 'Test 5'),
      FeedBack(id: 5, title: 'Test 5'),
      FeedBack(id: 5, title: 'Test 5'),
      FeedBack(id: 5, title: 'Test 5'),
    ];
  }


//====================Stream Controller=====================
}
