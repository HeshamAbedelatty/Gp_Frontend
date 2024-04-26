import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(PomodoroTimer());
}

class PomodoroTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _studyTime = 25; // Default study time in minutes
  int _breakTime = 5; // Default break time in minutes
  int _longBreakTime = 15; // Default long break time in minutes
  int _currentTimer = 0; // 0 for study, 1 for break, 2 for long break
  int _remainingSeconds = 0;
  Timer? _timer;
  bool _isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro Timer'),
        backgroundColor: Color(0xFF3C8243),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200.0,
              height: 200.0,
              child: CustomPaint(
                painter: TimerPainter(
                  percent: _remainingSeconds /
                      ((_currentTimer == 0)
                          ? _studyTime * 60
                          : ((_currentTimer == 1)
                              ? _breakTime * 60
                              : _longBreakTime * 60)),
                  color: (_currentTimer == 0)
                      ? Color(0xFF3C8243)
                      : ((_currentTimer == 1) ? Colors.red : Colors.blue),
                ),
                child: Center(
                  child: Text(
                    _timerDisplayText(),
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeSetter('Study', _studyTime, (newValue) {
                  setState(() {
                    _studyTime = newValue;
                  });
                }),
                _buildTimeSetter('Break', _breakTime, (newValue) {
                  setState(() {
                    _breakTime = newValue;
                  });
                }),
                _buildTimeSetter('Long Break', _longBreakTime, (newValue) {
                  setState(() {
                    _longBreakTime = newValue;
                  });
                }),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? null : _startTimer,
                  child: Text('Start'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF3C8243),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isRunning ? _pauseTimer : null,
                  child: Text('Pause'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF3C8243),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isRunning ? null : _resetTimer,
                  child: Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF3C8243),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSetter(
      String label, int value, ValueChanged<int> onChanged) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 20.0),
        ),
        Row(
          children: [
            IconButton(
              onPressed: _isRunning ? null : () => onChanged(value - 1),
              icon: Icon(Icons.remove),
            ),
            Text(
              '$value',
              style: TextStyle(fontSize: 20.0),
            ),
            IconButton(
              onPressed: _isRunning ? null : () => onChanged(value + 1),
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }

  String _timerDisplayText() {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _startTimer() {
    int duration;
    switch (_currentTimer) {
      case 0:
        duration = _studyTime * 60;
        break;
      case 1:
        duration = _breakTime * 60;
        break;
      case 2:
        duration = _longBreakTime * 60;
        break;
      default:
        duration = _studyTime * 60;
    }

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (duration < 1) {
          _currentTimer = (_currentTimer + 1) % 3;
          _resetTimer();
          return;
        } else {
          duration--;
          _remainingSeconds = duration;
        }
      });
    });

    setState(() {
      _isRunning = true;
    });
  }

  void _pauseTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _isRunning = false;
      _remainingSeconds = 0;
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }
}

class TimerPainter extends CustomPainter {
  final Color color;
  final double percent;

  TimerPainter({required this.color, required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    double radius = min(size.width / 2, size.height / 2) - 10;

    canvas.drawCircle(center, radius, paint);

    double sweepAngle = 2 * pi * percent;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      -sweepAngle,
      false,
      paint..color = color.withOpacity(0.2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}













// awel code we sha8al el7
// import 'dart:async';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(PomodoroTimer());
// }

// class PomodoroTimer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: TimerPage(),
//     );
//   }
// }

// class TimerPage extends StatefulWidget {
//   @override
//   _TimerPageState createState() => _TimerPageState();
// }

// class _TimerPageState extends State<TimerPage> {
//   int _studyTime = 25; // Default study time in minutes
//   int _breakTime = 5; // Default break time in minutes
//   int _longBreakTime = 15; // Default long break time in minutes
//   int _currentTimer = 0; // 0 for study, 1 for break, 2 for long break
//   int _remainingSeconds = 0;
//   Timer? _timer;
//   bool _isRunning = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pomodoro Timer'),
//         backgroundColor: Color(0xFF3C8243),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               _timerDisplayText(),
//               style: TextStyle(fontSize: 40.0),
//             ),
//             SizedBox(height: 20.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildTimeSetter('Study', _studyTime, (newValue) {
//                   setState(() {
//                     _studyTime = newValue;
//                   });
//                 }),
//                 _buildTimeSetter('Break', _breakTime, (newValue) {
//                   setState(() {
//                     _breakTime = newValue;
//                   });
//                 }),
//                 _buildTimeSetter('Long Break', _longBreakTime, (newValue) {
//                   setState(() {
//                     _longBreakTime = newValue;
//                   });
//                 }),
//               ],
//             ),
//             SizedBox(height: 20.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: _isRunning ? null : _startTimer,
//                   child: Text('Start'),
//                   style: ElevatedButton.styleFrom(
//                     primary: Color(0xFF3C8243),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: _isRunning ? _pauseTimer : null,
//                   child: Text('Pause'),
//                   style: ElevatedButton.styleFrom(
//                     primary: Color(0xFF3C8243),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: _isRunning ? null : _resetTimer,
//                   child: Text('Reset'),
//                   style: ElevatedButton.styleFrom(
//                     primary: Color(0xFF3C8243),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTimeSetter(String label, int value, ValueChanged<int> onChanged) {
//     return Column(
//       children: [
//         Text(
//           label,
//           style: TextStyle(fontSize: 20.0),
//         ),
//         Row(
//           children: [
//             IconButton(
//               onPressed: _isRunning ? null : () => onChanged(value - 1),
//               icon: Icon(Icons.remove),
//             ),
//             Text(
//               '$value',
//               style: TextStyle(fontSize: 20.0),
//             ),
//             IconButton(
//               onPressed: _isRunning ? null : () => onChanged(value + 1),
//               icon: Icon(Icons.add),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   String _timerDisplayText() {
//     int minutes = _remainingSeconds ~/ 60;
//     int seconds = _remainingSeconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//   }

//   void _startTimer() {
//     int duration;
//     switch (_currentTimer) {
//       case 0:
//         duration = _studyTime * 60;
//         break;
//       case 1:
//         duration = _breakTime * 60;
//         break;
//       case 2:
//         duration = _longBreakTime * 60;
//         break;
//       default:
//         duration = _studyTime * 60;
//     }

//     _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
//       setState(() {
//         if (duration < 1) {
//           _currentTimer = (_currentTimer + 1) % 3;
//           _resetTimer();
//           return;
//         } else {
//           duration--;
//           _remainingSeconds = duration;
//         }
//       });
//     });

//     setState(() {
//       _isRunning = true;
//     });
//   }

//   void _pauseTimer() {
//     if (_timer != null) {
//       _timer!.cancel();
//     }
//     setState(() {
//       _isRunning = false;
//     });
//   }

//   void _resetTimer() {
//     if (_timer != null) {
//       _timer!.cancel();
//     }
//     setState(() {
//       _isRunning = false;
//       _remainingSeconds = 0;
//     });
//   }

//   @override
//   void dispose() {
//     if (_timer != null) {
//       _timer!.cancel();
//     }
//     super.dispose();
//   }
// }
