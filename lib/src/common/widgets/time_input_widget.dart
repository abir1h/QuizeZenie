import 'package:dotted_separator/dotted_separator.dart';

import '../constants/app_theme.dart';

class TimeInputScreen extends StatefulWidget {
  final Function(String) onTimeChanged;

  const TimeInputScreen({super.key, required this.onTimeChanged});

  @override
  _TimeInputScreenState createState() => _TimeInputScreenState();
}

class _TimeInputScreenState extends State<TimeInputScreen> with AppTheme {
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController minutesController = TextEditingController();
  final TextEditingController secondsController = TextEditingController();

  String combinedTime = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.s12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.s4),
          border: Border.all(color: clr.greyBorder)
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Hours",
                      style: TextStyle(
                          color: clr.greyVideoTitle,
                          fontSize: size.textXXXSmall,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 70,
                      child: TextField(
                        controller: hoursController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (v) {
                          _combineTimeValues();
                        },
                        style: TextStyle(
                            color: clr.blackColor,
                            fontSize: size.textXMedium,
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
                ),
                Padding(
                  padding:   EdgeInsets.only(top:size.s16),
                  child: Text(
                    " : ",
                    style: TextStyle(
                        color: clr.blackColor,
                        fontSize: size.textXMedium,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Minutes ",
                      style: TextStyle(
                          color: clr.greyVideoTitle,
                          fontSize: size.textXXXSmall,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 70,
                      child: TextField(
                        controller: minutesController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (v) {
                          _combineTimeValues();
                        },
                        style: TextStyle(
                            color: clr.blackColor,
                            fontSize: size.textXMedium,
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
                ),
                Padding(
                  padding:   EdgeInsets.only(top:size.s16),
                  child: Text(
                    " : ",
                    style: TextStyle(
                        color: clr.blackColor,
                        fontSize: size.textXMedium,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Seconds",
                      style: TextStyle(
                          color: clr.greyVideoTitle,
                          fontSize: size.textXXXSmall,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 70,
                      child: TextField(
                        controller: secondsController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (v) {
                          _combineTimeValues();
                        },
                        style: TextStyle(
                            color: clr.blackColor,
                            fontSize: size.textXMedium,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _combineTimeValues() {
    String hours = hoursController.text.trim();
    String minutes = minutesController.text.trim();
    String seconds = secondsController.text.trim();

    hours = hours.isEmpty ? "00" : hours.padLeft(2, '0');
    minutes = minutes.isEmpty ? "00" : minutes.padLeft(2, '0');
    seconds = seconds.isEmpty ? "00" : seconds.padLeft(2, '0');

    setState(() {
      combinedTime = "$hours:$minutes:$seconds";
    });
  }
}