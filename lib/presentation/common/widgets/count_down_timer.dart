import 'dart:async';

import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({super.key, required this.duration, required this.onTimePassed});

  final Duration duration;
  final VoidCallback onTimePassed;

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  late Timer _timer;
  late int _totalSeconds;

  @override
  void initState() {
    super.initState();
    _totalSeconds = widget.duration.inSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_totalSeconds > 0) {
          _totalSeconds--;
        } else {
          _timer.cancel();
          widget.onTimePassed();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    return '${(duration.inHours % 24).toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    Duration remainingTime = Duration(seconds: _totalSeconds);
    bool isLessThan30Minutes = remainingTime.inMinutes < 30;

    return Text(
      _formatDuration(remainingTime),
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: isLessThan30Minutes ? Colors.red : Colors.black,
      ),
    );
  }
}
