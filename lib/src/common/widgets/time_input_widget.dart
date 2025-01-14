import 'package:dotted_separator/dotted_separator.dart';

import '../constants/app_theme.dart';

class TimeInputScreen extends StatefulWidget {
  final Function(int) onTimeChanged;
  final Duration initialTime; // Add this parameter
  final Duration totalDuration; // Add this parameter

  const TimeInputScreen({
    super.key,
    required this.onTimeChanged,
    required this.initialTime, required this.totalDuration, // Add this parameter
  });

  @override
  _TimeInputScreenState createState() => _TimeInputScreenState();
}

class _TimeInputScreenState extends State<TimeInputScreen> with AppTheme {
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController minutesController = TextEditingController();
  final TextEditingController secondsController = TextEditingController();

  String combinedTime = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100)).whenComplete((){
      if(mounted)     convertInSeconds();

    });
    _setInitialTime(widget.initialTime); // Initialize with the provided time
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.s12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.s4),
        border: Border.all(color: clr.greyBorder),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTimeField(
                  "Hours",
                  hoursController,
                  size.textXMedium,
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.s16),
                  child: Text(
                    " : ",
                    style: TextStyle(
                        color: clr.blackColor,
                        fontSize: size.textXMedium,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                _buildTimeField(
                  "Minutes",
                  minutesController,
                  size.textXMedium,
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.s16),
                  child: Text(
                    " : ",
                    style: TextStyle(
                        color: clr.blackColor,
                        fontSize: size.textXMedium,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                _buildTimeField(
                  "Seconds",
                  secondsController,
                  size.textXMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeField(
      String label, TextEditingController controller, double fontSize) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
              color: clr.greyVideoTitle,
              fontSize: size.textXXXSmall,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: 70,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (v) => convertInSeconds(),
            style: TextStyle(
                color: clr.blackColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "00",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ],
    );
  }

  void _setInitialTime(Duration initialTime) {
    final int hours = initialTime.inHours;
    final int minutes = initialTime.inMinutes % 60;
    final int seconds = initialTime.inSeconds % 60;

    setState(() {
      hoursController.text = hours.toString().padLeft(2, '0');
      minutesController.text = minutes.toString().padLeft(2, '0');
      secondsController.text = seconds.toString().padLeft(2, '0');
      combinedTime = "$hours:${minutes}:${seconds}";
    });
  }

/*  void _combineTimeValues() {
    String hours = hoursController.text.trim();
    String minutes = minutesController.text.trim();
    String seconds = secondsController.text.trim();

    hours = hours.isEmpty ? "00" : hours.padLeft(2, '0');
    minutes = minutes.isEmpty ? "00" : minutes.padLeft(2, '0');
    seconds = seconds.isEmpty ? "00" : seconds.padLeft(2, '0');

    setState(() {
      combinedTime = "$hours:$minutes:$seconds";
    });

    widget.onTimeChanged(combinedTime);
  }*/
  void convertInSeconds() {
    String hours = hoursController.text.trim();
    String minutes = minutesController.text.trim();
    String seconds = secondsController.text.trim();

    hours = hours.isEmpty ? "00" : hours.padLeft(2, '0');
    minutes = minutes.isEmpty ? "00" : minutes.padLeft(2, '0');
    seconds = seconds.isEmpty ? "00" : seconds.padLeft(2, '0');

    int hoursInt = int.tryParse(hours) ?? 0;
    int minutesInt = int.tryParse(minutes) ?? 0;
    int secondsInt = int.tryParse(seconds) ?? 0;

    int totalSeconds = (hoursInt * 3600) + (minutesInt * 60) + secondsInt;

    int maxSeconds = widget.totalDuration.inSeconds;
    if (totalSeconds > maxSeconds) {
      _setInitialTime(widget.totalDuration);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Entered time cannot exceed the total duration of the video."),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      combinedTime = "$hours:$minutes:$seconds";
    });

    widget.onTimeChanged(totalSeconds);
  }

}
