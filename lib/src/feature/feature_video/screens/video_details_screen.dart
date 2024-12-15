import 'package:co_learning_mobile_app/src/common/routes/app_route_args.dart';
import 'package:flutter/material.dart';
import '../services/video_details_screen_service.dart';


class VideoDetailsScreen extends StatefulWidget {
  final Object? arguments;
  const VideoDetailsScreen({super.key, this.arguments})
      : assert(arguments != null && arguments is VideoDetailsScreenArgs);

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> with VideoDetailsScreenService {

  @override
  void initState() {
    loadInitialData(widget.arguments as VideoDetailsScreenArgs);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
