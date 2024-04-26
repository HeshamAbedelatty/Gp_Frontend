









// //last working version with buttons switch finally

// // import 'dart:async';
// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Pomodoro Timer',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: PomodoroTimer(),
// //     );
// //   }
// // }

// // class PomodoroTimer extends StatefulWidget {
// //   @override
// //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // }

// // class _PomodoroTimerState extends State<PomodoroTimer> {
// //   int _studyTime = 25;
// //   int _breakTime = 5;
// //   int _longBreakTime = 15;
// //   int _currentTimer = 0;
// //   int _iterations = 0;
// //   bool _isRunning = false;
// //   bool _showPauseButton = false;
// //   bool _showContinueButton = false;
// //   String _timerText = '25:00';
// //   int _remainingSeconds = 0;

// //   Timer? _timer;

// //   void startTimer(int minutes) {
// //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// //       setState(() {
// //         if (seconds > 0) {
// //           seconds--;
// //           int minutes = seconds ~/ 60;
// //           int remainingSeconds = seconds % 60;
// //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// //           _remainingSeconds = seconds;
// //         } else {
// //           _timer!.cancel();
// //           if (_currentTimer == 0) {
// //             _iterations++;
// //             if (_iterations % 3 == 0) {
// //               _currentTimer = 2;
// //               _timerText = '$_longBreakTime:00';
// //             } else {
// //               _currentTimer = 1;
// //               _timerText = '$_breakTime:00';
// //             }
// //           } else {
// //             _currentTimer = 0;
// //             _timerText = '$_studyTime:00';
// //           }
// //           _isRunning = false;
// //           _showPauseButton = false;
// //           _showContinueButton = false;
// //         }
// //       });
// //     });
// //     _isRunning = true;
// //     _showPauseButton = true;
// //     _showContinueButton = false;
// //   }

// //   void pauseTimer() {
// //     if (_isRunning) {
// //       _timer?.cancel();
// //       _isRunning = false;
// //       _showPauseButton = false;
// //       _showContinueButton = true;
// //     }
// //     setState(() {});
// //   }

// //   void restartTimer() {
// //     pauseTimer();
// //     setState(() {
// //       _remainingSeconds = 0;
// //       _timerText = '$_studyTime:00';
// //       _showPauseButton = false;
// //       _showContinueButton = false;
// //     });
// //   }

// //   void continueTimer() {
// //     if (!_isRunning) {
// //       _isRunning = true;
// //       startTimer(_remainingSeconds ~/ 60);
// //       _showPauseButton = true;
// //       _showContinueButton = false;
// //     }
// //     setState(() {});
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Pomodoro Timer'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Stack(
// //               alignment: Alignment.center,
// //               children: [
// //                 SizedBox(
// //                   width: 200,
// //                   height: 200,
// //                   child: CircularProgressIndicator(
// //                     value: _isRunning
// //                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// //                         : 0,
// //                     backgroundColor: Colors.grey[300],
// //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// //                     strokeWidth: 20,
// //                   ),
// //                 ),
// //                 Text(
// //                   _timerText,
// //                   style: TextStyle(fontSize: 30, color: Colors.grey),
// //                 ),
// //               ],
// //             ),
// //             SizedBox(height: 20),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 _buildTimeContainer('Study Time', '$_studyTime minutes'),
// //                 SizedBox(width: 20),
// //                 _buildTimeContainer('Break Time', '$_breakTime minutes'),
// //                 SizedBox(width: 20),
// //                 _buildTimeContainer('Long Break Time', '$_longBreakTime minutes'),
// //               ],
// //             ),
// //             SizedBox(height: 20),
// //             if (!_isRunning && !_showPauseButton && !_showContinueButton)
// //               ElevatedButton(
// //                 onPressed: () {
// //                   if (!_isRunning) {
// //                     startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// //                   }
// //                 },
// //                 child: Text('Start Timer'),
// //               ),
// //             if (_showPauseButton)
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(vertical: 10),
// //                 child: ElevatedButton(
// //                   onPressed: pauseTimer,
// //                   child: Text('Pause Timer'),
// //                 ),
// //               ),
// //             if (_showContinueButton)
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(vertical: 10),
// //                 child: ElevatedButton(
// //                   onPressed: continueTimer,
// //                   child: Text('Continue Timer'),
// //                 ),
// //               ),
// //             if (_isRunning || _showPauseButton || _showContinueButton)
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(vertical: 10),
// //                 child: ElevatedButton(
// //                   onPressed: restartTimer,
// //                   child: Text('Restart Timer'),
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildTimeContainer(String title, String time) {
// //     return Column(
// //       children: [
// //         Text(
// //           title,
// //           style: TextStyle(color: Colors.grey),
// //         ),
// //         SizedBox(height: 5),
// //         Container(
// //           padding: EdgeInsets.all(10),
// //           decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(10),
// //             border: Border.all(color: Colors.green),
// //           ),
// //           child: Text(
// //             time,
// //             style: TextStyle(color: Colors.grey),
// //           ),
// //         ),
// //         SizedBox(height: 5),
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             IconButton(
// //               onPressed: () {
// //                 if (!_isRunning) {
// //                   setState(() {
// //                     if (title == 'Study Time') {
// //                       _studyTime++;
// //                     } else if (title == 'Break Time') {
// //                       _breakTime++;
// //                     } else {
// //                       _longBreakTime++;
// //                     }
// //                     restartTimer();
// //                   });
// //                 }
// //               },
// //               icon: Icon(Icons.add),
// //             ),
// //             IconButton(
// //               onPressed: () {
// //                 if (!_isRunning) {
// //                   setState(() {
// //                     if (title == 'Study Time' && _studyTime > 1) {
// //                       _studyTime--;
// //                     } else if (title == 'Break Time' && _breakTime > 1) {
// //                       _breakTime--;
// //                     } else if (title == 'Long Break Time' && _longBreakTime > 1) {
// //                       _longBreakTime--;
// //                     }
// //                     restartTimer();
// //                   });
// //                 }
// //               },
// //               icon: Icon(Icons.remove),
// //             ),
// //           ],
// //         ),
// //       ],
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _timer?.cancel();
// //     super.dispose();
// //   }
// // }
//missed up the countdown initial view so back to version 6.1

// import 'dart:async';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pomodoro Timer',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PomodoroTimer(),
//     );
//   }
// }

// class PomodoroTimer extends StatefulWidget {
//   @override
//   _PomodoroTimerState createState() => _PomodoroTimerState();
// }

// class _PomodoroTimerState extends State<PomodoroTimer> {
//   int _studyTime = 25;
//   int _breakTime = 5;
//   int _longBreakTime = 15;
//   int _currentTimer = 0;
//   int _iterations = 0;
//   int _longBreakInterval = 3;
//   bool _isRunning = false;
//   bool _showPauseButton = false;
//   bool _showContinueButton = false;
//   String _timerText = '25:00';
//   int _remainingSeconds = 0;
//   String _lastState = ''; // Variable to store the last state

//   Timer? _timer;

//   void startTimer(int minutes) {
//     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (seconds > 0) {
//           seconds--;
//           int minutes = seconds ~/ 60;
//           int remainingSeconds = seconds % 60;
//           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
//           _remainingSeconds = seconds;
//         } else {
//           _timer!.cancel();
//           if (_currentTimer == 0) {
//             _iterations++;
//             if (_iterations % _longBreakInterval == 0) {
//               _currentTimer = 2;
//               _timerText = '$_longBreakTime:00';
//               _lastState = 'Long Break'; // Update last state
//             } else {
//               _currentTimer = 1;
//               _timerText = '$_breakTime:00';
//               _lastState = 'Break'; // Update last state
//             }
//           } else {
//             _currentTimer = 0;
//             _timerText = '$_studyTime:00';
//             _lastState = 'Study'; // Update last state
//           }
//           _isRunning = false;
//           _showPauseButton = false;
//           _showContinueButton = false;
//         }
//       });
//     });
//     _isRunning = true;
//     _showPauseButton = true;
//     _showContinueButton = false;
//   }

//   void pauseTimer() {
//     if (_isRunning) {
//       _timer?.cancel();
//       _isRunning = false;
//       _showPauseButton = false;
//       _showContinueButton = true;
//     }
//     setState(() {});
//   }

//   void restartTimer() {
//     pauseTimer();
//     setState(() {
//       _remainingSeconds = 0;
//       _showPauseButton = false;
//       _showContinueButton = false;
//       // Display the last state when restarting
//       if (_lastState.isNotEmpty) {
//         if (_lastState == 'Study') {
//           _currentTimer = 0;
//           _timerText = '$_studyTime:00';
//         } else if (_lastState == 'Break') {
//           _currentTimer = 1;
//           _timerText = '$_breakTime:00';
//         } else if (_lastState == 'Long Break') {
//           _currentTimer = 2;
//           _timerText = '$_longBreakTime:00';
//         }
//       }
//     });
//   }

//   void continueTimer() {
//     if (!_isRunning) {
//       _isRunning = true;
//       startTimer(_remainingSeconds ~/ 60);
//       _showPauseButton = true;
//       _showContinueButton = false;
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pomodoro Timer'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   width: 200,
//                   height: 200,
//                   child: CircularProgressIndicator(
//                     value: _isRunning
//                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
//                         : 0,
//                     backgroundColor: Colors.grey[300],
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//                     strokeWidth: 20,
//                   ),
//                 ),
//                 Text(
//                   _timerText,
//                   style: TextStyle(fontSize: 30, color: Colors.grey),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildTimeContainer('Study Time', '$_studyTime minutes', () {
//                   setState(() {
//                     _studyTime++;
//                     restartTimer();
//                   });
//                 }, () {
//                   setState(() {
//                     if (_studyTime > 1) {
//                       _studyTime--;
//                       restartTimer();
//                     }
//                   });
//                 }),
//                 SizedBox(width: 20),
//                 _buildTimeContainer('Break Time', '$_breakTime minutes', () {
//                   setState(() {
//                     _breakTime++;
//                     restartTimer();
//                   });
//                 }, () {
//                   setState(() {
//                     if (_breakTime > 1) {
//                       _breakTime--;
//                       restartTimer();
//                     }
//                   });
//                 }),
//                 SizedBox(width: 20),
//                 _buildTimeContainer('Long Break Time', '$_longBreakTime minutes', () {
//                   setState(() {
//                     _longBreakTime++;
//                     restartTimer();
//                   });
//                 }, () {
//                   setState(() {
//                     if (_longBreakTime > 1) {
//                       _longBreakTime--;
//                       restartTimer();
//                     }
//                   });
//                 }),
//               ],
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Long Break Interval: '),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       if (_longBreakInterval > 1) {
//                         _longBreakInterval--;
//                       }
//                     });
//                   },
//                   icon: Icon(Icons.remove),
//                 ),
//                 Text('$_longBreakInterval'),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       _longBreakInterval++;
//                     });
//                   },
//                   icon: Icon(Icons.add),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             if (!_isRunning && !_showPauseButton && !_showContinueButton)
//               ElevatedButton(
//                 onPressed: () {
//                   if (!_isRunning) {
//                     startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
//                   }
//                 },
//                 child: Text('Start Timer'),
//               ),
//             if (_showPauseButton)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: ElevatedButton(
//                   onPressed: pauseTimer,
//                   child: Text('Pause Timer'),
//                 ),
//               ),
//             if (_showContinueButton)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: ElevatedButton(
//                   onPressed: continueTimer,
//                   child: Text('Continue Timer'),
//                 ),
//               ),
//             if (_isRunning || _showPauseButton || _showContinueButton)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: ElevatedButton(
//                   onPressed: restartTimer,
//                   child: Text('Restart Timer'),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTimeContainer(String title, String time, Function() onIncrease, Function() onDecrease) {
//     return Column(
//       children: [
//         Text(
//           title,
//           style: TextStyle(color: Colors.grey),
//         ),
//         SizedBox(height: 5),
//         Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: Colors.green),
//           ),
//           child: Text(
//             time,
//             style: TextStyle(color: Colors.grey),
//           ),
//         ),
//         SizedBox(height: 5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               onPressed: onIncrease,
//               icon: Icon(Icons.add),
//             ),
//             IconButton(
//               onPressed: onDecrease,
//               icon: Icon(Icons.remove),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }













//restart missed up the countdown initial view so back to version 6.1

// import 'dart:async';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pomodoro Timer',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PomodoroTimer(),
//     );
//   }
// }

// class PomodoroTimer extends StatefulWidget {
//   @override
//   _PomodoroTimerState createState() => _PomodoroTimerState();
// }

// class _PomodoroTimerState extends State<PomodoroTimer> {
//   int _studyTime = 25;
//   int _breakTime = 5;
//   int _longBreakTime = 15;
//   int _currentTimer = 0;
//   int _iterations = 0;
//   int _longBreakInterval = 3;
//   bool _isRunning = false;
//   bool _showPauseButton = false;
//   bool _showContinueButton = false;
//   String _timerText = '25:00';
//   int _remainingSeconds = 0;
//   String _lastState = ''; // Variable to store the last state

//   Timer? _timer;

//   void startTimer(int minutes) {
//     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (seconds > 0) {
//           seconds--;
//           int minutes = seconds ~/ 60;
//           int remainingSeconds = seconds % 60;
//           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
//           _remainingSeconds = seconds;
//         } else {
//           _timer!.cancel();
//           if (_currentTimer == 0) {
//             _iterations++;
//             if (_iterations % _longBreakInterval == 0) {
//               _currentTimer = 2;
//               _timerText = '$_longBreakTime:00';
//               _lastState = 'Long Break'; // Update last state
//             } else {
//               _currentTimer = 1;
//               _timerText = '$_breakTime:00';
//               _lastState = 'Break'; // Update last state
//             }
//           } else {
//             _currentTimer = 0;
//             _timerText = '$_studyTime:00';
//             _lastState = 'Study'; // Update last state
//           }
//           _isRunning = false;
//           _showPauseButton = false;
//           _showContinueButton = false;
//         }
//       });
//     });
//     _isRunning = true;
//     _showPauseButton = true;
//     _showContinueButton = false;
//   }

//   void pauseTimer() {
//     if (_isRunning) {
//       _timer?.cancel();
//       _isRunning = false;
//       _showPauseButton = false;
//       _showContinueButton = true;
//     }
//     setState(() {});
//   }

//   void restartTimer() {
//     pauseTimer();
//     setState(() {
//       _remainingSeconds = 0;
//       _showPauseButton = false;
//       _showContinueButton = false;
//       // Display the last state when restarting
//       if (_lastState.isNotEmpty) {
//         if (_lastState == 'Study') {
//           _currentTimer = 0;
//           _timerText = '$_studyTime:00';
//         } else if (_lastState == 'Break') {
//           _currentTimer = 1;
//           _timerText = '$_breakTime:00';
//         } else if (_lastState == 'Long Break') {
//           _currentTimer = 2;
//           _timerText = '$_longBreakTime:00';
//         }
//       }
//     });
//   }

//   void continueTimer() {
//     if (!_isRunning) {
//       _isRunning = true;
//       startTimer(_remainingSeconds ~/ 60);
//       _showPauseButton = true;
//       _showContinueButton = false;
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pomodoro Timer'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   width: 200,
//                   height: 200,
//                   child: CircularProgressIndicator(
//                     value: _isRunning
//                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
//                         : 0,
//                     backgroundColor: Colors.grey[300],
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//                     strokeWidth: 20,
//                   ),
//                 ),
//                 Text(
//                   _timerText,
//                   style: TextStyle(fontSize: 30, color: Colors.grey),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildTimeContainer('Study Time', '$_studyTime minutes'),
//                 SizedBox(width: 20),
//                 _buildTimeContainer('Break Time', '$_breakTime minutes'),
//                 SizedBox(width: 20),
//                 _buildTimeContainer('Long Break Time', '$_longBreakTime minutes'),
//               ],
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Long Break Interval: '),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       if (_longBreakInterval > 1) {
//                         _longBreakInterval--;
//                       }
//                     });
//                   },
//                   icon: Icon(Icons.remove),
//                 ),
//                 Text('$_longBreakInterval'),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       _longBreakInterval++;
//                     });
//                   },
//                   icon: Icon(Icons.add),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             if (!_isRunning && !_showPauseButton && !_showContinueButton)
//               ElevatedButton(
//                 onPressed: () {
//                   if (!_isRunning) {
//                     startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
//                   }
//                 },
//                 child: Text('Start Timer'),
//               ),
//             if (_showPauseButton)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: ElevatedButton(
//                   onPressed: pauseTimer,
//                   child: Text('Pause Timer'),
//                 ),
//               ),
//             if (_showContinueButton)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: ElevatedButton(
//                   onPressed: continueTimer,
//                   child: Text('Continue Timer'),
//                 ),
//               ),
//             if (_isRunning || _showPauseButton || _showContinueButton)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: ElevatedButton(
//                   onPressed: restartTimer,
//                   child: Text('Restart Timer'),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTimeContainer(String title, String time) {
//     return Column(
//       children: [
//         Text(
//           title,
//           style: TextStyle(color: Colors.grey),
//         ),
//         SizedBox(height: 5),
//         Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: Colors.green),
//           ),
//           child: Text(
//             time,
//             style: TextStyle(color: Colors.grey),
//           ),
//         ),
//         SizedBox(height: 5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               onPressed: () {
//                 if (!_isRunning) {
//                   setState(() {
//                     if (title == 'Study Time') {
//                       _studyTime++;
//                     } else if (title == 'Break Time') {
//                       _breakTime++;
//                     } else {
//                       _longBreakTime++;
//                     }
//                     restartTimer();
//                   });
//                 }
//               },
//               icon: Icon(Icons.add),
//             ),
//             IconButton(
//               onPressed: () {
//                 if (!_isRunning) {
//                   setState(() {
//                     if (title == 'Study Time' && _studyTime > 1) {
//                       _studyTime--;
//                     } else if (title == 'Break Time' && _breakTime > 1) {
//                       _breakTime--;
//                     } else if (title == 'Long Break Time' && _longBreakTime > 1) {
//                       _longBreakTime--;
//                     }
//                     restartTimer();
//                   });
//                 }
//               },
//               icon: Icon(Icons.remove),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }













// //sucssess version 6.1 with long timer interval with + - instead of text feild


// import 'dart:async';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pomodoro Timer',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PomodoroTimer(),
//     );
//   }
// }

// class PomodoroTimer extends StatefulWidget {
//   @override
//   _PomodoroTimerState createState() => _PomodoroTimerState();
// }

// class _PomodoroTimerState extends State<PomodoroTimer> {
//   int _studyTime = 25;
//   int _breakTime = 5;
//   int _longBreakTime = 15;
//   int _currentTimer = 0;
//   int _iterations = 0;
//   int _longBreakInterval = 3; // Default interval
//   bool _isRunning = false;
//   bool _showPauseButton = false;
//   bool _showContinueButton = false;
//   String _timerText = '25:00';
//   int _remainingSeconds = 0;

//   Timer? _timer;

//   void startTimer(int minutes) {
//     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (seconds > 0) {
//           seconds--;
//           int minutes = seconds ~/ 60;
//           int remainingSeconds = seconds % 60;
//           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
//           _remainingSeconds = seconds;
//         } else {
//           _timer!.cancel();
//           if (_currentTimer == 0) {
//             _iterations++;
//             if (_iterations % _longBreakInterval == 0) {
//               _currentTimer = 2;
//               _timerText = '$_longBreakTime:00';
//             } else {
//               _currentTimer = 1;
//               _timerText = '$_breakTime:00';
//             }
//           } else {
//             _currentTimer = 0;
//             _timerText = '$_studyTime:00';
//           }
//           _isRunning = false;
//           _showPauseButton = false;
//           _showContinueButton = false;
//         }
//       });
//     });
//     _isRunning = true;
//     _showPauseButton = true;
//     _showContinueButton = false;
//   }

//   void pauseTimer() {
//     if (_isRunning) {
//       _timer?.cancel();
//       _isRunning = false;
//       _showPauseButton = false;
//       _showContinueButton = true;
//     }
//     setState(() {});
//   }

//   void restartTimer() {
//     pauseTimer();
//     setState(() {
//       _remainingSeconds = 0;
//       _timerText = '$_studyTime:00';
//       _showPauseButton = false;
//       _showContinueButton = false;
//     });
//   }

//   void continueTimer() {
//     if (!_isRunning) {
//       _isRunning = true;
//       startTimer(_remainingSeconds ~/ 60);
//       _showPauseButton = true;
//       _showContinueButton = false;
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pomodoro Timer'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   width: 200,
//                   height: 200,
//                   child: CircularProgressIndicator(
//                     value: _isRunning
//                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
//                         : 0,
//                     backgroundColor: Colors.grey[300],
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//                     strokeWidth: 20,
//                   ),
//                 ),
//                 Text(
//                   _timerText,
//                   style: TextStyle(fontSize: 30, color: Colors.grey),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildTimeContainer('Study Time', '$_studyTime minutes'),
//                 SizedBox(width: 20),
//                 _buildTimeContainer('Break Time', '$_breakTime minutes'),
//                 SizedBox(width: 20),
//                 _buildTimeContainer('Long Break Time', '$_longBreakTime minutes'),
//               ],
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Long Break Interval: '),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       if (_longBreakInterval > 1) {
//                         _longBreakInterval--;
//                       }
//                     });
//                   },
//                   icon: Icon(Icons.remove),
//                 ),
//                 Text('$_longBreakInterval'),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       _longBreakInterval++;
//                     });
//                   },
//                   icon: Icon(Icons.add),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             if (!_isRunning && !_showPauseButton && !_showContinueButton)
//               ElevatedButton(
//                 onPressed: () {
//                   if (!_isRunning) {
//                     startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
//                   }
//                 },
//                 child: Text('Start Timer'),
//               ),
//             if (_showPauseButton)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: ElevatedButton(
//                   onPressed: pauseTimer,
//                   child: Text('Pause Timer'),
//                 ),
//               ),
//             if (_showContinueButton)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: ElevatedButton(
//                   onPressed: continueTimer,
//                   child: Text('Continue Timer'),
//                 ),
//               ),
//             if (_isRunning || _showPauseButton || _showContinueButton)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: ElevatedButton(
//                   onPressed: restartTimer,
//                   child: Text('Restart Timer'),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTimeContainer(String title, String time) {
//     return Column(
//       children: [
//         Text(
//           title,
//           style: TextStyle(color: Colors.grey),
//         ),
//         SizedBox(height: 5),
//         Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: Colors.green),
//           ),
//           child: Text(
//             time,
//             style: TextStyle(color: Colors.grey),
//           ),
//         ),
//         SizedBox(height: 5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               onPressed: () {
//                 if (!_isRunning) {
//                   setState(() {
//                     if (title == 'Study Time') {
//                       _studyTime++;
//                     } else if (title == 'Break Time') {
//                       _breakTime++;
//                     } else {
//                       _longBreakTime++;
//                     }
//                     restartTimer();
//                   });
//                 }
//               },
//               icon: Icon(Icons.add),
//             ),
//             IconButton(
//               onPressed: () {
//                 if (!_isRunning) {
//                   setState(() {
//                     if (title == 'Study Time' && _studyTime > 1) {
//                       _studyTime--;
//                     } else if (title == 'Break Time' && _breakTime > 1) {
//                       _breakTime--;
//                     } else if (title == 'Long Break Time' && _longBreakTime > 1) {
//                       _longBreakTime--;
//                     }
//                     restartTimer();
//                   });
//                 }
//               },
//               icon: Icon(Icons.remove),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }










// //sucssess version 6.0 with long timer interval

// // import 'dart:async';
// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Pomodoro Timer',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: PomodoroTimer(),
// //     );
// //   }
// // }

// // class PomodoroTimer extends StatefulWidget {
// //   @override
// //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // }

// // class _PomodoroTimerState extends State<PomodoroTimer> {
// //   int _studyTime = 25;
// //   int _breakTime = 5;
// //   int _longBreakTime = 15;
// //   int _currentTimer = 0;
// //   int _iterations = 0;
// //   int _longBreakInterval = 3; // Default interval
// //   bool _isRunning = false;
// //   bool _showPauseButton = false;
// //   bool _showContinueButton = false;
// //   String _timerText = '25:00';
// //   int _remainingSeconds = 0;

// //   Timer? _timer;

// //   void startTimer(int minutes) {
// //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// //       setState(() {
// //         if (seconds > 0) {
// //           seconds--;
// //           int minutes = seconds ~/ 60;
// //           int remainingSeconds = seconds % 60;
// //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// //           _remainingSeconds = seconds;
// //         } else {
// //           _timer!.cancel();
// //           if (_currentTimer == 0) {
// //             _iterations++;
// //             if (_iterations % _longBreakInterval == 0) {
// //               _currentTimer = 2;
// //               _timerText = '$_longBreakTime:00';
// //             } else {
// //               _currentTimer = 1;
// //               _timerText = '$_breakTime:00';
// //             }
// //           } else {
// //             _currentTimer = 0;
// //             _timerText = '$_studyTime:00';
// //           }
// //           _isRunning = false;
// //           _showPauseButton = false;
// //           _showContinueButton = false;
// //         }
// //       });
// //     });
// //     _isRunning = true;
// //     _showPauseButton = true;
// //     _showContinueButton = false;
// //   }

// //   void pauseTimer() {
// //     if (_isRunning) {
// //       _timer?.cancel();
// //       _isRunning = false;
// //       _showPauseButton = false;
// //       _showContinueButton = true;
// //     }
// //     setState(() {});
// //   }

// //   void restartTimer() {
// //     pauseTimer();
// //     setState(() {
// //       _remainingSeconds = 0;
// //       _timerText = '$_studyTime:00';
// //       _showPauseButton = false;
// //       _showContinueButton = false;
// //     });
// //   }

// //   void continueTimer() {
// //     if (!_isRunning) {
// //       _isRunning = true;
// //       startTimer(_remainingSeconds ~/ 60);
// //       _showPauseButton = true;
// //       _showContinueButton = false;
// //     }
// //     setState(() {});
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Pomodoro Timer'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Stack(
// //               alignment: Alignment.center,
// //               children: [
// //                 SizedBox(
// //                   width: 200,
// //                   height: 200,
// //                   child: CircularProgressIndicator(
// //                     value: _isRunning
// //                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// //                         : 0,
// //                     backgroundColor: Colors.grey[300],
// //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// //                     strokeWidth: 20,
// //                   ),
// //                 ),
// //                 Text(
// //                   _timerText,
// //                   style: TextStyle(fontSize: 30, color: Colors.grey),
// //                 ),
// //               ],
// //             ),
// //             SizedBox(height: 20),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 _buildTimeContainer('Study Time', '$_studyTime minutes'),
// //                 SizedBox(width: 20),
// //                 _buildTimeContainer('Break Time', '$_breakTime minutes'),
// //                 SizedBox(width: 20),
// //                 _buildTimeContainer('Long Break Time', '$_longBreakTime minutes'),
// //               ],
// //             ),
// //             SizedBox(height: 20),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Text('Long Break Interval: '),
// //                 SizedBox(width: 10),
// //                 Container(
// //                   width: 50,
// //                   child: TextField(
// //                     keyboardType: TextInputType.number,
// //                     onChanged: (value) {
// //                       setState(() {
// //                         _longBreakInterval = int.tryParse(value) ?? 3;
// //                       });
// //                     },
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             SizedBox(height: 20),
// //             if (!_isRunning && !_showPauseButton && !_showContinueButton)
// //               ElevatedButton(
// //                 onPressed: () {
// //                   if (!_isRunning) {
// //                     startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// //                   }
// //                 },
// //                 child: Text('Start Timer'),
// //               ),
// //             if (_showPauseButton)
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(vertical: 10),
// //                 child: ElevatedButton(
// //                   onPressed: pauseTimer,
// //                   child: Text('Pause Timer'),
// //                 ),
// //               ),
// //             if (_showContinueButton)
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(vertical: 10),
// //                 child: ElevatedButton(
// //                   onPressed: continueTimer,
// //                   child: Text('Continue Timer'),
// //                 ),
// //               ),
// //             if (_isRunning || _showPauseButton || _showContinueButton)
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(vertical: 10),
// //                 child: ElevatedButton(
// //                   onPressed: restartTimer,
// //                   child: Text('Restart Timer'),
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildTimeContainer(String title, String time) {
// //     return Column(
// //       children: [
// //         Text(
// //           title,
// //           style: TextStyle(color: Colors.grey),
// //         ),
// //         SizedBox(height: 5),
// //         Container(
// //           padding: EdgeInsets.all(10),
// //           decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(10),
// //             border: Border.all(color: Colors.green),
// //           ),
// //           child: Text(
// //             time,
// //             style: TextStyle(color: Colors.grey),
// //           ),
// //         ),
// //         SizedBox(height: 5),
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             IconButton(
// //               onPressed: () {
// //                 if (!_isRunning) {
// //                   setState(() {
// //                     if (title == 'Study Time') {
// //                       _studyTime++;
// //                     } else if (title == 'Break Time') {
// //                       _breakTime++;
// //                     } else {
// //                       _longBreakTime++;
// //                     }
// //                     restartTimer();
// //                   });
// //                 }
// //               },
// //               icon: Icon(Icons.add),
// //             ),
// //             IconButton(
// //               onPressed: () {
// //                 if (!_isRunning) {
// //                   setState(() {
// //                     if (title == 'Study Time' && _studyTime > 1) {
// //                       _studyTime--;
// //                     } else if (title == 'Break Time' && _breakTime > 1) {
// //                       _breakTime--;
// //                     } else if (title == 'Long Break Time' && _longBreakTime > 1) {
// //                       _longBreakTime--;
// //                     }
// //                     restartTimer();
// //                   });
// //                 }
// //               },
// //               icon: Icon(Icons.remove),
// //             ),
// //           ],
// //         ),
// //       ],
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _timer?.cancel();
// //     super.dispose();
// //   }
// // }















// // //not right

// // // import 'dart:async';
// // // import 'package:flutter/material.dart';

// // // void main() {
// // //   runApp(MyApp());
// // // }

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       title: 'Pomodoro Timer',
// // //       theme: ThemeData(
// // //         primarySwatch: Colors.blue,
// // //       ),
// // //       home: PomodoroTimer(),
// // //     );
// // //   }
// // // }

// // // class PomodoroTimer extends StatefulWidget {
// // //   @override
// // //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // // }

// // // class _PomodoroTimerState extends State<PomodoroTimer> {
// // //   int _studyTime = 25;
// // //   int _breakTime = 5;
// // //   int _longBreakTime = 15;
// // //   int _currentTimer = 0;
// // //   int _iterations = 0;
// // //   bool _isRunning = false;
// // //   String _timerText = '25:00';
// // //   int _remainingSeconds = 0;

// // //   Timer? _timer;

// // //   void startTimer(int minutes) {
// // //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // //       setState(() {
// // //         if (seconds > 0) {
// // //           seconds--;
// // //           int minutes = seconds ~/ 60;
// // //           int remainingSeconds = seconds % 60;
// // //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // //           _remainingSeconds = seconds; // Save remaining seconds
// // //         } else {
// // //           _timer!.cancel();
// // //           if (_currentTimer == 0) {
// // //             _iterations++;
// // //             if (_iterations % 3 == 0) {
// // //               _currentTimer = 2; // Long Break
// // //               _timerText = '$_longBreakTime:00';
// // //             } else {
// // //               _currentTimer = 1; // Break
// // //               _timerText = '$_breakTime:00';
// // //             }
// // //           } else {
// // //             _currentTimer = 0; // Study
// // //             _timerText = '$_studyTime:00';
// // //           }
// // //           _isRunning = false;
// // //         }
// // //       });
// // //     });
// // //   }

// // //   void pauseTimer() {
// // //     if (_isRunning) {
// // //       _timer?.cancel();
// // //       _isRunning = false;
// // //     }
// // //     setState(() {}); // Trigger a rebuild to update button visibility
// // //   }

// // //   void restartTimer() {
// // //     pauseTimer();
// // //     setState(() {
// // //       _remainingSeconds = 0; // Reset remaining seconds
// // //       if (_currentTimer == 0) {
// // //         _timerText = '$_studyTime:00';
// // //       } else if (_currentTimer == 1) {
// // //         _timerText = '$_breakTime:00';
// // //       } else {
// // //         _timerText = '$_longBreakTime:00';
// // //       }
// // //     });
// // //   }

// // //   void continueTimer() {
// // //     if (!_isRunning) {
// // //       _isRunning = true;
// // //       startTimer(_remainingSeconds ~/ 60);
// // //     }
// // //     setState(() {}); // Trigger a rebuild to update button visibility
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Pomodoro Timer'),
// // //       ),
// // //       body: Center(
// // //         child: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: [
// // //             Stack(
// // //               alignment: Alignment.center,
// // //               children: [
// // //                 SizedBox(
// // //                   width: 200,
// // //                   height: 200,
// // //                   child: CircularProgressIndicator(
// // //                     value: _isRunning
// // //                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// // //                         : 0,
// // //                     backgroundColor: Colors.grey[300],
// // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// // //                     strokeWidth: 20,
// // //                   ),
// // //                 ),
// // //                 Text(
// // //                   _timerText,
// // //                   style: TextStyle(fontSize: 30, color: Colors.grey),
// // //                 ),
// // //               ],
// // //             ),
// // //             SizedBox(height: 20),
// // //             Row(
// // //               mainAxisAlignment: MainAxisAlignment.center,
// // //               children: [
// // //                 _buildTimeContainer('Study Time', '$_studyTime minutes'),
// // //                 SizedBox(width: 20),
// // //                 _buildTimeContainer('Break Time', '$_breakTime minutes'),
// // //                 SizedBox(width: 20),
// // //                 _buildTimeContainer('Long Break Time', '$_longBreakTime minutes'),
// // //               ],
// // //             ),
// // //             SizedBox(height: 20),
// // //             if (!_isRunning) // Render the button only if timer is not running
// // //               ElevatedButton(
// // //                 onPressed: () {
// // //                   if (!_isRunning) {
// // //                     _isRunning = true;
// // //                     startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// // //                   }
// // //                 },
// // //                 child: Text('Start Timer'),
// // //               ),
// // //             if (_isRunning) // Render the restart button only if timer is running
// // //               ElevatedButton(
// // //                 onPressed: restartTimer,
// // //                 child: Text('Restart Timer'),
// // //               ),
// // //             SizedBox(height: 10),
// // //             if (!_isRunning) // Render the pause button only if timer is not running
// // //               ElevatedButton(
// // //                 onPressed: continueTimer,
// // //                 child: Text('Continue Timer'),
// // //               ),
// // //             if (_isRunning) // Render the continue button only if timer is running
// // //               ElevatedButton(
// // //                 onPressed: pauseTimer,
// // //                 child: Text('Pause Timer'),
// // //               ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildTimeContainer(String title, String time) {
// // //     return Column(
// // //       children: [
// // //         Text(
// // //           title,
// // //           style: TextStyle(color: Colors.grey),
// // //         ),
// // //         SizedBox(height: 5),
// // //         Container(
// // //           padding: EdgeInsets.all(10),
// // //           decoration: BoxDecoration(
// // //             borderRadius: BorderRadius.circular(10),
// // //             border: Border.all(color: Colors.green),
// // //           ),
// // //           child: Text(
// // //             time,
// // //             style: TextStyle(color: Colors.grey),
// // //           ),
// // //         ),
// // //         SizedBox(height: 5),
// // //         Row(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: [
// // //             IconButton(
// // //               onPressed: () {
// // //                 if (!_isRunning) {
// // //                   setState(() {
// // //                     if (title == 'Study Time') {
// // //                       _studyTime++;
// // //                     } else if (title == 'Break Time') {
// // //                       _breakTime++;
// // //                     } else {
// // //                       _longBreakTime++;
// // //                     }
// // //                     restartTimer();
// // //                   });
// // //                 }
// // //               },
// // //               icon: Icon(Icons.add),
// // //             ),
// // //             IconButton(
// // //               onPressed: () {
// // //                 if (!_isRunning) {
// // //                   setState(() {
// // //                     if (title == 'Study Time' && _studyTime > 1) {
// // //                       _studyTime--;
// // //                     } else if (title == 'Break Time' && _breakTime > 1) {
// // //                       _breakTime--;
// // //                     } else if (title == 'Long Break Time' && _longBreakTime > 1) {
// // //                       _longBreakTime--;
// // //                     }
// // //                     restartTimer();
// // //                   });
// // //                 }
// // //               },
// // //               icon: Icon(Icons.remove),
// // //             ),
// // //           ],
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _timer?.cancel();
// // //     super.dispose();
// // //   }
// // // }












// // // //sucsess 4.1 start and restart taketurn
// // // // import 'dart:async';
// // // // import 'package:flutter/material.dart';

// // // // void main() {
// // // //   runApp(MyApp());
// // // // }

// // // // class MyApp extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return MaterialApp(
// // // //       title: 'Pomodoro Timer',
// // // //       theme: ThemeData(
// // // //         primarySwatch: Colors.blue,
// // // //       ),
// // // //       home: PomodoroTimer(),
// // // //     );
// // // //   }
// // // // }

// // // // class PomodoroTimer extends StatefulWidget {
// // // //   @override
// // // //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // // // }

// // // // class _PomodoroTimerState extends State<PomodoroTimer> {
// // // //   int _studyTime = 25;
// // // //   int _breakTime = 5;
// // // //   int _longBreakTime = 15;
// // // //   int _currentTimer = 0;
// // // //   int _iterations = 0;
// // // //   bool _isRunning = false;
// // // //   String _timerText = '25:00';
// // // //   int _remainingSeconds = 0;

// // // //   Timer? _timer;

// // // //   void startTimer(int minutes) {
// // // //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // //       setState(() {
// // // //         if (seconds > 0) {
// // // //           seconds--;
// // // //           int minutes = seconds ~/ 60;
// // // //           int remainingSeconds = seconds % 60;
// // // //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // //           _remainingSeconds = seconds; // Save remaining seconds
// // // //         } else {
// // // //           _timer!.cancel();
// // // //           if (_currentTimer == 0) {
// // // //             _iterations++;
// // // //             if (_iterations % 3 == 0) {
// // // //               _currentTimer = 2; // Long Break
// // // //               _timerText = '$_longBreakTime:00';
// // // //             } else {
// // // //               _currentTimer = 1; // Break
// // // //               _timerText = '$_breakTime:00';
// // // //             }
// // // //           } else {
// // // //             _currentTimer = 0; // Study
// // // //             _timerText = '$_studyTime:00';
// // // //           }
// // // //           _isRunning = false;
// // // //         }
// // // //       });
// // // //     });
// // // //   }

// // // //   void pauseTimer() {
// // // //     if (_isRunning) {
// // // //       _timer?.cancel();
// // // //       _isRunning = false;
// // // //     }
// // // //   }

// // // //   void restartTimer() {
// // // //     pauseTimer();
// // // //     setState(() {
// // // //       _remainingSeconds = 0; // Reset remaining seconds
// // // //       if (_currentTimer == 0) {
// // // //         _timerText = '$_studyTime:00';
// // // //       } else if (_currentTimer == 1) {
// // // //         _timerText = '$_breakTime:00';
// // // //       } else {
// // // //         _timerText = '$_longBreakTime:00';
// // // //       }
// // // //     });
// // // //   }

// // // //   void continueTimer() {
// // // //     if (!_isRunning) {
// // // //       _isRunning = true;
// // // //       startTimer(_remainingSeconds ~/ 60);
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Pomodoro Timer'),
// // // //       ),
// // // //       body: Center(
// // // //         child: Column(
// // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // //           children: [
// // // //             Stack(
// // // //               alignment: Alignment.center,
// // // //               children: [
// // // //                 SizedBox(
// // // //                   width: 200,
// // // //                   height: 200,
// // // //                   child: CircularProgressIndicator(
// // // //                     value: _isRunning
// // // //                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// // // //                         : 0,
// // // //                     backgroundColor: Colors.grey[300],
// // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// // // //                     strokeWidth: 20,
// // // //                   ),
// // // //                 ),
// // // //                 Text(
// // // //                   _timerText,
// // // //                   style: TextStyle(fontSize: 30, color: Colors.grey),
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //             SizedBox(height: 20),
// // // //             Row(
// // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // //               children: [
// // // //                 _buildTimeContainer('Study Time', '$_studyTime minutes'),
// // // //                 SizedBox(width: 20),
// // // //                 _buildTimeContainer('Break Time', '$_breakTime minutes'),
// // // //                 SizedBox(width: 20),
// // // //                 _buildTimeContainer('Long Break Time', '$_longBreakTime minutes'),
// // // //               ],
// // // //             ),
// // // //             SizedBox(height: 20),
// // // //             if (!_isRunning) // Render the button only if timer is not running
// // // //               ElevatedButton(
// // // //                 onPressed: () {
// // // //                   if (!_isRunning) {
// // // //                     _isRunning = true;
// // // //                     startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// // // //                   }
// // // //                 },
// // // //                 child: Text('Start Timer'),
// // // //               ),
// // // //             if (_isRunning) // Render the restart button only if timer is running
// // // //               ElevatedButton(
// // // //                 onPressed: restartTimer,
// // // //                 child: Text('Restart Timer'),
// // // //               ),
// // // //             SizedBox(height: 10),
// // // //             ElevatedButton(
// // // //               onPressed: pauseTimer,
// // // //               child: Text('Pause Timer'),
// // // //             ),
// // // //             SizedBox(height: 10),
// // // //             ElevatedButton(
// // // //               onPressed: continueTimer,
// // // //               child: Text('Continue Timer'),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildTimeContainer(String title, String time) {
// // // //     return Column(
// // // //       children: [
// // // //         Text(
// // // //           title,
// // // //           style: TextStyle(color: Colors.grey),
// // // //         ),
// // // //         SizedBox(height: 5),
// // // //         Container(
// // // //           padding: EdgeInsets.all(10),
// // // //           decoration: BoxDecoration(
// // // //             borderRadius: BorderRadius.circular(10),
// // // //             border: Border.all(color: Colors.green),
// // // //           ),
// // // //           child: Text(
// // // //             time,
// // // //             style: TextStyle(color: Colors.grey),
// // // //           ),
// // // //         ),
// // // //         SizedBox(height: 5),
// // // //         Row(
// // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // //           children: [
// // // //             IconButton(
// // // //               onPressed: () {
// // // //                 if (!_isRunning) {
// // // //                   setState(() {
// // // //                     if (title == 'Study Time') {
// // // //                       _studyTime++;
// // // //                     } else if (title == 'Break Time') {
// // // //                       _breakTime++;
// // // //                     } else {
// // // //                       _longBreakTime++;
// // // //                     }
// // // //                     restartTimer();
// // // //                   });
// // // //                 }
// // // //               },
// // // //               icon: Icon(Icons.add),
// // // //             ),
// // // //             IconButton(
// // // //               onPressed: () {
// // // //                 if (!_isRunning) {
// // // //                   setState(() {
// // // //                     if (title == 'Study Time' && _studyTime > 1) {
// // // //                       _studyTime--;
// // // //                     } else if (title == 'Break Time' && _breakTime > 1) {
// // // //                       _breakTime--;
// // // //                     } else if (title == 'Long Break Time' && _longBreakTime > 1) {
// // // //                       _longBreakTime--;
// // // //                     }
// // // //                     restartTimer();
// // // //                   });
// // // //                 }
// // // //               },
// // // //               icon: Icon(Icons.remove),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }

// // // //   @override
// // // //   void dispose() {
// // // //     _timer?.cancel();
// // // //     super.dispose();
// // // //   }
// // // // }









// // // // //trying to re-appear the restart button but its a fail so i will return to vrsion 4.0
// // // // import 'dart:async';
// // // // import 'package:flutter/material.dart';

// // // // void main() {
// // // //   runApp(MyApp());
// // // // }

// // // // class MyApp extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return MaterialApp(
// // // //       title: 'Pomodoro Timer',
// // // //       theme: ThemeData(
// // // //         primarySwatch: Colors.blue,
// // // //       ),
// // // //       home: PomodoroTimer(),
// // // //     );
// // // //   }
// // // // }

// // // // class PomodoroTimer extends StatefulWidget {
// // // //   @override
// // // //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // // // }

// // // // class _PomodoroTimerState extends State<PomodoroTimer> {
// // // //   int _studyTime = 25;
// // // //   int _breakTime = 5;
// // // //   int _longBreakTime = 15;
// // // //   int _currentTimer = 0;
// // // //   int _iterations = 0;
// // // //   bool _isRunning = false;
// // // //   bool _showPauseButton = true; // New boolean variable
// // // //   String _timerText = '25:00';
// // // //   int _remainingSeconds = 0;

// // // //   Timer? _timer;

// // // //   void startTimer(int minutes) {
// // // //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // //       setState(() {
// // // //         if (seconds > 0) {
// // // //           seconds--;
// // // //           int minutes = seconds ~/ 60;
// // // //           int remainingSeconds = seconds % 60;
// // // //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // //           _remainingSeconds = seconds; // Save remaining seconds
// // // //         } else {
// // // //           _timer!.cancel();
// // // //           if (_currentTimer == 0) {
// // // //             _iterations++;
// // // //             if (_iterations % 3 == 0) {
// // // //               _currentTimer = 2; // Long Break
// // // //               _timerText = '$_longBreakTime:00';
// // // //             } else {
// // // //               _currentTimer = 1; // Break
// // // //               _timerText = '$_breakTime:00';
// // // //             }
// // // //           } else {
// // // //             _currentTimer = 0; // Study
// // // //             _timerText = '$_studyTime:00';
// // // //           }
// // // //           _isRunning = false;
// // // //           _showPauseButton = false; // Hide pause button when the timer stops
// // // //         }
// // // //       });
// // // //     });
// // // //   }

// // // //   void pauseTimer() {
// // // //     if (_isRunning) {
// // // //       _timer?.cancel();
// // // //       _isRunning = false;
// // // //       _showPauseButton = false; // Hide pause button when the timer is paused
// // // //     }
// // // //   }

// // // //   void restartTimer() {
// // // //     pauseTimer();
// // // //     setState(() {
// // // //       _remainingSeconds = 0; // Reset remaining seconds
// // // //       if (_currentTimer == 0) {
// // // //         _timerText = '$_studyTime:00';
// // // //       } else if (_currentTimer == 1) {
// // // //         _timerText = '$_breakTime:00';
// // // //       } else {
// // // //         _timerText = '$_longBreakTime:00';
// // // //       }
// // // //       _showPauseButton = true; // Show pause button when the timer is restarted
// // // //     });
// // // //   }

// // // //   void continueTimer() {
// // // //     if (!_isRunning) {
// // // //       _isRunning = true;
// // // //       startTimer(_remainingSeconds ~/ 60);
// // // //       _showPauseButton = true; // Show pause button when the timer continues
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Pomodoro Timer'),
// // // //       ),
// // // //       body: Center(
// // // //         child: Column(
// // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // //           children: [
// // // //             Stack(
// // // //               alignment: Alignment.center,
// // // //               children: [
// // // //                 SizedBox(
// // // //                   width: 200,
// // // //                   height: 200,
// // // //                   child: CircularProgressIndicator(
// // // //                     value: _isRunning
// // // //                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// // // //                         : 0,
// // // //                     backgroundColor: Colors.grey[300],
// // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// // // //                     strokeWidth: 20,
// // // //                   ),
// // // //                 ),
// // // //                 Text(
// // // //                   _timerText,
// // // //                   style: TextStyle(fontSize: 30, color: Colors.grey),
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //             SizedBox(height: 20),
// // // //             Row(
// // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // //               children: [
// // // //                 _buildTimeContainer('Study Time', '$_studyTime minutes'),
// // // //                 SizedBox(width: 20),
// // // //                 _buildTimeContainer('Break Time', '$_breakTime minutes'),
// // // //                 SizedBox(width: 20),
// // // //                 _buildTimeContainer('Long Break Time', '$_longBreakTime minutes'),
// // // //               ],
// // // //             ),
// // // //             SizedBox(height: 20),
// // // //             if (!_isRunning) // Render the button only if timer is not running
// // // //               ElevatedButton(
// // // //                 onPressed: () {
// // // //                   if (!_isRunning) {
// // // //                     _isRunning = true;
// // // //                     startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// // // //                     _showPauseButton = true; // Show pause button when the timer starts
// // // //                   }
// // // //                 },
// // // //                 child: Text('Start Timer'),
// // // //               ),
// // // //             if (_showPauseButton) // Render the pause button only if it should be visible
// // // //               ElevatedButton(
// // // //                 onPressed: pauseTimer,
// // // //                 child: Text('Pause Timer'),
// // // //               ),
// // // //             if (!_showPauseButton) // Render the restart button only if it should be visible
// // // //               ElevatedButton(
// // // //                 onPressed: restartTimer,
// // // //                 child: Text('Restart Timer'),
// // // //               ),
// // // //             SizedBox(height: 10),
// // // //             ElevatedButton(
// // // //               onPressed: continueTimer,
// // // //               child: Text('Continue Timer'),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildTimeContainer(String title, String time) {
// // // //     return Column(
// // // //       children: [
// // // //         Text(
// // // //           title,
// // // //           style: TextStyle(color: Colors.grey),
// // // //         ),
// // // //         SizedBox(height: 5),
// // // //         Container(
// // // //           padding: EdgeInsets.all(10),
// // // //           decoration: BoxDecoration(
// // // //             borderRadius: BorderRadius.circular(10),
// // // //             border: Border.all(color: Colors.green),
// // // //           ),
// // // //           child: Text(
// // // //             time,
// // // //             style: TextStyle(color: Colors.grey),
// // // //           ),
// // // //         ),
// // // //         SizedBox(height: 5),
// // // //         Row(
// // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // //           children: [
// // // //             IconButton(
// // // //               onPressed: () {
// // // //                 if (!_isRunning) {
// // // //                   setState(() {
// // // //                     if (title == 'Study Time') {
// // // //                       _studyTime++;
// // // //                     } else if (title == 'Break Time') {
// // // //                       _breakTime++;
// // // //                     } else {
// // // //                       _longBreakTime++;
// // // //                     }
// // // //                     restartTimer();
// // // //                   });
// // // //                 }
// // // //               },
// // // //               icon: Icon(Icons.add),
// // // //             ),
// // // //             IconButton(
// // // //               onPressed: () {
// // // //                 if (!_isRunning) {
// // // //                   setState(() {
// // // //                     if (title == 'Study Time' && _studyTime > 1) {
// // // //                       _studyTime--;
// // // //                     } else if (title == 'Break Time' && _breakTime > 1) {
// // // //                       _breakTime--;
// // // //                     } else if (title == 'Long Break Time' && _longBreakTime > 1) {
// // // //                       _longBreakTime--;
// // // //                     }
// // // //                     restartTimer();
// // // //                   });
// // // //                 }
// // // //               },
// // // //               icon: Icon(Icons.remove),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }

// // // //   @override
// // // //   void dispose() {
// // // //     _timer?.cancel();
// // // //     super.dispose();
// // // //   }
// // // // }










// // // //sucssess 4.0 with desappear of start button

// // // // import 'dart:async';
// // // // import 'package:flutter/material.dart';

// // // // void main() {
// // // //   runApp(MyApp());
// // // // }

// // // // class MyApp extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return MaterialApp(
// // // //       title: 'Pomodoro Timer',
// // // //       theme: ThemeData(
// // // //         primarySwatch: Colors.blue,
// // // //       ),
// // // //       home: PomodoroTimer(),
// // // //     );
// // // //   }
// // // // }

// // // // class PomodoroTimer extends StatefulWidget {
// // // //   @override
// // // //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // // // }

// // // // class _PomodoroTimerState extends State<PomodoroTimer> {
// // // //   int _studyTime = 25;
// // // //   int _breakTime = 5;
// // // //   int _longBreakTime = 15;
// // // //   int _currentTimer = 0;
// // // //   int _iterations = 0;
// // // //   bool _isRunning = false;
// // // //   String _timerText = '25:00';
// // // //   int _remainingSeconds = 0;

// // // //   Timer? _timer;

// // // //   void startTimer(int minutes) {
// // // //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // //       setState(() {
// // // //         if (seconds > 0) {
// // // //           seconds--;
// // // //           int minutes = seconds ~/ 60;
// // // //           int remainingSeconds = seconds % 60;
// // // //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // //           _remainingSeconds = seconds; // Save remaining seconds
// // // //         } else {
// // // //           _timer!.cancel();
// // // //           if (_currentTimer == 0) {
// // // //             _iterations++;
// // // //             if (_iterations % 3 == 0) {
// // // //               _currentTimer = 2; // Long Break
// // // //               _timerText = '$_longBreakTime:00';
// // // //             } else {
// // // //               _currentTimer = 1; // Break
// // // //               _timerText = '$_breakTime:00';
// // // //             }
// // // //           } else {
// // // //             _currentTimer = 0; // Study
// // // //             _timerText = '$_studyTime:00';
// // // //           }
// // // //           _isRunning = false;
// // // //         }
// // // //       });
// // // //     });
// // // //   }

// // // //   void pauseTimer() {
// // // //     if (_isRunning) {
// // // //       _timer?.cancel();
// // // //       _isRunning = false;
// // // //     }
// // // //   }

// // // //   void restartTimer() {
// // // //     pauseTimer();
// // // //     setState(() {
// // // //       _remainingSeconds = 0; // Reset remaining seconds
// // // //       if (_currentTimer == 0) {
// // // //         _timerText = '$_studyTime:00';
// // // //       } else if (_currentTimer == 1) {
// // // //         _timerText = '$_breakTime:00';
// // // //       } else {
// // // //         _timerText = '$_longBreakTime:00';
// // // //       }
// // // //     });
// // // //   }

// // // //   void continueTimer() {
// // // //     if (!_isRunning) {
// // // //       _isRunning = true;
// // // //       startTimer(_remainingSeconds ~/ 60);
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Pomodoro Timer'),
// // // //       ),
// // // //       body: Center(
// // // //         child: Column(
// // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // //           children: [
// // // //             Stack(
// // // //               alignment: Alignment.center,
// // // //               children: [
// // // //                 SizedBox(
// // // //                   width: 200,
// // // //                   height: 200,
// // // //                   child: CircularProgressIndicator(
// // // //                     value: _isRunning
// // // //                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// // // //                         : 0,
// // // //                     backgroundColor: Colors.grey[300],
// // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// // // //                     strokeWidth: 20,
// // // //                   ),
// // // //                 ),
// // // //                 Text(
// // // //                   _timerText,
// // // //                   style: TextStyle(fontSize: 30, color: Colors.grey),
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //             SizedBox(height: 20),
// // // //             Row(
// // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // //               children: [
// // // //                 _buildTimeContainer('Study Time', '$_studyTime minutes'),
// // // //                 SizedBox(width: 20),
// // // //                 _buildTimeContainer('Break Time', '$_breakTime minutes'),
// // // //                 SizedBox(width: 20),
// // // //                 _buildTimeContainer('Long Break Time', '$_longBreakTime minutes'),
// // // //               ],
// // // //             ),
// // // //             SizedBox(height: 20),
// // // //             if (!_isRunning) // Render the button only if timer is not running
// // // //               ElevatedButton(
// // // //                 onPressed: () {
// // // //                   if (!_isRunning) {
// // // //                     _isRunning = true;
// // // //                     startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// // // //                   }
// // // //                 },
// // // //                 child: Text('Start Timer'),
// // // //               ),
// // // //             SizedBox(height: 10),
// // // //             ElevatedButton(
// // // //               onPressed: pauseTimer,
// // // //               child: Text('Pause Timer'),
// // // //             ),
// // // //             SizedBox(height: 10),
// // // //             ElevatedButton(
// // // //               onPressed: restartTimer,
// // // //               child: Text('Restart Timer'),
// // // //             ),
// // // //             SizedBox(height: 10),
// // // //             ElevatedButton(
// // // //               onPressed: continueTimer,
// // // //               child: Text('Continue Timer'),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildTimeContainer(String title, String time) {
// // // //     return Column(
// // // //       children: [
// // // //         Text(
// // // //           title,
// // // //           style: TextStyle(color: Colors.grey),
// // // //         ),
// // // //         SizedBox(height: 5),
// // // //         Container(
// // // //           padding: EdgeInsets.all(10),
// // // //           decoration: BoxDecoration(
// // // //             borderRadius: BorderRadius.circular(10),
// // // //             border: Border.all(color: Colors.green),
// // // //           ),
// // // //           child: Text(
// // // //             time,
// // // //             style: TextStyle(color: Colors.grey),
// // // //           ),
// // // //         ),
// // // //         SizedBox(height: 5),
// // // //         Row(
// // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // //           children: [
// // // //             IconButton(
// // // //               onPressed: () {
// // // //                 if (!_isRunning) {
// // // //                   setState(() {
// // // //                     if (title == 'Study Time') {
// // // //                       _studyTime++;
// // // //                     } else if (title == 'Break Time') {
// // // //                       _breakTime++;
// // // //                     } else {
// // // //                       _longBreakTime++;
// // // //                     }
// // // //                     restartTimer();
// // // //                   });
// // // //                 }
// // // //               },
// // // //               icon: Icon(Icons.add),
// // // //             ),
// // // //             IconButton(
// // // //               onPressed: () {
// // // //                 if (!_isRunning) {
// // // //                   setState(() {
// // // //                     if (title == 'Study Time' && _studyTime > 1) {
// // // //                       _studyTime--;
// // // //                     } else if (title == 'Break Time' && _breakTime > 1) {
// // // //                       _breakTime--;
// // // //                     } else if (title == 'Long Break Time' && _longBreakTime > 1) {
// // // //                       _longBreakTime--;
// // // //                     }
// // // //                     restartTimer();
// // // //                   });
// // // //                 }
// // // //               },
// // // //               icon: Icon(Icons.remove),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }

// // // //   @override
// // // //   void dispose() {
// // // //     _timer?.cancel();
// // // //     super.dispose();
// // // //   }
// // // // }






// // // // //sucsess 3.0 put the text of (study time, break time, and long break time )above the container not inside  )  and also the increase and decrease  button under the container so the only the time is inside the container

// // // // // import 'dart:async';
// // // // // import 'package:flutter/material.dart';

// // // // // void main() {
// // // // //   runApp(MyApp());
// // // // // }

// // // // // class MyApp extends StatelessWidget {
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return MaterialApp(
// // // // //       title: 'Pomodoro Timer',
// // // // //       theme: ThemeData(
// // // // //         primarySwatch: Colors.blue,
// // // // //       ),
// // // // //       home: PomodoroTimer(),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // class PomodoroTimer extends StatefulWidget {
// // // // //   @override
// // // // //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // // // // }

// // // // // class _PomodoroTimerState extends State<PomodoroTimer> {
// // // // //   int _studyTime = 25;
// // // // //   int _breakTime = 5;
// // // // //   int _longBreakTime = 15;
// // // // //   int _currentTimer = 0;
// // // // //   int _iterations = 0;
// // // // //   bool _isRunning = false;
// // // // //   String _timerText = '25:00';
// // // // //   int _remainingSeconds = 0;

// // // // //   Timer? _timer;

// // // // //   void startTimer(int minutes) {
// // // // //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// // // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // // //       setState(() {
// // // // //         if (seconds > 0) {
// // // // //           seconds--;
// // // // //           int minutes = seconds ~/ 60;
// // // // //           int remainingSeconds = seconds % 60;
// // // // //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // // //           _remainingSeconds = seconds; // Save remaining seconds
// // // // //         } else {
// // // // //           _timer!.cancel();
// // // // //           if (_currentTimer == 0) {
// // // // //             _iterations++;
// // // // //             if (_iterations % 3 == 0) {
// // // // //               _currentTimer = 2; // Long Break
// // // // //               _timerText = '$_longBreakTime:00';
// // // // //             } else {
// // // // //               _currentTimer = 1; // Break
// // // // //               _timerText = '$_breakTime:00';
// // // // //             }
// // // // //           } else {
// // // // //             _currentTimer = 0; // Study
// // // // //             _timerText = '$_studyTime:00';
// // // // //           }
// // // // //           _isRunning = false;
// // // // //         }
// // // // //       });
// // // // //     });
// // // // //   }

// // // // //   void pauseTimer() {
// // // // //     if (_isRunning) {
// // // // //       _timer?.cancel();
// // // // //       _isRunning = false;
// // // // //     }
// // // // //   }
// // // // // void restartTimer() {
// // // // //   pauseTimer();
// // // // //   setState(() {
// // // // //     _remainingSeconds = 0; // Reset remaining seconds
// // // // //     if (_currentTimer == 0) {
// // // // //       _timerText = '$_studyTime:00';
// // // // //     } else if (_currentTimer == 1) {
// // // // //       _timerText = '$_breakTime:00';
// // // // //     } else {
// // // // //       _timerText = '$_longBreakTime:00';
// // // // //     }
// // // // //   });
// // // // // }

  

// // // // //   void continueTimer() {
// // // // //     if (!_isRunning) {
// // // // //       _isRunning = true;
// // // // //       startTimer(_remainingSeconds ~/ 60);
// // // // //     }
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text('Pomodoro Timer'),
// // // // //       ),
// // // // //       body: Center(
// // // // //         child: Column(
// // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // //           children: [
// // // // //             Stack(
// // // // //               alignment: Alignment.center,
// // // // //               children: [
// // // // //                 SizedBox(
// // // // //                   width: 200,
// // // // //                   height: 200,
// // // // //                   child: CircularProgressIndicator(
// // // // //                     value: _isRunning
// // // // //                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// // // // //                         : 0,
// // // // //                     backgroundColor: Colors.grey[300],
// // // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// // // // //                     strokeWidth: 20,
// // // // //                   ),
// // // // //                 ),
// // // // //                 Text(
// // // // //                   _timerText,
// // // // //                   style: TextStyle(fontSize: 30, color: Colors.grey),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //             SizedBox(height: 20),
// // // // //             Row(
// // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // //               children: [
// // // // //                 _buildTimeContainer('Study Time', '$_studyTime minutes'),
// // // // //                 SizedBox(width: 20),
// // // // //                 _buildTimeContainer('Break Time', '$_breakTime minutes'),
// // // // //                 SizedBox(width: 20),
// // // // //                 _buildTimeContainer('Long Break Time', '$_longBreakTime minutes'),
// // // // //               ],
// // // // //             ),
// // // // //             SizedBox(height: 20),
// // // // //             ElevatedButton(
// // // // //               onPressed: () {
// // // // //                 if (!_isRunning) {
// // // // //                   _isRunning = true;
// // // // //                   startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// // // // //                 }
// // // // //               },
// // // // //               child: Text(_isRunning ? 'Timer Running' : 'Start Timer'),
// // // // //             ),
// // // // //             SizedBox(height: 10),
// // // // //             ElevatedButton(
// // // // //               onPressed: pauseTimer,
// // // // //               child: Text('Pause Timer'),
// // // // //             ),
// // // // //             SizedBox(height: 10),
// // // // //             ElevatedButton(
// // // // //               onPressed: restartTimer,
// // // // //               child: Text('Restart Timer'),
// // // // //             ),
// // // // //             SizedBox(height: 10),
// // // // //             ElevatedButton(
// // // // //               onPressed: continueTimer,
// // // // //               child: Text('Continue Timer'),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildTimeContainer(String title, String time) {
// // // // //     return Column(
// // // // //       children: [
// // // // //         Text(
// // // // //           title,
// // // // //           style: TextStyle(color: Colors.grey),
// // // // //         ),
// // // // //         SizedBox(height: 5),
// // // // //         Container(
// // // // //           padding: EdgeInsets.all(10),
// // // // //           decoration: BoxDecoration(
// // // // //             borderRadius: BorderRadius.circular(10),
// // // // //             border: Border.all(color: Colors.green),
// // // // //           ),
// // // // //           child: Text(
// // // // //             time,
// // // // //             style: TextStyle(color: Colors.grey),
// // // // //           ),
// // // // //         ),
// // // // //         SizedBox(height: 5),
// // // // //         Row(
// // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // //           children: [
// // // // //             IconButton(
// // // // //               onPressed: () {
// // // // //                 if (!_isRunning) {
// // // // //                   setState(() {
// // // // //                     if (title == 'Study Time') {
// // // // //                       _studyTime++;
// // // // //                     } else if (title == 'Break Time') {
// // // // //                       _breakTime++;
// // // // //                     } else {
// // // // //                       _longBreakTime++;
// // // // //                     }
// // // // //                     restartTimer();
// // // // //                   });
// // // // //                 }
// // // // //               },
// // // // //               icon: Icon(Icons.add),
// // // // //             ),
// // // // //             IconButton(
// // // // //               onPressed: () {
// // // // //                 if (!_isRunning) {
// // // // //                   setState(() {
// // // // //                     if (title == 'Study Time' && _studyTime > 1) {
// // // // //                       _studyTime--;
// // // // //                     } else if (title == 'Break Time' && _breakTime > 1) {
// // // // //                       _breakTime--;
// // // // //                     } else if (title == 'Long Break Time' && _longBreakTime > 1) {
// // // // //                       _longBreakTime--;
// // // // //                     }
// // // // //                     restartTimer();
// // // // //                   });
// // // // //                 }
// // // // //               },
// // // // //               icon: Icon(Icons.remove),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ],
// // // // //     );
// // // // //   }

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _timer?.cancel();
// // // // //     super.dispose();
// // // // //   }
// // // // // }







// // // // // //need ui modification

// // // // // // import 'dart:async';
// // // // // // import 'package:flutter/material.dart';

// // // // // // void main() {
// // // // // //   runApp(MyApp());
// // // // // // }

// // // // // // class MyApp extends StatelessWidget {
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return MaterialApp(
// // // // // //       title: 'Pomodoro Timer',
// // // // // //       theme: ThemeData(
// // // // // //         primarySwatch: Colors.blue,
// // // // // //       ),
// // // // // //       home: PomodoroTimer(),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // // class PomodoroTimer extends StatefulWidget {
// // // // // //   @override
// // // // // //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // // // // // }

// // // // // // class _PomodoroTimerState extends State<PomodoroTimer> {
// // // // // //   int _studyTime = 25;
// // // // // //   int _breakTime = 5;
// // // // // //   int _longBreakTime = 15;
// // // // // //   int _currentTimer = 0;
// // // // // //   int _iterations = 0;
// // // // // //   bool _isRunning = false;
// // // // // //   String _timerText = '25:00';
// // // // // //   int _remainingSeconds = 0;

// // // // // //   Timer? _timer;

// // // // // //   void startTimer(int minutes) {
// // // // // //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// // // // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // // // //       setState(() {
// // // // // //         if (seconds > 0) {
// // // // // //           seconds--;
// // // // // //           int minutes = seconds ~/ 60;
// // // // // //           int remainingSeconds = seconds % 60;
// // // // // //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // // // //           _remainingSeconds = seconds; // Save remaining seconds
// // // // // //         } else {
// // // // // //           _timer!.cancel();
// // // // // //           if (_currentTimer == 0) {
// // // // // //             _iterations++;
// // // // // //             if (_iterations % 3 == 0) {
// // // // // //               _currentTimer = 2; // Long Break
// // // // // //               _timerText = '$_longBreakTime:00';
// // // // // //             } else {
// // // // // //               _currentTimer = 1; // Break
// // // // // //               _timerText = '$_breakTime:00';
// // // // // //             }
// // // // // //           } else {
// // // // // //             _currentTimer = 0; // Study
// // // // // //             _timerText = '$_studyTime:00';
// // // // // //           }
// // // // // //           _isRunning = false;
// // // // // //         }
// // // // // //       });
// // // // // //     });
// // // // // //   }

// // // // // //   void pauseTimer() {
// // // // // //     if (_isRunning) {
// // // // // //       _timer?.cancel();
// // // // // //       _isRunning = false;
// // // // // //     }
// // // // // //   }

// // // // // //   void restartTimer() {
// // // // // //     pauseTimer();
// // // // // //     setState(() {
// // // // // //       if (_currentTimer == 0) {
// // // // // //         _timerText = '$_studyTime:00';
// // // // // //       } else if (_currentTimer == 1) {
// // // // // //         _timerText = '$_breakTime:00';
// // // // // //       } else {
// // // // // //         _timerText = '$_longBreakTime:00';
// // // // // //       }
// // // // // //     });
// // // // // //   }

// // // // // //   void continueTimer() {
// // // // // //     if (!_isRunning) {
// // // // // //       _isRunning = true;
// // // // // //       startTimer(_remainingSeconds ~/ 60);
// // // // // //     }
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       appBar: AppBar(
// // // // // //         title: Text('Pomodoro Timer'),
// // // // // //       ),
// // // // // //       body: Center(
// // // // // //         child: Column(
// // // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // // //           children: [
// // // // // //             Stack(
// // // // // //               alignment: Alignment.center,
// // // // // //               children: [
// // // // // //                 SizedBox(
// // // // // //                   width: 200,
// // // // // //                   height: 200,
// // // // // //                   child: CircularProgressIndicator(
// // // // // //                     value: _isRunning
// // // // // //                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// // // // // //                         : 0,
// // // // // //                     backgroundColor: Colors.grey[300],
// // // // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// // // // // //                     strokeWidth: 20,
// // // // // //                   ),
// // // // // //                 ),
// // // // // //                 Text(
// // // // // //                   _timerText,
// // // // // //                   style: TextStyle(fontSize: 30, color: Colors.grey),
// // // // // //                 ),
// // // // // //               ],
// // // // // //             ),
// // // // // //             SizedBox(height: 20),
// // // // // //             Row(
// // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // //               children: [
// // // // // //                 _buildTimeContainer('Study Time', '$_studyTime minutes'),
// // // // // //                 SizedBox(width: 20),
// // // // // //                 _buildTimeContainer('Break Time', '$_breakTime minutes'),
// // // // // //                 SizedBox(width: 20),
// // // // // //                 _buildTimeContainer('Long Break Time', '$_longBreakTime minutes'),
// // // // // //               ],
// // // // // //             ),
// // // // // //             SizedBox(height: 20),
// // // // // //             ElevatedButton(
// // // // // //               onPressed: () {
// // // // // //                 if (!_isRunning) {
// // // // // //                   _isRunning = true;
// // // // // //                   startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// // // // // //                 }
// // // // // //               },
// // // // // //               child: Text(_isRunning ? 'Timer Running' : 'Start Timer'),
// // // // // //             ),
// // // // // //             SizedBox(height: 10),
// // // // // //             ElevatedButton(
// // // // // //               onPressed: pauseTimer,
// // // // // //               child: Text('Pause Timer'),
// // // // // //             ),
// // // // // //             SizedBox(height: 10),
// // // // // //             ElevatedButton(
// // // // // //               onPressed: restartTimer,
// // // // // //               child: Text('Restart Timer'),
// // // // // //             ),
// // // // // //             SizedBox(height: 10),
// // // // // //             ElevatedButton(
// // // // // //               onPressed: continueTimer,
// // // // // //               child: Text('Continue Timer'),
// // // // // //             ),
// // // // // //           ],
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildTimeContainer(String title, String time) {
// // // // // //     return Container(
// // // // // //       padding: EdgeInsets.all(10),
// // // // // //       decoration: BoxDecoration(
// // // // // //         borderRadius: BorderRadius.circular(10),
// // // // // //         border: Border.all(color: Colors.green),
// // // // // //       ),
// // // // // //       child: Column(
// // // // // //         children: [
// // // // // //           Text(
// // // // // //             title,
// // // // // //             style: TextStyle(color: Colors.grey),
// // // // // //           ),
// // // // // //           SizedBox(height: 5),
// // // // // //           Text(
// // // // // //             time,
// // // // // //             style: TextStyle(color: Colors.grey),
// // // // // //           ),
// // // // // //           SizedBox(height: 5),
// // // // // //           Row(
// // // // // //             mainAxisAlignment: MainAxisAlignment.center,
// // // // // //             children: [
// // // // // //               IconButton(
// // // // // //                 onPressed: () {
// // // // // //                   if (!_isRunning) {
// // // // // //                     setState(() {
// // // // // //                       if (title == 'Study Time') {
// // // // // //                         _studyTime++;
// // // // // //                       } else if (title == 'Break Time') {
// // // // // //                         _breakTime++;
// // // // // //                       } else {
// // // // // //                         _longBreakTime++;
// // // // // //                       }
// // // // // //                       restartTimer();
// // // // // //                     });
// // // // // //                   }
// // // // // //                 },
// // // // // //                 icon: Icon(Icons.add),
// // // // // //               ),
// // // // // //               IconButton(
// // // // // //                 onPressed: () {
// // // // // //                   if (!_isRunning) {
// // // // // //                     setState(() {
// // // // // //                       if (title == 'Study Time' && _studyTime > 1) {
// // // // // //                         _studyTime--;
// // // // // //                       } else if (title == 'Break Time' && _breakTime > 1) {
// // // // // //                         _breakTime--;
// // // // // //                       } else if (title == 'Long Break Time' && _longBreakTime > 1) {
// // // // // //                         _longBreakTime--;
// // // // // //                       }
// // // // // //                       restartTimer();
// // // // // //                     });
// // // // // //                   }
// // // // // //                 },
// // // // // //                 icon: Icon(Icons.remove),
// // // // // //               ),
// // // // // //             ],
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   @override
// // // // // //   void dispose() {
// // // // // //     _timer?.cancel();
// // // // // //     super.dispose();
// // // // // //   }
// // // // // // }







// // // // // // //sucsess 2.0
// // // // // // // import 'dart:async';
// // // // // // // import 'package:flutter/material.dart';

// // // // // // // void main() {
// // // // // // //   runApp(MyApp());
// // // // // // // }

// // // // // // // class MyApp extends StatelessWidget {
// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return MaterialApp(
// // // // // // //       title: 'Pomodoro Timer',
// // // // // // //       theme: ThemeData(
// // // // // // //         primarySwatch: Colors.blue,
// // // // // // //       ),
// // // // // // //       home: PomodoroTimer(),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }

// // // // // // // class PomodoroTimer extends StatefulWidget {
// // // // // // //   @override
// // // // // // //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // // // // // // }

// // // // // // // class _PomodoroTimerState extends State<PomodoroTimer> {
// // // // // // //   int _studyTime = 25;
// // // // // // //   int _breakTime = 5;
// // // // // // //   int _longBreakTime = 15;
// // // // // // //   int _currentTimer = 0;
// // // // // // //   int _iterations = 0;
// // // // // // //   bool _isRunning = false;
// // // // // // //   String _timerText = '25:00';
// // // // // // //   int _remainingSeconds = 0;

// // // // // // //   Timer? _timer;

// // // // // // //   void startTimer(int minutes) {
// // // // // // //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// // // // // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // // // // //       setState(() {
// // // // // // //         if (seconds > 0) {
// // // // // // //           seconds--;
// // // // // // //           int minutes = seconds ~/ 60;
// // // // // // //           int remainingSeconds = seconds % 60;
// // // // // // //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // // // // //           _remainingSeconds = seconds; // Save remaining seconds
// // // // // // //         } else {
// // // // // // //           _timer!.cancel();
// // // // // // //           if (_currentTimer == 0) {
// // // // // // //             _iterations++;
// // // // // // //             if (_iterations % 3 == 0) {
// // // // // // //               _currentTimer = 2; // Long Break
// // // // // // //               _timerText = '$_longBreakTime:00';
// // // // // // //             } else {
// // // // // // //               _currentTimer = 1; // Break
// // // // // // //               _timerText = '$_breakTime:00';
// // // // // // //             }
// // // // // // //           } else {
// // // // // // //             _currentTimer = 0; // Study
// // // // // // //             _timerText = '$_studyTime:00';
// // // // // // //           }
// // // // // // //           _isRunning = false;
// // // // // // //         }
// // // // // // //       });
// // // // // // //     });
// // // // // // //   }

// // // // // // //   void pauseTimer() {
// // // // // // //     if (_isRunning) {
// // // // // // //       _timer?.cancel();
// // // // // // //       _isRunning = false;
// // // // // // //     }
// // // // // // //   }

// // // // // // //   void restartTimer() {
// // // // // // //     pauseTimer();
// // // // // // //     setState(() {
// // // // // // //       if (_currentTimer == 0) {
// // // // // // //         _timerText = '$_studyTime:00';
// // // // // // //       } else if (_currentTimer == 1) {
// // // // // // //         _timerText = '$_breakTime:00';
// // // // // // //       } else {
// // // // // // //         _timerText = '$_longBreakTime:00';
// // // // // // //       }
// // // // // // //     });
// // // // // // //   }

// // // // // // //   void continueTimer() {
// // // // // // //     if (!_isRunning) {
// // // // // // //       _isRunning = true;
// // // // // // //       startTimer(_remainingSeconds ~/ 60);
// // // // // // //     }
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return Scaffold(
// // // // // // //       appBar: AppBar(
// // // // // // //         title: Text('Pomodoro Timer'),
// // // // // // //       ),
// // // // // // //       body: Center(
// // // // // // //         child: Column(
// // // // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // // // //           children: [
// // // // // // //             Stack(
// // // // // // //               alignment: Alignment.center,
// // // // // // //               children: [
// // // // // // //                 SizedBox(
// // // // // // //                   width: 200,
// // // // // // //                   height: 200,
// // // // // // //                   child: CircularProgressIndicator(
// // // // // // //                     value: _isRunning
// // // // // // //                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// // // // // // //                         : 0,
// // // // // // //                     backgroundColor: Colors.grey[300],
// // // // // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// // // // // // //                     strokeWidth: 20,
// // // // // // //                   ),
// // // // // // //                 ),
// // // // // // //                 Text(
// // // // // // //                   _timerText,
// // // // // // //                   style: TextStyle(fontSize: 30, color: Colors.grey),
// // // // // // //                 ),
// // // // // // //               ],
// // // // // // //             ),
// // // // // // //             SizedBox(height: 20),
// // // // // // //             Row(
// // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // //               children: [
// // // // // // //                 Column(
// // // // // // //                   children: [
// // // // // // //                     Text('Study Time', style: TextStyle(color: Colors.grey)),
// // // // // // //                     Text('$_studyTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // //                     Row(
// // // // // // //                       children: [
// // // // // // //                         IconButton(
// // // // // // //                           onPressed: () {
// // // // // // //                             if (!_isRunning) {
// // // // // // //                               setState(() {
// // // // // // //                                 _studyTime++;
// // // // // // //                                 restartTimer();
// // // // // // //                               });
// // // // // // //                             }
// // // // // // //                           },
// // // // // // //                           icon: Icon(Icons.add),
// // // // // // //                         ),
// // // // // // //                         IconButton(
// // // // // // //                           onPressed: () {
// // // // // // //                             if (!_isRunning && _studyTime > 1) {
// // // // // // //                               setState(() {
// // // // // // //                                 _studyTime--;
// // // // // // //                                 restartTimer();
// // // // // // //                               });
// // // // // // //                             }
// // // // // // //                           },
// // // // // // //                           icon: Icon(Icons.remove),
// // // // // // //                         ),
// // // // // // //                       ],
// // // // // // //                     ),
// // // // // // //                   ],
// // // // // // //                 ),
// // // // // // //                 SizedBox(width: 20),
// // // // // // //                 Column(
// // // // // // //                   children: [
// // // // // // //                     Text('Break Time', style: TextStyle(color: Colors.grey)),
// // // // // // //                     Text('$_breakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // //                     Row(
// // // // // // //                       children: [
// // // // // // //                         IconButton(
// // // // // // //                           onPressed: () {
// // // // // // //                             if (!_isRunning) {
// // // // // // //                               setState(() {
// // // // // // //                                 _breakTime++;
// // // // // // //                                 restartTimer();
// // // // // // //                               });
// // // // // // //                             }
// // // // // // //                           },
// // // // // // //                           icon: Icon(Icons.add),
// // // // // // //                         ),
// // // // // // //                         IconButton(
// // // // // // //                           onPressed: () {
// // // // // // //                             if (!_isRunning && _breakTime > 1) {
// // // // // // //                               setState(() {
// // // // // // //                                 _breakTime--;
// // // // // // //                                 restartTimer();
// // // // // // //                               });
// // // // // // //                             }
// // // // // // //                           },
// // // // // // //                           icon: Icon(Icons.remove),
// // // // // // //                         ),
// // // // // // //                       ],
// // // // // // //                     ),
// // // // // // //                   ],
// // // // // // //                 ),
// // // // // // //                 SizedBox(width: 20),
// // // // // // //                 Column(
// // // // // // //                   children: [
// // // // // // //                     Text('Long Break Time', style: TextStyle(color: Colors.grey)),
// // // // // // //                     Text('$_longBreakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // //                     Row(
// // // // // // //                       children: [
// // // // // // //                         IconButton(
// // // // // // //                           onPressed: () {
// // // // // // //                             if (!_isRunning) {
// // // // // // //                               setState(() {
// // // // // // //                                 _longBreakTime++;
// // // // // // //                                 restartTimer();
// // // // // // //                               });
// // // // // // //                             }
// // // // // // //                           },
// // // // // // //                           icon: Icon(Icons.add),
// // // // // // //                         ),
// // // // // // //                         IconButton(
// // // // // // //                           onPressed: () {
// // // // // // //                             if (!_isRunning && _longBreakTime > 1) {
// // // // // // //                               setState(() {
// // // // // // //                                 _longBreakTime--;
// // // // // // //                                 restartTimer();
// // // // // // //                               });
// // // // // // //                             }
// // // // // // //                           },
// // // // // // //                           icon: Icon(Icons.remove),
// // // // // // //                         ),
// // // // // // //                       ],
// // // // // // //                     ),
// // // // // // //                   ],
// // // // // // //                 ),
// // // // // // //               ],
// // // // // // //             ),
// // // // // // //             SizedBox(height: 20),
// // // // // // //             ElevatedButton(
// // // // // // //               onPressed: () {
// // // // // // //                 if (!_isRunning) {
// // // // // // //                   _isRunning = true;
// // // // // // //                   startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// // // // // // //                 }
// // // // // // //               },
// // // // // // //               child: Text(_isRunning ? 'Timer Running' : 'Start Timer'),
// // // // // // //             ),
// // // // // // //             SizedBox(height: 10),
// // // // // // //             ElevatedButton(
// // // // // // //               onPressed: pauseTimer,
// // // // // // //               child: Text('Pause Timer'),
// // // // // // //             ),
// // // // // // //             SizedBox(height: 10),
// // // // // // //             ElevatedButton(
// // // // // // //               onPressed: restartTimer,
// // // // // // //               child: Text('Restart Timer'),
// // // // // // //             ),
// // // // // // //             SizedBox(height: 10),
// // // // // // //             ElevatedButton(
// // // // // // //               onPressed: continueTimer,
// // // // // // //               child: Text('Continue Timer'),
// // // // // // //             ),
// // // // // // //           ],
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   void dispose() {
// // // // // // //     _timer?.cancel();
// // // // // // //     super.dispose();
// // // // // // //   }
// // // // // // // }





// // // // // // // //sucsses but i want the icons to be under the time 
// // // // // // // // import 'dart:async';
// // // // // // // // import 'package:flutter/material.dart';

// // // // // // // // void main() {
// // // // // // // //   runApp(MyApp());
// // // // // // // // }

// // // // // // // // class MyApp extends StatelessWidget {
// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     return MaterialApp(
// // // // // // // //       title: 'Pomodoro Timer',
// // // // // // // //       theme: ThemeData(
// // // // // // // //         primarySwatch: Colors.blue,
// // // // // // // //       ),
// // // // // // // //       home: PomodoroTimer(),
// // // // // // // //     );
// // // // // // // //   }
// // // // // // // // }

// // // // // // // // class PomodoroTimer extends StatefulWidget {
// // // // // // // //   @override
// // // // // // // //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // // // // // // // }

// // // // // // // // class _PomodoroTimerState extends State<PomodoroTimer> {
// // // // // // // //   int _studyTime = 25;
// // // // // // // //   int _breakTime = 5;
// // // // // // // //   int _longBreakTime = 15;
// // // // // // // //   int _currentTimer = 0;
// // // // // // // //   int _iterations = 0;
// // // // // // // //   bool _isRunning = false;
// // // // // // // //   String _timerText = '25:00';
// // // // // // // //   int _remainingSeconds = 0;

// // // // // // // //   Timer? _timer;

// // // // // // // //   void startTimer(int minutes) {
// // // // // // // //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// // // // // // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // // // // // //       setState(() {
// // // // // // // //         if (seconds > 0) {
// // // // // // // //           seconds--;
// // // // // // // //           int minutes = seconds ~/ 60;
// // // // // // // //           int remainingSeconds = seconds % 60;
// // // // // // // //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // // // // // //           _remainingSeconds = seconds; // Save remaining seconds
// // // // // // // //         } else {
// // // // // // // //           _timer!.cancel();
// // // // // // // //           if (_currentTimer == 0) {
// // // // // // // //             _iterations++;
// // // // // // // //             if (_iterations % 3 == 0) {
// // // // // // // //               _currentTimer = 2; // Long Break
// // // // // // // //               _timerText = '$_longBreakTime:00';
// // // // // // // //             } else {
// // // // // // // //               _currentTimer = 1; // Break
// // // // // // // //               _timerText = '$_breakTime:00';
// // // // // // // //             }
// // // // // // // //           } else {
// // // // // // // //             _currentTimer = 0; // Study
// // // // // // // //             _timerText = '$_studyTime:00';
// // // // // // // //           }
// // // // // // // //           _isRunning = false;
// // // // // // // //         }
// // // // // // // //       });
// // // // // // // //     });
// // // // // // // //   }

// // // // // // // //   void pauseTimer() {
// // // // // // // //     if (_isRunning) {
// // // // // // // //       _timer?.cancel();
// // // // // // // //       _isRunning = false;
// // // // // // // //     }
// // // // // // // //   }

// // // // // // // //   void restartTimer() {
// // // // // // // //     pauseTimer();
// // // // // // // //     setState(() {
// // // // // // // //       if (_currentTimer == 0) {
// // // // // // // //         _timerText = '$_studyTime:00';
// // // // // // // //       } else if (_currentTimer == 1) {
// // // // // // // //         _timerText = '$_breakTime:00';
// // // // // // // //       } else {
// // // // // // // //         _timerText = '$_longBreakTime:00';
// // // // // // // //       }
// // // // // // // //     });
// // // // // // // //   }

// // // // // // // //   void continueTimer() {
// // // // // // // //     if (!_isRunning) {
// // // // // // // //       _isRunning = true;
// // // // // // // //       startTimer(_remainingSeconds ~/ 60);
// // // // // // // //     }
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     return Scaffold(
// // // // // // // //       appBar: AppBar(
// // // // // // // //         title: Text('Pomodoro Timer'),
// // // // // // // //       ),
// // // // // // // //       body: Center(
// // // // // // // //         child: Column(
// // // // // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // //           children: [
// // // // // // // //             Stack(
// // // // // // // //               alignment: Alignment.center,
// // // // // // // //               children: [
// // // // // // // //                 SizedBox(
// // // // // // // //                   width: 200,
// // // // // // // //                   height: 200,
// // // // // // // //                   child: CircularProgressIndicator(
// // // // // // // //                     value: _isRunning
// // // // // // // //                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// // // // // // // //                         : 0,
// // // // // // // //                     backgroundColor: Colors.grey[300],
// // // // // // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// // // // // // // //                     strokeWidth: 20,
// // // // // // // //                   ),
// // // // // // // //                 ),
// // // // // // // //                 Text(
// // // // // // // //                   _timerText,
// // // // // // // //                   style: TextStyle(fontSize: 30, color: Colors.grey),
// // // // // // // //                 ),
// // // // // // // //               ],
// // // // // // // //             ),
// // // // // // // //             SizedBox(height: 20),
// // // // // // // //             Row(
// // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // //               children: [
// // // // // // // //                 Column(
// // // // // // // //                   children: [
// // // // // // // //                     Text('Study Time', style: TextStyle(color: Colors.grey)),
// // // // // // // //                     Row(
// // // // // // // //                       children: [
// // // // // // // //                         IconButton(
// // // // // // // //                           onPressed: () {
// // // // // // // //                             if (!_isRunning) {
// // // // // // // //                               setState(() {
// // // // // // // //                                 _studyTime++;
// // // // // // // //                                 restartTimer();
// // // // // // // //                               });
// // // // // // // //                             }
// // // // // // // //                           },
// // // // // // // //                           icon: Icon(Icons.add),
// // // // // // // //                         ),
// // // // // // // //                         IconButton(
// // // // // // // //                           onPressed: () {
// // // // // // // //                             if (!_isRunning && _studyTime > 1) {
// // // // // // // //                               setState(() {
// // // // // // // //                                 _studyTime--;
// // // // // // // //                                 restartTimer();
// // // // // // // //                               });
// // // // // // // //                             }
// // // // // // // //                           },
// // // // // // // //                           icon: Icon(Icons.remove),
// // // // // // // //                         ),
// // // // // // // //                       ],
// // // // // // // //                     ),
// // // // // // // //                     Text('$_studyTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // //                   ],
// // // // // // // //                 ),
// // // // // // // //                 SizedBox(width: 20),
// // // // // // // //                 Column(
// // // // // // // //                   children: [
// // // // // // // //                     Text('Break Time', style: TextStyle(color: Colors.grey)),
// // // // // // // //                     Row(
// // // // // // // //                       children: [
// // // // // // // //                         IconButton(
// // // // // // // //                           onPressed: () {
// // // // // // // //                             if (!_isRunning) {
// // // // // // // //                               setState(() {
// // // // // // // //                                 _breakTime++;
// // // // // // // //                                 restartTimer();
// // // // // // // //                               });
// // // // // // // //                             }
// // // // // // // //                           },
// // // // // // // //                           icon: Icon(Icons.add),
// // // // // // // //                         ),
// // // // // // // //                         IconButton(
// // // // // // // //                           onPressed: () {
// // // // // // // //                             if (!_isRunning && _breakTime > 1) {
// // // // // // // //                               setState(() {
// // // // // // // //                                 _breakTime--;
// // // // // // // //                                 restartTimer();
// // // // // // // //                               });
// // // // // // // //                             }
// // // // // // // //                           },
// // // // // // // //                           icon: Icon(Icons.remove),
// // // // // // // //                         ),
// // // // // // // //                       ],
// // // // // // // //                     ),
// // // // // // // //                     Text('$_breakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // //                   ],
// // // // // // // //                 ),
// // // // // // // //                 SizedBox(width: 20),
// // // // // // // //                 Column(
// // // // // // // //                   children: [
// // // // // // // //                     Text('Long Break Time', style: TextStyle(color: Colors.grey)),
// // // // // // // //                     Row(
// // // // // // // //                       children: [
// // // // // // // //                         IconButton(
// // // // // // // //                           onPressed: () {
// // // // // // // //                             if (!_isRunning) {
// // // // // // // //                               setState(() {
// // // // // // // //                                 _longBreakTime++;
// // // // // // // //                                 restartTimer();
// // // // // // // //                               });
// // // // // // // //                             }
// // // // // // // //                           },
// // // // // // // //                           icon: Icon(Icons.add),
// // // // // // // //                         ),
// // // // // // // //                         IconButton(
// // // // // // // //                           onPressed: () {
// // // // // // // //                             if (!_isRunning && _longBreakTime > 1) {
// // // // // // // //                               setState(() {
// // // // // // // //                                 _longBreakTime--;
// // // // // // // //                                 restartTimer();
// // // // // // // //                               });
// // // // // // // //                             }
// // // // // // // //                           },
// // // // // // // //                           icon: Icon(Icons.remove),
// // // // // // // //                         ),
// // // // // // // //                       ],
// // // // // // // //                     ),
// // // // // // // //                     Text('$_longBreakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // //                   ],
// // // // // // // //                 ),
// // // // // // // //               ],
// // // // // // // //             ),
// // // // // // // //             SizedBox(height: 20),
// // // // // // // //             ElevatedButton(
// // // // // // // //               onPressed: () {
// // // // // // // //                 if (!_isRunning) {
// // // // // // // //                   _isRunning = true;
// // // // // // // //                   startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// // // // // // // //                 }
// // // // // // // //               },
// // // // // // // //               child: Text(_isRunning ? 'Timer Running' : 'Start Timer'),
// // // // // // // //             ),
// // // // // // // //             SizedBox(height: 10),
// // // // // // // //             ElevatedButton(
// // // // // // // //               onPressed: pauseTimer,
// // // // // // // //               child: Text('Pause Timer'),
// // // // // // // //             ),
// // // // // // // //             SizedBox(height: 10),
// // // // // // // //             ElevatedButton(
// // // // // // // //               onPressed: restartTimer,
// // // // // // // //               child: Text('Restart Timer'),
// // // // // // // //             ),
// // // // // // // //             SizedBox(height: 10),
// // // // // // // //             ElevatedButton(
// // // // // // // //               onPressed: continueTimer,
// // // // // // // //               child: Text('Continue Timer'),
// // // // // // // //             ),
// // // // // // // //           ],
// // // // // // // //         ),
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   void dispose() {
// // // // // // // //     _timer?.cancel();
// // // // // // // //     super.dispose();
// // // // // // // //   }
// // // // // // // // }









// // // // // // // // //not sucsses
// // // // // // // // // import 'dart:async';
// // // // // // // // // import 'package:flutter/material.dart';

// // // // // // // // // void main() {
// // // // // // // // //   runApp(MyApp());
// // // // // // // // // }

// // // // // // // // // class MyApp extends StatelessWidget {
// // // // // // // // //   @override
// // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // //     return MaterialApp(
// // // // // // // // //       title: 'Pomodoro Timer',
// // // // // // // // //       theme: ThemeData(
// // // // // // // // //         primarySwatch: Colors.blue,
// // // // // // // // //       ),
// // // // // // // // //       home: PomodoroTimer(),
// // // // // // // // //     );
// // // // // // // // //   }
// // // // // // // // // }

// // // // // // // // // class PomodoroTimer extends StatefulWidget {
// // // // // // // // //   @override
// // // // // // // // //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // // // // // // // // }

// // // // // // // // // class _PomodoroTimerState extends State<PomodoroTimer> {
// // // // // // // // //   int _studyTime = 25;
// // // // // // // // //   int _breakTime = 5;
// // // // // // // // //   int _longBreakTime = 15;
// // // // // // // // //   int _currentTimer = 0;
// // // // // // // // //   int _iterations = 0;
// // // // // // // // //   bool _isRunning = false;
// // // // // // // // //   String _timerText = '25:00';
// // // // // // // // //   int _remainingSeconds = 0;

// // // // // // // // //   Timer? _timer;

// // // // // // // // //   void startTimer(int minutes) {
// // // // // // // // //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// // // // // // // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // // // // // // //       setState(() {
// // // // // // // // //         if (seconds > 0) {
// // // // // // // // //           seconds--;
// // // // // // // // //           int minutes = seconds ~/ 60;
// // // // // // // // //           int remainingSeconds = seconds % 60;
// // // // // // // // //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // // // // // // //           _remainingSeconds = seconds; // Save remaining seconds
// // // // // // // // //         } else {
// // // // // // // // //           _timer!.cancel();
// // // // // // // // //           if (_currentTimer == 0) {
// // // // // // // // //             _iterations++;
// // // // // // // // //             if (_iterations % 3 == 0) {
// // // // // // // // //               _currentTimer = 2; // Long Break
// // // // // // // // //               _timerText = '$_longBreakTime:00';
// // // // // // // // //             } else {
// // // // // // // // //               _currentTimer = 1; // Break
// // // // // // // // //               _timerText = '$_breakTime:00';
// // // // // // // // //             }
// // // // // // // // //           } else {
// // // // // // // // //             _currentTimer = 0; // Study
// // // // // // // // //             _timerText = '$_studyTime:00';
// // // // // // // // //           }
// // // // // // // // //           _isRunning = false;
// // // // // // // // //         }
// // // // // // // // //       });
// // // // // // // // //     });
// // // // // // // // //   }

// // // // // // // // //   void pauseTimer() {
// // // // // // // // //     if (_isRunning) {
// // // // // // // // //       _timer?.cancel();
// // // // // // // // //       _isRunning = false;
// // // // // // // // //     }
// // // // // // // // //   }

// // // // // // // // //   void restartTimer() {
// // // // // // // // //     pauseTimer();
// // // // // // // // //     setState(() {
// // // // // // // // //       if (_currentTimer == 0) {
// // // // // // // // //         _timerText = '$_studyTime:00';
// // // // // // // // //       } else if (_currentTimer == 1) {
// // // // // // // // //         _timerText = '$_breakTime:00';
// // // // // // // // //       } else {
// // // // // // // // //         _timerText = '$_longBreakTime:00';
// // // // // // // // //       }
// // // // // // // // //     });
// // // // // // // // //   }

// // // // // // // // //   void continueTimer() {
// // // // // // // // //     if (!_isRunning) {
// // // // // // // // //       _isRunning = true;
// // // // // // // // //       startTimer(_remainingSeconds ~/ 60);
// // // // // // // // //     }
// // // // // // // // //   }

// // // // // // // // //   @override
// // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // //     return Scaffold(
// // // // // // // // //       appBar: AppBar(
// // // // // // // // //         title: Text('Pomodoro Timer'),
// // // // // // // // //       ),
// // // // // // // // //       body: Center(
// // // // // // // // //         child: Column(
// // // // // // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // //           children: [
// // // // // // // // //             Stack(
// // // // // // // // //               alignment: Alignment.center,
// // // // // // // // //               children: [
// // // // // // // // //                 SizedBox(
// // // // // // // // //                   width: 200,
// // // // // // // // //                   height: 200,
// // // // // // // // //                   child: CircularProgressIndicator(
// // // // // // // // //                     value: _isRunning
// // // // // // // // //                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// // // // // // // // //                         : 0,
// // // // // // // // //                     backgroundColor: Colors.grey[300],
// // // // // // // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// // // // // // // // //                     strokeWidth: 20,
// // // // // // // // //                   ),
// // // // // // // // //                 ),
// // // // // // // // //                 Text(
// // // // // // // // //                   _timerText,
// // // // // // // // //                   style: TextStyle(fontSize: 30, color: Colors.grey),
// // // // // // // // //                 ),
// // // // // // // // //               ],
// // // // // // // // //             ),
// // // // // // // // //             SizedBox(height: 20),
// // // // // // // // //             Row(
// // // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // //               children: [
// // // // // // // // //                 Column(
// // // // // // // // //                   children: [
// // // // // // // // //                     Text('Study Time', style: TextStyle(color: Colors.grey)),
// // // // // // // // //                     Text('$_studyTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // //                   ],
// // // // // // // // //                 ),
// // // // // // // // //                 SizedBox(width: 20),
// // // // // // // // //                 Column(
// // // // // // // // //                   children: [
// // // // // // // // //                     Text('Break Time', style: TextStyle(color: Colors.grey)),
// // // // // // // // //                     Text('$_breakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // //                   ],
// // // // // // // // //                 ),
// // // // // // // // //                 SizedBox(width: 20),
// // // // // // // // //                 Column(
// // // // // // // // //                   children: [
// // // // // // // // //                     Text('Long Break Time', style: TextStyle(color: Colors.grey)),
// // // // // // // // //                     Text('$_longBreakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // //                   ],
// // // // // // // // //                 ),
// // // // // // // // //               ],
// // // // // // // // //             ),
// // // // // // // // //             SizedBox(height: 20),
// // // // // // // // //             ElevatedButton(
// // // // // // // // //               onPressed: () {
// // // // // // // // //                 if (!_isRunning) {
// // // // // // // // //                   _isRunning = true;
// // // // // // // // //                   startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// // // // // // // // //                 }
// // // // // // // // //               },
// // // // // // // // //               child: Text(_isRunning ? 'Timer Running' : 'Start Timer'),
// // // // // // // // //             ),
// // // // // // // // //             SizedBox(height: 10),
// // // // // // // // //             ElevatedButton(
// // // // // // // // //               onPressed: pauseTimer,
// // // // // // // // //               child: Text('Pause Timer'),
// // // // // // // // //             ),
// // // // // // // // //             SizedBox(height: 10),
// // // // // // // // //             ElevatedButton(
// // // // // // // // //               onPressed: restartTimer,
// // // // // // // // //               child: Text('Restart Timer'),
// // // // // // // // //             ),
// // // // // // // // //             SizedBox(height: 10),
// // // // // // // // //             ElevatedButton(
// // // // // // // // //               onPressed: continueTimer,
// // // // // // // // //               child: Text('Continue Timer'),
// // // // // // // // //             ),
// // // // // // // // //           ],
// // // // // // // // //         ),
// // // // // // // // //       ),
// // // // // // // // //     );
// // // // // // // // //   }

// // // // // // // // //   @override
// // // // // // // // //   void dispose() {
// // // // // // // // //     _timer?.cancel();
// // // // // // // // //     super.dispose();
// // // // // // // // //   }
// // // // // // // // // }






// // // // // // // // // //sucsess 1.3 with study time, break time, and long break time beside each other horizontally.
// // // // // // // // // // import 'dart:async';
// // // // // // // // // // import 'package:flutter/material.dart';

// // // // // // // // // // void main() {
// // // // // // // // // //   runApp(MyApp());
// // // // // // // // // // }

// // // // // // // // // // class MyApp extends StatelessWidget {
// // // // // // // // // //   @override
// // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // //     return MaterialApp(
// // // // // // // // // //       title: 'Pomodoro Timer',
// // // // // // // // // //       theme: ThemeData(
// // // // // // // // // //         primarySwatch: Colors.blue,
// // // // // // // // // //       ),
// // // // // // // // // //       home: PomodoroTimer(),
// // // // // // // // // //     );
// // // // // // // // // //   }
// // // // // // // // // // }

// // // // // // // // // // class PomodoroTimer extends StatefulWidget {
// // // // // // // // // //   @override
// // // // // // // // // //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // // // // // // // // // }

// // // // // // // // // // class _PomodoroTimerState extends State<PomodoroTimer> {
// // // // // // // // // //   int _studyTime = 25;
// // // // // // // // // //   int _breakTime = 5;
// // // // // // // // // //   int _longBreakTime = 15;
// // // // // // // // // //   int _currentTimer = 0;
// // // // // // // // // //   int _iterations = 0;
// // // // // // // // // //   bool _isRunning = false;
// // // // // // // // // //   String _timerText = '25:00';
// // // // // // // // // //   int _remainingSeconds = 0;

// // // // // // // // // //   Timer? _timer;

// // // // // // // // // //   void startTimer(int minutes) {
// // // // // // // // // //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// // // // // // // // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // // // // // // // //       setState(() {
// // // // // // // // // //         if (seconds > 0) {
// // // // // // // // // //           seconds--;
// // // // // // // // // //           int minutes = seconds ~/ 60;
// // // // // // // // // //           int remainingSeconds = seconds % 60;
// // // // // // // // // //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // // // // // // // //           _remainingSeconds = seconds; // Save remaining seconds
// // // // // // // // // //         } else {
// // // // // // // // // //           _timer!.cancel();
// // // // // // // // // //           if (_currentTimer == 0) {
// // // // // // // // // //             _iterations++;
// // // // // // // // // //             if (_iterations % 3 == 0) {
// // // // // // // // // //               _currentTimer = 2; // Long Break
// // // // // // // // // //               _timerText = '$_longBreakTime:00';
// // // // // // // // // //             } else {
// // // // // // // // // //               _currentTimer = 1; // Break
// // // // // // // // // //               _timerText = '$_breakTime:00';
// // // // // // // // // //             }
// // // // // // // // // //           } else {
// // // // // // // // // //             _currentTimer = 0; // Study
// // // // // // // // // //             _timerText = '$_studyTime:00';
// // // // // // // // // //           }
// // // // // // // // // //           _isRunning = false;
// // // // // // // // // //         }
// // // // // // // // // //       });
// // // // // // // // // //     });
// // // // // // // // // //   }

// // // // // // // // // //   void pauseTimer() {
// // // // // // // // // //     if (_isRunning) {
// // // // // // // // // //       _timer?.cancel();
// // // // // // // // // //       _isRunning = false;
// // // // // // // // // //     }
// // // // // // // // // //   }

// // // // // // // // // //   void restartTimer() {
// // // // // // // // // //     pauseTimer();
// // // // // // // // // //     setState(() {
// // // // // // // // // //       if (_currentTimer == 0) {
// // // // // // // // // //         _timerText = '$_studyTime:00';
// // // // // // // // // //       } else if (_currentTimer == 1) {
// // // // // // // // // //         _timerText = '$_breakTime:00';
// // // // // // // // // //       } else {
// // // // // // // // // //         _timerText = '$_longBreakTime:00';
// // // // // // // // // //       }
// // // // // // // // // //     });
// // // // // // // // // //   }

// // // // // // // // // //   void continueTimer() {
// // // // // // // // // //     if (!_isRunning) {
// // // // // // // // // //       _isRunning = true;
// // // // // // // // // //       startTimer(_remainingSeconds ~/ 60);
// // // // // // // // // //     }
// // // // // // // // // //   }

// // // // // // // // // //   @override
// // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // //     return Scaffold(
// // // // // // // // // //       appBar: AppBar(
// // // // // // // // // //         title: Text('Pomodoro Timer'),
// // // // // // // // // //       ),
// // // // // // // // // //       body: Center(
// // // // // // // // // //         child: Column(
// // // // // // // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // //           children: [
// // // // // // // // // //             Stack(
// // // // // // // // // //               alignment: Alignment.center,
// // // // // // // // // //               children: [
// // // // // // // // // //                 SizedBox(
// // // // // // // // // //                   width: 200,
// // // // // // // // // //                   height: 200,
// // // // // // // // // //                   child: CircularProgressIndicator(
// // // // // // // // // //                     value: _isRunning
// // // // // // // // // //                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// // // // // // // // // //                         : 0,
// // // // // // // // // //                     backgroundColor: Colors.grey[300],
// // // // // // // // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// // // // // // // // // //                     strokeWidth: 20,
// // // // // // // // // //                   ),
// // // // // // // // // //                 ),
// // // // // // // // // //                 Text(
// // // // // // // // // //                   _timerText,
// // // // // // // // // //                   style: TextStyle(fontSize: 30, color: Colors.grey),
// // // // // // // // // //                 ),
// // // // // // // // // //               ],
// // // // // // // // // //             ),
// // // // // // // // // //             SizedBox(height: 20),
// // // // // // // // // //             Row(
// // // // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // //               children: [
// // // // // // // // // //                 Column(
// // // // // // // // // //                   children: [
// // // // // // // // // //                     Text('Study Time: $_studyTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // //                     Row(
// // // // // // // // // //                       children: [
// // // // // // // // // //                         IconButton(
// // // // // // // // // //                           onPressed: () {
// // // // // // // // // //                             if (!_isRunning) {
// // // // // // // // // //                               setState(() {
// // // // // // // // // //                                 _studyTime++;
// // // // // // // // // //                                 restartTimer();
// // // // // // // // // //                               });
// // // // // // // // // //                             }
// // // // // // // // // //                           },
// // // // // // // // // //                           icon: Icon(Icons.add),
// // // // // // // // // //                         ),
// // // // // // // // // //                         IconButton(
// // // // // // // // // //                           onPressed: () {
// // // // // // // // // //                             if (!_isRunning && _studyTime > 1) {
// // // // // // // // // //                               setState(() {
// // // // // // // // // //                                 _studyTime--;
// // // // // // // // // //                                 restartTimer();
// // // // // // // // // //                               });
// // // // // // // // // //                             }
// // // // // // // // // //                           },
// // // // // // // // // //                           icon: Icon(Icons.remove),
// // // // // // // // // //                         ),
// // // // // // // // // //                       ],
// // // // // // // // // //                     ),
// // // // // // // // // //                   ],
// // // // // // // // // //                 ),
// // // // // // // // // //                 SizedBox(width: 20),
// // // // // // // // // //                 Column(
// // // // // // // // // //                   children: [
// // // // // // // // // //                     Text('Break Time: $_breakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // //                     Row(
// // // // // // // // // //                       children: [
// // // // // // // // // //                         IconButton(
// // // // // // // // // //                           onPressed: () {
// // // // // // // // // //                             if (!_isRunning) {
// // // // // // // // // //                               setState(() {
// // // // // // // // // //                                 _breakTime++;
// // // // // // // // // //                                 restartTimer();
// // // // // // // // // //                               });
// // // // // // // // // //                             }
// // // // // // // // // //                           },
// // // // // // // // // //                           icon: Icon(Icons.add),
// // // // // // // // // //                         ),
// // // // // // // // // //                         IconButton(
// // // // // // // // // //                           onPressed: () {
// // // // // // // // // //                             if (!_isRunning && _breakTime > 1) {
// // // // // // // // // //                               setState(() {
// // // // // // // // // //                                 _breakTime--;
// // // // // // // // // //                                 restartTimer();
// // // // // // // // // //                               });
// // // // // // // // // //                             }
// // // // // // // // // //                           },
// // // // // // // // // //                           icon: Icon(Icons.remove),
// // // // // // // // // //                         ),
// // // // // // // // // //                       ],
// // // // // // // // // //                     ),
// // // // // // // // // //                   ],
// // // // // // // // // //                 ),
// // // // // // // // // //                 SizedBox(width: 20),
// // // // // // // // // //                 Column(
// // // // // // // // // //                   children: [
// // // // // // // // // //                     Text('Long Break Time: $_longBreakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // //                     Row(
// // // // // // // // // //                       children: [
// // // // // // // // // //                         IconButton(
// // // // // // // // // //                           onPressed: () {
// // // // // // // // // //                             if (!_isRunning) {
// // // // // // // // // //                               setState(() {
// // // // // // // // // //                                 _longBreakTime++;
// // // // // // // // // //                                 restartTimer();
// // // // // // // // // //                               });
// // // // // // // // // //                             }
// // // // // // // // // //                           },
// // // // // // // // // //                           icon: Icon(Icons.add),
// // // // // // // // // //                         ),
// // // // // // // // // //                         IconButton(
// // // // // // // // // //                           onPressed: () {
// // // // // // // // // //                             if (!_isRunning && _longBreakTime > 1) {
// // // // // // // // // //                               setState(() {
// // // // // // // // // //                                 _longBreakTime--;
// // // // // // // // // //                                 restartTimer();
// // // // // // // // // //                               });
// // // // // // // // // //                             }
// // // // // // // // // //                           },
// // // // // // // // // //                           icon: Icon(Icons.remove),
// // // // // // // // // //                         ),
// // // // // // // // // //                       ],
// // // // // // // // // //                     ),
// // // // // // // // // //                   ],
// // // // // // // // // //                 ),
// // // // // // // // // //               ],
// // // // // // // // // //             ),
// // // // // // // // // //             SizedBox(height: 20),
// // // // // // // // // //             ElevatedButton(
// // // // // // // // // //               onPressed: () {
// // // // // // // // // //                 if (!_isRunning) {
// // // // // // // // // //                   _isRunning = true;
// // // // // // // // // //                   startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// // // // // // // // // //                 }
// // // // // // // // // //               },
// // // // // // // // // //               child: Text(_isRunning ? 'Timer Running' : 'Start Timer'),
// // // // // // // // // //             ),
// // // // // // // // // //             SizedBox(height: 10),
// // // // // // // // // //             ElevatedButton(
// // // // // // // // // //               onPressed: pauseTimer,
// // // // // // // // // //               child: Text('Pause Timer'),
// // // // // // // // // //             ),
// // // // // // // // // //             SizedBox(height: 10),
// // // // // // // // // //             ElevatedButton(
// // // // // // // // // //               onPressed: restartTimer,
// // // // // // // // // //               child: Text('Restart Timer'),
// // // // // // // // // //             ),
// // // // // // // // // //             SizedBox(height: 10),
// // // // // // // // // //             ElevatedButton(
// // // // // // // // // //               onPressed: continueTimer,
// // // // // // // // // //               child: Text('Continue Timer'),
// // // // // // // // // //             ),
// // // // // // // // // //           ],
// // // // // // // // // //         ),
// // // // // // // // // //       ),
// // // // // // // // // //     );
// // // // // // // // // //   }

// // // // // // // // // //   @override
// // // // // // // // // //   void dispose() {
// // // // // // // // // //     _timer?.cancel();
// // // // // // // // // //     super.dispose();
// // // // // // // // // //   }
// // // // // // // // // // }





// // // // // // // // // // // //sucsees 1.2 with icon modification
// // // // // // // // // // // import 'dart:async';
// // // // // // // // // // // import 'package:flutter/material.dart';

// // // // // // // // // // // void main() {
// // // // // // // // // // //   runApp(MyApp());
// // // // // // // // // // // }

// // // // // // // // // // // class MyApp extends StatelessWidget {
// // // // // // // // // // //   @override
// // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // //     return MaterialApp(
// // // // // // // // // // //       title: 'Pomodoro Timer',
// // // // // // // // // // //       theme: ThemeData(
// // // // // // // // // // //         primarySwatch: Colors.blue,
// // // // // // // // // // //       ),
// // // // // // // // // // //       home: PomodoroTimer(),
// // // // // // // // // // //     );
// // // // // // // // // // //   }
// // // // // // // // // // // }

// // // // // // // // // // // class PomodoroTimer extends StatefulWidget {
// // // // // // // // // // //   @override
// // // // // // // // // // //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // // // // // // // // // // }

// // // // // // // // // // // class _PomodoroTimerState extends State<PomodoroTimer> {
// // // // // // // // // // //   int _studyTime = 25;
// // // // // // // // // // //   int _breakTime = 5;
// // // // // // // // // // //   int _longBreakTime = 15;
// // // // // // // // // // //   int _currentTimer = 0;
// // // // // // // // // // //   int _iterations = 0;
// // // // // // // // // // //   bool _isRunning = false;
// // // // // // // // // // //   String _timerText = '25:00';
// // // // // // // // // // //   int _remainingSeconds = 0;

// // // // // // // // // // //   Timer? _timer;

// // // // // // // // // // //   void startTimer(int minutes) {
// // // // // // // // // // //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// // // // // // // // // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // // // // // // // // //       setState(() {
// // // // // // // // // // //         if (seconds > 0) {
// // // // // // // // // // //           seconds--;
// // // // // // // // // // //           int minutes = seconds ~/ 60;
// // // // // // // // // // //           int remainingSeconds = seconds % 60;
// // // // // // // // // // //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // // // // // // // // //           _remainingSeconds = seconds; // Save remaining seconds
// // // // // // // // // // //         } else {
// // // // // // // // // // //           _timer!.cancel();
// // // // // // // // // // //           if (_currentTimer == 0) {
// // // // // // // // // // //             _iterations++;
// // // // // // // // // // //             if (_iterations % 3 == 0) {
// // // // // // // // // // //               _currentTimer = 2; // Long Break
// // // // // // // // // // //               _timerText = '$_longBreakTime:00';
// // // // // // // // // // //             } else {
// // // // // // // // // // //               _currentTimer = 1; // Break
// // // // // // // // // // //               _timerText = '$_breakTime:00';
// // // // // // // // // // //             }
// // // // // // // // // // //           } else {
// // // // // // // // // // //             _currentTimer = 0; // Study
// // // // // // // // // // //             _timerText = '$_studyTime:00';
// // // // // // // // // // //           }
// // // // // // // // // // //           _isRunning = false;
// // // // // // // // // // //         }
// // // // // // // // // // //       });
// // // // // // // // // // //     });
// // // // // // // // // // //   }

// // // // // // // // // // //   void pauseTimer() {
// // // // // // // // // // //     if (_isRunning) {
// // // // // // // // // // //       _timer?.cancel();
// // // // // // // // // // //       _isRunning = false;
// // // // // // // // // // //     }
// // // // // // // // // // //   }

// // // // // // // // // // //   void restartTimer() {
// // // // // // // // // // //     pauseTimer();
// // // // // // // // // // //     setState(() {
// // // // // // // // // // //       if (_currentTimer == 0) {
// // // // // // // // // // //         _timerText = '$_studyTime:00';
// // // // // // // // // // //       } else if (_currentTimer == 1) {
// // // // // // // // // // //         _timerText = '$_breakTime:00';
// // // // // // // // // // //       } else {
// // // // // // // // // // //         _timerText = '$_longBreakTime:00';
// // // // // // // // // // //       }
// // // // // // // // // // //     });
// // // // // // // // // // //   }

// // // // // // // // // // //   void continueTimer() {
// // // // // // // // // // //     if (!_isRunning) {
// // // // // // // // // // //       _isRunning = true;
// // // // // // // // // // //       startTimer(_remainingSeconds ~/ 60);
// // // // // // // // // // //     }
// // // // // // // // // // //   }

// // // // // // // // // // //   @override
// // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // //     return Scaffold(
// // // // // // // // // // //       appBar: AppBar(
// // // // // // // // // // //         title: Text('Pomodoro Timer'),
// // // // // // // // // // //       ),
// // // // // // // // // // //       body: Center(
// // // // // // // // // // //         child: Column(
// // // // // // // // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // //           children: [
// // // // // // // // // // //             Stack(
// // // // // // // // // // //               alignment: Alignment.center,
// // // // // // // // // // //               children: [
// // // // // // // // // // //                 SizedBox(
// // // // // // // // // // //                   width: 200,
// // // // // // // // // // //                   height: 200,
// // // // // // // // // // //                   child: CircularProgressIndicator(
// // // // // // // // // // //                     value: _isRunning
// // // // // // // // // // //                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// // // // // // // // // // //                         : 0,
// // // // // // // // // // //                     backgroundColor: Colors.grey[300],
// // // // // // // // // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// // // // // // // // // // //                     strokeWidth: 20,
// // // // // // // // // // //                   ),
// // // // // // // // // // //                 ),
// // // // // // // // // // //                 Text(
// // // // // // // // // // //                   _timerText,
// // // // // // // // // // //                   style: TextStyle(fontSize: 30, color: Colors.grey),
// // // // // // // // // // //                 ),
// // // // // // // // // // //               ],
// // // // // // // // // // //             ),
// // // // // // // // // // //             SizedBox(height: 20),
// // // // // // // // // // //             Text('Study Time: $_studyTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // //             Row(
// // // // // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // //               children: [
// // // // // // // // // // //                 IconButton(
// // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // //                     if (!_isRunning) {
// // // // // // // // // // //                       setState(() {
// // // // // // // // // // //                         _studyTime++;
// // // // // // // // // // //                         restartTimer();
// // // // // // // // // // //                       });
// // // // // // // // // // //                     }
// // // // // // // // // // //                   },
// // // // // // // // // // //                   icon: Icon(Icons.add),
// // // // // // // // // // //                 ),
// // // // // // // // // // //                 IconButton(
// // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // //                     if (!_isRunning && _studyTime > 1) {
// // // // // // // // // // //                       setState(() {
// // // // // // // // // // //                         _studyTime--;
// // // // // // // // // // //                         restartTimer();
// // // // // // // // // // //                       });
// // // // // // // // // // //                     }
// // // // // // // // // // //                   },
// // // // // // // // // // //                   icon: Icon(Icons.remove),
// // // // // // // // // // //                 ),
// // // // // // // // // // //               ],
// // // // // // // // // // //             ),
// // // // // // // // // // //             Text('Break Time: $_breakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // //             Row(
// // // // // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // //               children: [
// // // // // // // // // // //                 IconButton(
// // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // //                     if (!_isRunning) {
// // // // // // // // // // //                       setState(() {
// // // // // // // // // // //                         _breakTime++;
// // // // // // // // // // //                         restartTimer();
// // // // // // // // // // //                       });
// // // // // // // // // // //                     }
// // // // // // // // // // //                   },
// // // // // // // // // // //                   icon: Icon(Icons.add),
// // // // // // // // // // //                 ),
// // // // // // // // // // //                 IconButton(
// // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // //                     if (!_isRunning && _breakTime > 1) {
// // // // // // // // // // //                       setState(() {
// // // // // // // // // // //                         _breakTime--;
// // // // // // // // // // //                         restartTimer();
// // // // // // // // // // //                       });
// // // // // // // // // // //                     }
// // // // // // // // // // //                   },
// // // // // // // // // // //                   icon: Icon(Icons.remove),
// // // // // // // // // // //                 ),
// // // // // // // // // // //               ],
// // // // // // // // // // //             ),
// // // // // // // // // // //             Text('Long Break Time: $_longBreakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // //             Row(
// // // // // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // //               children: [
// // // // // // // // // // //                 IconButton(
// // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // //                     if (!_isRunning) {
// // // // // // // // // // //                       setState(() {
// // // // // // // // // // //                         _longBreakTime++;
// // // // // // // // // // //                         restartTimer();
// // // // // // // // // // //                       });
// // // // // // // // // // //                     }
// // // // // // // // // // //                   },
// // // // // // // // // // //                   icon: Icon(Icons.add),
// // // // // // // // // // //                 ),
// // // // // // // // // // //                 IconButton(
// // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // //                     if (!_isRunning && _longBreakTime > 1) {
// // // // // // // // // // //                       setState(() {
// // // // // // // // // // //                         _longBreakTime--;
// // // // // // // // // // //                         restartTimer();
// // // // // // // // // // //                       });
// // // // // // // // // // //                     }
// // // // // // // // // // //                   },
// // // // // // // // // // //                   icon: Icon(Icons.remove),
// // // // // // // // // // //                 ),
// // // // // // // // // // //               ],
// // // // // // // // // // //             ),
// // // // // // // // // // //             SizedBox(height: 20),
// // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // //               onPressed: () {
// // // // // // // // // // //                 if (!_isRunning) {
// // // // // // // // // // //                   _isRunning = true;
// // // // // // // // // // //                   startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// // // // // // // // // // //                 }
// // // // // // // // // // //               },
// // // // // // // // // // //               child: Text(_isRunning ? 'Timer Running' : 'Start Timer'),
// // // // // // // // // // //             ),
// // // // // // // // // // //             SizedBox(height: 10),
// // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // //               onPressed: pauseTimer,
// // // // // // // // // // //               child: Text('Pause Timer'),
// // // // // // // // // // //             ),
// // // // // // // // // // //             SizedBox(height: 10),
// // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // //               onPressed: restartTimer,
// // // // // // // // // // //               child: Text('Restart Timer'),
// // // // // // // // // // //             ),
// // // // // // // // // // //             SizedBox(height: 10),
// // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // //               onPressed: continueTimer,
// // // // // // // // // // //               child: Text('Continue Timer'),
// // // // // // // // // // //             ),
// // // // // // // // // // //           ],
// // // // // // // // // // //         ),
// // // // // // // // // // //       ),
// // // // // // // // // // //     );
// // // // // // // // // // //   }

// // // // // // // // // // //   @override
// // // // // // // // // // //   void dispose() {
// // // // // // // // // // //     _timer?.cancel();
// // // // // // // // // // //     super.dispose();
// // // // // // // // // // //   }
// // // // // // // // // // // }


// // // // // // // // // // // // //sucssess 1.1
// // // // // // // // // // // // import 'dart:async';
// // // // // // // // // // // // import 'package:flutter/material.dart';

// // // // // // // // // // // // void main() {
// // // // // // // // // // // //   runApp(MyApp());
// // // // // // // // // // // // }

// // // // // // // // // // // // class MyApp extends StatelessWidget {
// // // // // // // // // // // //   @override
// // // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // // //     return MaterialApp(
// // // // // // // // // // // //       title: 'Pomodoro Timer',
// // // // // // // // // // // //       theme: ThemeData(
// // // // // // // // // // // //         primarySwatch: Colors.blue,
// // // // // // // // // // // //       ),
// // // // // // // // // // // //       home: PomodoroTimer(),
// // // // // // // // // // // //     );
// // // // // // // // // // // //   }
// // // // // // // // // // // // }

// // // // // // // // // // // // class PomodoroTimer extends StatefulWidget {
// // // // // // // // // // // //   @override
// // // // // // // // // // // //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // // // // // // // // // // // }

// // // // // // // // // // // // class _PomodoroTimerState extends State<PomodoroTimer> {
// // // // // // // // // // // //   int _studyTime = 25;
// // // // // // // // // // // //   int _breakTime = 5;
// // // // // // // // // // // //   int _longBreakTime = 15;
// // // // // // // // // // // //   int _currentTimer = 0;
// // // // // // // // // // // //   int _iterations = 0;
// // // // // // // // // // // //   bool _isRunning = false;
// // // // // // // // // // // //   String _timerText = '25:00';
// // // // // // // // // // // //   int _remainingSeconds = 0;

// // // // // // // // // // // //   Timer? _timer;

// // // // // // // // // // // //   void startTimer(int minutes) {
// // // // // // // // // // // //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// // // // // // // // // // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // // // // // // // // // //       setState(() {
// // // // // // // // // // // //         if (seconds > 0) {
// // // // // // // // // // // //           seconds--;
// // // // // // // // // // // //           int minutes = seconds ~/ 60;
// // // // // // // // // // // //           int remainingSeconds = seconds % 60;
// // // // // // // // // // // //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // // // // // // // // // //           _remainingSeconds = seconds; // Save remaining seconds
// // // // // // // // // // // //         } else {
// // // // // // // // // // // //           _timer!.cancel();
// // // // // // // // // // // //           if (_currentTimer == 0) {
// // // // // // // // // // // //             _iterations++;
// // // // // // // // // // // //             if (_iterations % 3 == 0) {
// // // // // // // // // // // //               _currentTimer = 2; // Long Break
// // // // // // // // // // // //               _timerText = '$_longBreakTime:00';
// // // // // // // // // // // //             } else {
// // // // // // // // // // // //               _currentTimer = 1; // Break
// // // // // // // // // // // //               _timerText = '$_breakTime:00';
// // // // // // // // // // // //             }
// // // // // // // // // // // //           } else {
// // // // // // // // // // // //             _currentTimer = 0; // Study
// // // // // // // // // // // //             _timerText = '$_studyTime:00';
// // // // // // // // // // // //           }
// // // // // // // // // // // //           _isRunning = false;
// // // // // // // // // // // //         }
// // // // // // // // // // // //       });
// // // // // // // // // // // //     });
// // // // // // // // // // // //   }

// // // // // // // // // // // //   void pauseTimer() {
// // // // // // // // // // // //     if (_isRunning) {
// // // // // // // // // // // //       _timer?.cancel();
// // // // // // // // // // // //       _isRunning = false;
// // // // // // // // // // // //     }
// // // // // // // // // // // //   }

// // // // // // // // // // // //   void restartTimer() {
// // // // // // // // // // // //     pauseTimer();
// // // // // // // // // // // //     setState(() {
// // // // // // // // // // // //       if (_currentTimer == 0) {
// // // // // // // // // // // //         _timerText = '$_studyTime:00';
// // // // // // // // // // // //       } else if (_currentTimer == 1) {
// // // // // // // // // // // //         _timerText = '$_breakTime:00';
// // // // // // // // // // // //       } else {
// // // // // // // // // // // //         _timerText = '$_longBreakTime:00';
// // // // // // // // // // // //       }
// // // // // // // // // // // //     });
// // // // // // // // // // // //   }

// // // // // // // // // // // //   void continueTimer() {
// // // // // // // // // // // //     if (!_isRunning) {
// // // // // // // // // // // //       _isRunning = true;
// // // // // // // // // // // //       startTimer(_remainingSeconds ~/ 60);
// // // // // // // // // // // //     }
// // // // // // // // // // // //   }

// // // // // // // // // // // //   @override
// // // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // // //     return Scaffold(
// // // // // // // // // // // //       appBar: AppBar(
// // // // // // // // // // // //         title: Text('Pomodoro Timer'),
// // // // // // // // // // // //       ),
// // // // // // // // // // // //       body: Center(
// // // // // // // // // // // //         child: Column(
// // // // // // // // // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // //           children: [
// // // // // // // // // // // //             Stack(
// // // // // // // // // // // //               alignment: Alignment.center,
// // // // // // // // // // // //               children: [
// // // // // // // // // // // //                 SizedBox(
// // // // // // // // // // // //                   width: 200,
// // // // // // // // // // // //                   height: 200,
// // // // // // // // // // // //                   child: CircularProgressIndicator(
// // // // // // // // // // // //                     value: _isRunning
// // // // // // // // // // // //                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// // // // // // // // // // // //                         : 0,
// // // // // // // // // // // //                     backgroundColor: Colors.grey[300],
// // // // // // // // // // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// // // // // // // // // // // //                     strokeWidth: 20,
// // // // // // // // // // // //                   ),
// // // // // // // // // // // //                 ),
// // // // // // // // // // // //                 Text(
// // // // // // // // // // // //                   _timerText,
// // // // // // // // // // // //                   style: TextStyle(fontSize: 30, color: Colors.grey),
// // // // // // // // // // // //                 ),
// // // // // // // // // // // //               ],
// // // // // // // // // // // //             ),
// // // // // // // // // // // //             SizedBox(height: 20),
// // // // // // // // // // // //             Text('Study Time: $_studyTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // //             Row(
// // // // // // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // //               children: [
// // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // //                     if (!_isRunning) {
// // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // //                         _studyTime++;
// // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // //                       });
// // // // // // // // // // // //                     }
// // // // // // // // // // // //                   },
// // // // // // // // // // // //                   icon: Icon(Icons.arrow_upward),
// // // // // // // // // // // //                 ),
// // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // //                     if (!_isRunning && _studyTime > 1) {
// // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // //                         _studyTime--;
// // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // //                       });
// // // // // // // // // // // //                     }
// // // // // // // // // // // //                   },
// // // // // // // // // // // //                   icon: Icon(Icons.arrow_downward),
// // // // // // // // // // // //                 ),
// // // // // // // // // // // //               ],
// // // // // // // // // // // //             ),
// // // // // // // // // // // //             Text('Break Time: $_breakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // //             Row(
// // // // // // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // //               children: [
// // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // //                     if (!_isRunning) {
// // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // //                         _breakTime++;
// // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // //                       });
// // // // // // // // // // // //                     }
// // // // // // // // // // // //                   },
// // // // // // // // // // // //                   icon: Icon(Icons.arrow_upward),
// // // // // // // // // // // //                 ),
// // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // //                     if (!_isRunning && _breakTime > 1) {
// // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // //                         _breakTime--;
// // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // //                       });
// // // // // // // // // // // //                     }
// // // // // // // // // // // //                   },
// // // // // // // // // // // //                   icon: Icon(Icons.arrow_downward),
// // // // // // // // // // // //                 ),
// // // // // // // // // // // //               ],
// // // // // // // // // // // //             ),
// // // // // // // // // // // //             Text('Long Break Time: $_longBreakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // //             Row(
// // // // // // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // //               children: [
// // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // //                     if (!_isRunning) {
// // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // //                         _longBreakTime++;
// // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // //                       });
// // // // // // // // // // // //                     }
// // // // // // // // // // // //                   },
// // // // // // // // // // // //                   icon: Icon(Icons.arrow_upward),
// // // // // // // // // // // //                 ),
// // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // //                     if (!_isRunning && _longBreakTime > 1) {
// // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // //                         _longBreakTime--;
// // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // //                       });
// // // // // // // // // // // //                     }
// // // // // // // // // // // //                   },
// // // // // // // // // // // //                   icon: Icon(Icons.arrow_downward),
// // // // // // // // // // // //                 ),
// // // // // // // // // // // //               ],
// // // // // // // // // // // //             ),
// // // // // // // // // // // //             SizedBox(height: 20),
// // // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // // //               onPressed: () {
// // // // // // // // // // // //                 if (!_isRunning) {
// // // // // // // // // // // //                   _isRunning = true;
// // // // // // // // // // // //                   startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// // // // // // // // // // // //                 }
// // // // // // // // // // // //               },
// // // // // // // // // // // //               child: Text(_isRunning ? 'Timer Running' : 'Start Timer'),
// // // // // // // // // // // //             ),
// // // // // // // // // // // //             SizedBox(height: 10),
// // // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // // //               onPressed: pauseTimer,
// // // // // // // // // // // //               child: Text('Pause Timer'),
// // // // // // // // // // // //             ),
// // // // // // // // // // // //             SizedBox(height: 10),
// // // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // // //               onPressed: restartTimer,
// // // // // // // // // // // //               child: Text('Restart Timer'),
// // // // // // // // // // // //             ),
// // // // // // // // // // // //             SizedBox(height: 10),
// // // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // // //               onPressed: continueTimer,
// // // // // // // // // // // //               child: Text('Continue Timer'),
// // // // // // // // // // // //             ),
// // // // // // // // // // // //           ],
// // // // // // // // // // // //         ),
// // // // // // // // // // // //       ),
// // // // // // // // // // // //     );
// // // // // // // // // // // //   }

// // // // // // // // // // // //   @override
// // // // // // // // // // // //   void dispose() {
// // // // // // // // // // // //     _timer?.cancel();
// // // // // // // // // // // //     super.dispose();
// // // // // // // // // // // //   }
// // // // // // // // // // // // }





// // // // // // // // // // // // // //the most sucsseful 1.0
// // // // // // // // // // // // // import 'dart:async';
// // // // // // // // // // // // // import 'package:flutter/material.dart';

// // // // // // // // // // // // // void main() {
// // // // // // // // // // // // //   runApp(MyApp());
// // // // // // // // // // // // // }

// // // // // // // // // // // // // class MyApp extends StatelessWidget {
// // // // // // // // // // // // //   @override
// // // // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // // // //     return MaterialApp(
// // // // // // // // // // // // //       title: 'Pomodoro Timer',
// // // // // // // // // // // // //       theme: ThemeData(
// // // // // // // // // // // // //         primarySwatch: Colors.blue,
// // // // // // // // // // // // //       ),
// // // // // // // // // // // // //       home: PomodoroTimer(),
// // // // // // // // // // // // //     );
// // // // // // // // // // // // //   }
// // // // // // // // // // // // // }

// // // // // // // // // // // // // class PomodoroTimer extends StatefulWidget {
// // // // // // // // // // // // //   @override
// // // // // // // // // // // // //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // // // // // // // // // // // // }

// // // // // // // // // // // // // class _PomodoroTimerState extends State<PomodoroTimer> {
// // // // // // // // // // // // //   int _studyTime = 25;
// // // // // // // // // // // // //   int _breakTime = 5;
// // // // // // // // // // // // //   int _longBreakTime = 15;
// // // // // // // // // // // // //   int _currentTimer = 0;
// // // // // // // // // // // // //   int _iterations = 0;
// // // // // // // // // // // // //   bool _isRunning = false;
// // // // // // // // // // // // //   String _timerText = '25:00';
// // // // // // // // // // // // //   int _remainingSeconds = 0;

// // // // // // // // // // // // //   Timer? _timer;

// // // // // // // // // // // // //   void startTimer(int minutes) {
// // // // // // // // // // // // //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// // // // // // // // // // // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // // // // // // // // // // //       setState(() {
// // // // // // // // // // // // //         if (seconds > 0) {
// // // // // // // // // // // // //           seconds--;
// // // // // // // // // // // // //           int minutes = seconds ~/ 60;
// // // // // // // // // // // // //           int remainingSeconds = seconds % 60;
// // // // // // // // // // // // //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // // // // // // // // // // //           _remainingSeconds = seconds; // Save remaining seconds
// // // // // // // // // // // // //         } else {
// // // // // // // // // // // // //           _timer!.cancel();
// // // // // // // // // // // // //           if (_currentTimer == 0) {
// // // // // // // // // // // // //             _iterations++;
// // // // // // // // // // // // //             if (_iterations % 3 == 0) {
// // // // // // // // // // // // //               _currentTimer = 2; // Long Break
// // // // // // // // // // // // //               _timerText = '$_longBreakTime:00';
// // // // // // // // // // // // //             } else {
// // // // // // // // // // // // //               _currentTimer = 1; // Break
// // // // // // // // // // // // //               _timerText = '$_breakTime:00';
// // // // // // // // // // // // //             }
// // // // // // // // // // // // //           } else {
// // // // // // // // // // // // //             _currentTimer = 0; // Study
// // // // // // // // // // // // //             _timerText = '$_studyTime:00';
// // // // // // // // // // // // //           }
// // // // // // // // // // // // //           _isRunning = false;
// // // // // // // // // // // // //         }
// // // // // // // // // // // // //       });
// // // // // // // // // // // // //     });
// // // // // // // // // // // // //   }

// // // // // // // // // // // // //   void pauseTimer() {
// // // // // // // // // // // // //     if (_isRunning) {
// // // // // // // // // // // // //       _timer?.cancel();
// // // // // // // // // // // // //       _isRunning = false;
// // // // // // // // // // // // //     }
// // // // // // // // // // // // //   }

// // // // // // // // // // // // //   void restartTimer() {
// // // // // // // // // // // // //     pauseTimer();
// // // // // // // // // // // // //     setState(() {
// // // // // // // // // // // // //       if (_currentTimer == 0) {
// // // // // // // // // // // // //         _timerText = '$_studyTime:00';
// // // // // // // // // // // // //       } else if (_currentTimer == 1) {
// // // // // // // // // // // // //         _timerText = '$_breakTime:00';
// // // // // // // // // // // // //       } else {
// // // // // // // // // // // // //         _timerText = '$_longBreakTime:00';
// // // // // // // // // // // // //       }
// // // // // // // // // // // // //     });
// // // // // // // // // // // // //   }

// // // // // // // // // // // // //   void continueTimer() {
// // // // // // // // // // // // //     if (!_isRunning) {
// // // // // // // // // // // // //       _isRunning = true;
// // // // // // // // // // // // //       startTimer(_remainingSeconds ~/ 60);
// // // // // // // // // // // // //     }
// // // // // // // // // // // // //   }

// // // // // // // // // // // // //   @override
// // // // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // // // //     return Scaffold(
// // // // // // // // // // // // //       appBar: AppBar(
// // // // // // // // // // // // //         title: Text('Pomodoro Timer'),
// // // // // // // // // // // // //       ),
// // // // // // // // // // // // //       body: Center(
// // // // // // // // // // // // //         child: Column(
// // // // // // // // // // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // // //           children: [
// // // // // // // // // // // // //             Container(
// // // // // // // // // // // // //               width: 200,
// // // // // // // // // // // // //               height: 200,
// // // // // // // // // // // // //               child: Stack(
// // // // // // // // // // // // //                 children: [
// // // // // // // // // // // // //                   CircularProgressIndicator(
// // // // // // // // // // // // //                     value: _isRunning
// // // // // // // // // // // // //                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// // // // // // // // // // // // //                         : 0,
// // // // // // // // // // // // //                     backgroundColor: Colors.grey[300],
// // // // // // // // // // // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// // // // // // // // // // // // //                     strokeWidth: 10,
// // // // // // // // // // // // //                   ),
// // // // // // // // // // // // //                   Center(
// // // // // // // // // // // // //                     child: Text(
// // // // // // // // // // // // //                       _timerText,
// // // // // // // // // // // // //                       style: TextStyle(fontSize: 40, color: Colors.grey),
// // // // // // // // // // // // //                     ),
// // // // // // // // // // // // //                   ),
// // // // // // // // // // // // //                 ],
// // // // // // // // // // // // //               ),
// // // // // // // // // // // // //             ),
// // // // // // // // // // // // //             SizedBox(height: 20),
// // // // // // // // // // // // //             Text('Study Time: $_studyTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // // //             Row(
// // // // // // // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // // //               children: [
// // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // //                     if (!_isRunning) {
// // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // //                         _studyTime++;
// // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // //                       });
// // // // // // // // // // // // //                     }
// // // // // // // // // // // // //                   },
// // // // // // // // // // // // //                   icon: Icon(Icons.arrow_upward),
// // // // // // // // // // // // //                 ),
// // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // //                     if (!_isRunning && _studyTime > 1) {
// // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // //                         _studyTime--;
// // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // //                       });
// // // // // // // // // // // // //                     }
// // // // // // // // // // // // //                   },
// // // // // // // // // // // // //                   icon: Icon(Icons.arrow_downward),
// // // // // // // // // // // // //                 ),
// // // // // // // // // // // // //               ],
// // // // // // // // // // // // //             ),
// // // // // // // // // // // // //             Text('Break Time: $_breakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // // //             Row(
// // // // // // // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // // //               children: [
// // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // //                     if (!_isRunning) {
// // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // //                         _breakTime++;
// // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // //                       });
// // // // // // // // // // // // //                     }
// // // // // // // // // // // // //                   },
// // // // // // // // // // // // //                   icon: Icon(Icons.arrow_upward),
// // // // // // // // // // // // //                 ),
// // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // //                     if (!_isRunning && _breakTime > 1) {
// // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // //                         _breakTime--;
// // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // //                       });
// // // // // // // // // // // // //                     }
// // // // // // // // // // // // //                   },
// // // // // // // // // // // // //                   icon: Icon(Icons.arrow_downward),
// // // // // // // // // // // // //                 ),
// // // // // // // // // // // // //               ],
// // // // // // // // // // // // //             ),
// // // // // // // // // // // // //             Text('Long Break Time: $_longBreakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // // //             Row(
// // // // // // // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // // //               children: [
// // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // //                     if (!_isRunning) {
// // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // //                         _longBreakTime++;
// // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // //                       });
// // // // // // // // // // // // //                     }
// // // // // // // // // // // // //                   },
// // // // // // // // // // // // //                   icon: Icon(Icons.arrow_upward),
// // // // // // // // // // // // //                 ),
// // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // //                     if (!_isRunning && _longBreakTime > 1) {
// // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // //                         _longBreakTime--;
// // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // //                       });
// // // // // // // // // // // // //                     }
// // // // // // // // // // // // //                   },
// // // // // // // // // // // // //                   icon: Icon(Icons.arrow_downward),
// // // // // // // // // // // // //                 ),
// // // // // // // // // // // // //               ],
// // // // // // // // // // // // //             ),
// // // // // // // // // // // // //             SizedBox(height: 20),
// // // // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // // // //               onPressed: () {
// // // // // // // // // // // // //                 if (!_isRunning) {
// // // // // // // // // // // // //                   _isRunning = true;
// // // // // // // // // // // // //                   startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// // // // // // // // // // // // //                 }
// // // // // // // // // // // // //               },
// // // // // // // // // // // // //               child: Text(_isRunning ? 'Timer Running' : 'Start Timer'),
// // // // // // // // // // // // //             ),
// // // // // // // // // // // // //             SizedBox(height: 10),
// // // // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // // // //               onPressed: pauseTimer,
// // // // // // // // // // // // //               child: Text('Pause Timer'),
// // // // // // // // // // // // //             ),
// // // // // // // // // // // // //             SizedBox(height: 10),
// // // // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // // // //               onPressed: restartTimer,
// // // // // // // // // // // // //               child: Text('Restart Timer'),
// // // // // // // // // // // // //             ),
// // // // // // // // // // // // //             SizedBox(height: 10),
// // // // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // // // //               onPressed: continueTimer,
// // // // // // // // // // // // //               child: Text('Continue Timer'),
// // // // // // // // // // // // //             ),
// // // // // // // // // // // // //           ],
// // // // // // // // // // // // //         ),
// // // // // // // // // // // // //       ),
// // // // // // // // // // // // //     );
// // // // // // // // // // // // //   }

// // // // // // // // // // // // //   @override
// // // // // // // // // // // // //   void dispose() {
// // // // // // // // // // // // //     _timer?.cancel();
// // // // // // // // // // // // //     super.dispose();
// // // // // // // // // // // // //   }
// // // // // // // // // // // // // }







// // // // // // // // // // // // // // import 'dart:async';
// // // // // // // // // // // // // // import 'package:flutter/material.dart';

// // // // // // // // // // // // // // void main() {
// // // // // // // // // // // // // //   runApp(MyApp());
// // // // // // // // // // // // // // }

// // // // // // // // // // // // // // class MyApp extends StatelessWidget {
// // // // // // // // // // // // // //   @override
// // // // // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // // // // //     return MaterialApp(
// // // // // // // // // // // // // //       title: 'Pomodoro Timer',
// // // // // // // // // // // // // //       theme: ThemeData(
// // // // // // // // // // // // // //         primarySwatch: Colors.blue,
// // // // // // // // // // // // // //       ),
// // // // // // // // // // // // // //       home: PomodoroTimer(),
// // // // // // // // // // // // // //     );
// // // // // // // // // // // // // //   }
// // // // // // // // // // // // // // }

// // // // // // // // // // // // // // class PomodoroTimer extends StatefulWidget {
// // // // // // // // // // // // // //   @override
// // // // // // // // // // // // // //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // // // // // // // // // // // // // }

// // // // // // // // // // // // // // class _PomodoroTimerState extends State<PomodoroTimer> {
// // // // // // // // // // // // // //   int _studyTime = 25;
// // // // // // // // // // // // // //   int _breakTime = 5;
// // // // // // // // // // // // // //   int _longBreakTime = 15;
// // // // // // // // // // // // // //   int _currentTimer = 0;
// // // // // // // // // // // // // //   int _iterations = 0;
// // // // // // // // // // // // // //   bool _isRunning = false;
// // // // // // // // // // // // // //   String _timerText = '25:00';
// // // // // // // // // // // // // //   int _remainingSeconds = 0;

// // // // // // // // // // // // // //   Timer? _timer;

// // // // // // // // // // // // // //   void startTimer(int minutes) {
// // // // // // // // // // // // // //     int seconds = _remainingSeconds > 0 ? _remainingSeconds : minutes * 60;
// // // // // // // // // // // // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // // // // // // // // // // // //       setState(() {
// // // // // // // // // // // // // //         if (seconds > 0) {
// // // // // // // // // // // // // //           seconds--;
// // // // // // // // // // // // // //           int minutes = seconds ~/ 60;
// // // // // // // // // // // // // //           int remainingSeconds = seconds % 60;
// // // // // // // // // // // // // //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // // // // // // // // // // // //         } else {
// // // // // // // // // // // // // //           _timer!.cancel();
// // // // // // // // // // // // // //           if (_currentTimer == 0) {
// // // // // // // // // // // // // //             _iterations++;
// // // // // // // // // // // // // //             if (_iterations % 3 == 0) {
// // // // // // // // // // // // // //               _currentTimer = 2; // Long Break
// // // // // // // // // // // // // //               _timerText = '$_longBreakTime:00';
// // // // // // // // // // // // // //             } else {
// // // // // // // // // // // // // //               _currentTimer = 1; // Break
// // // // // // // // // // // // // //               _timerText = '$_breakTime:00';
// // // // // // // // // // // // // //             }
// // // // // // // // // // // // // //           } else {
// // // // // // // // // // // // // //             _currentTimer = 0; // Study
// // // // // // // // // // // // // //             _timerText = '$_studyTime:00';
// // // // // // // // // // // // // //           }
// // // // // // // // // // // // // //           _isRunning = false;
// // // // // // // // // // // // // //           _remainingSeconds = seconds;
// // // // // // // // // // // // // //         }
// // // // // // // // // // // // // //       });
// // // // // // // // // // // // // //     });
// // // // // // // // // // // // // //   }

// // // // // // // // // // // // // //   void pauseTimer() {
// // // // // // // // // // // // // //     if (_isRunning) {
// // // // // // // // // // // // // //       _timer?.cancel();
// // // // // // // // // // // // // //       _isRunning = false;
// // // // // // // // // // // // // //     }
// // // // // // // // // // // // // //   }

// // // // // // // // // // // // // //   void restartTimer() {
// // // // // // // // // // // // // //     if (_remainingSeconds > 0) {
// // // // // // // // // // // // // //       startTimer(_remainingSeconds ~/ 60);
// // // // // // // // // // // // // //       _isRunning = true;
// // // // // // // // // // // // // //     }
// // // // // // // // // // // // // //   }

// // // // // // // // // // // // // //   @override
// // // // // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // // // // //     return Scaffold(
// // // // // // // // // // // // // //       appBar: AppBar(
// // // // // // // // // // // // // //         title: Text('Pomodoro Timer'),
// // // // // // // // // // // // // //       ),
// // // // // // // // // // // // // //       body: Center(
// // // // // // // // // // // // // //         child: Column(
// // // // // // // // // // // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // // // //           children: [
// // // // // // // // // // // // // //             Container(
// // // // // // // // // // // // // //               width: 200,
// // // // // // // // // // // // // //               height: 200,
// // // // // // // // // // // // // //               child: Stack(
// // // // // // // // // // // // // //                 children: [
// // // // // // // // // // // // // //                   CircularProgressIndicator(
// // // // // // // // // // // // // //                     value: _isRunning
// // // // // // // // // // // // // //                         ? 1 - (_remainingSeconds / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// // // // // // // // // // // // // //                         : 0,
// // // // // // // // // // // // // //                     backgroundColor: Colors.grey[300],
// // // // // // // // // // // // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// // // // // // // // // // // // // //                     strokeWidth: 10,
// // // // // // // // // // // // // //                   ),
// // // // // // // // // // // // // //                   Center(
// // // // // // // // // // // // // //                     child: Text(
// // // // // // // // // // // // // //                       _timerText,
// // // // // // // // // // // // // //                       style: TextStyle(fontSize: 40, color: Colors.grey),
// // // // // // // // // // // // // //                     ),
// // // // // // // // // // // // // //                   ),
// // // // // // // // // // // // // //                 ],
// // // // // // // // // // // // // //               ),
// // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // //             SizedBox(height: 20),
// // // // // // // // // // // // // //             Text('Study Time: $_studyTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // // // //             Row(
// // // // // // // // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // // // //               children: [
// // // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // // //                     if (!_isRunning) {
// // // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // // //                         _studyTime++;
// // // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // // //                       });
// // // // // // // // // // // // // //                     }
// // // // // // // // // // // // // //                   },
// // // // // // // // // // // // // //                   icon: Icon(Icons.arrow_upward),
// // // // // // // // // // // // // //                 ),
// // // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // // //                     if (!_isRunning && _studyTime > 1) {
// // // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // // //                         _studyTime--;
// // // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // // //                       });
// // // // // // // // // // // // // //                     }
// // // // // // // // // // // // // //                   },
// // // // // // // // // // // // // //                   icon: Icon(Icons.arrow_downward),
// // // // // // // // // // // // // //                 ),
// // // // // // // // // // // // // //               ],
// // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // //             Text('Break Time: $_breakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // // // //             Row(
// // // // // // // // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // // // //               children: [
// // // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // // //                     if (!_isRunning) {
// // // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // // //                         _breakTime++;
// // // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // // //                       });
// // // // // // // // // // // // // //                     }
// // // // // // // // // // // // // //                   },
// // // // // // // // // // // // // //                   icon: Icon(Icons.arrow_upward),
// // // // // // // // // // // // // //                 ),
// // // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // // //                     if (!_isRunning && _breakTime > 1) {
// // // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // // //                         _breakTime--;
// // // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // // //                       });
// // // // // // // // // // // // // //                     }
// // // // // // // // // // // // // //                   },
// // // // // // // // // // // // // //                   icon: Icon(Icons.arrow_downward),
// // // // // // // // // // // // // //                 ),
// // // // // // // // // // // // // //               ],
// // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // //             Text('Long Break Time: $_longBreakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // // // //             Row(
// // // // // // // // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // // // //               children: [
// // // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // // //                     if (!_isRunning) {
// // // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // // //                         _longBreakTime++;
// // // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // // //                       });
// // // // // // // // // // // // // //                     }
// // // // // // // // // // // // // //                   },
// // // // // // // // // // // // // //                   icon: Icon(Icons.arrow_upward),
// // // // // // // // // // // // // //                 ),
// // // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // // //                     if (!_isRunning && _longBreakTime > 1) {
// // // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // // //                         _longBreakTime--;
// // // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // // //                       });
// // // // // // // // // // // // // //                     }
// // // // // // // // // // // // // //                   },
// // // // // // // // // // // // // //                   icon: Icon(Icons.arrow_downward),
// // // // // // // // // // // // // //                 ),
// // // // // // // // // // // // // //               ],
// // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // //             SizedBox(height: 20),
// // // // // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // // // // //               onPressed: () {
// // // // // // // // // // // // // //                 if (!_isRunning) {
// // // // // // // // // // // // // //                   _isRunning = true;
// // // // // // // // // // // // // //                   startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// // // // // // // // // // // // // //                 }
// // // // // // // // // // // // // //               },
// // // // // // // // // // // // // //               child: Text(_isRunning ? 'Timer Running' : 'Start Timer'),
// // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // //             SizedBox(height: 10),
// // // // // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // // // // //               onPressed: pauseTimer,
// // // // // // // // // // // // // //               child: Text('Pause Timer'),
// // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // //             SizedBox(height: 10),
// // // // // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // // // // //               onPressed: restartTimer,
// // // // // // // // // // // // // //               child: Text('Restart Timer'),
// // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // //           ],
// // // // // // // // // // // // // //         ),
// // // // // // // // // // // // // //       ),
// // // // // // // // // // // // // //     );
// // // // // // // // // // // // // //   }

// // // // // // // // // // // // // //   @override
// // // // // // // // // // // // // //   void dispose() {
// // // // // // // // // // // // // //     _timer?.cancel();
// // // // // // // // // // // // // //     super.dispose();
// // // // // // // // // // // // // //   }
// // // // // // // // // // // // // // }









// // // // // // // // // // // // // // // import 'dart:async';
// // // // // // // // // // // // // // // import 'package:flutter/material.dart';

// // // // // // // // // // // // // // // void main() {
// // // // // // // // // // // // // // //   runApp(MyApp());
// // // // // // // // // // // // // // // }

// // // // // // // // // // // // // // // class MyApp extends StatelessWidget {
// // // // // // // // // // // // // // //   @override
// // // // // // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // // // // // //     return MaterialApp(
// // // // // // // // // // // // // // //       title: 'Pomodoro Timer',
// // // // // // // // // // // // // // //       theme: ThemeData(
// // // // // // // // // // // // // // //         primarySwatch: Colors.blue,
// // // // // // // // // // // // // // //       ),
// // // // // // // // // // // // // // //       home: PomodoroTimer(),
// // // // // // // // // // // // // // //     );
// // // // // // // // // // // // // // //   }
// // // // // // // // // // // // // // // }

// // // // // // // // // // // // // // // class PomodoroTimer extends StatefulWidget {
// // // // // // // // // // // // // // //   @override
// // // // // // // // // // // // // // //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // // // // // // // // // // // // // // }

// // // // // // // // // // // // // // // class _PomodoroTimerState extends State<PomodoroTimer> {
// // // // // // // // // // // // // // //   int _studyTime = 25;
// // // // // // // // // // // // // // //   int _breakTime = 5;
// // // // // // // // // // // // // // //   int _longBreakTime = 15;
// // // // // // // // // // // // // // //   int _currentTimer = 0;
// // // // // // // // // // // // // // //   int _iterations = 0;
// // // // // // // // // // // // // // //   bool _isRunning = false;
// // // // // // // // // // // // // // //   String _timerText = '25:00';

// // // // // // // // // // // // // // //   Timer? _timer;

// // // // // // // // // // // // // // //   void startTimer(int minutes) {
// // // // // // // // // // // // // // //     int seconds = minutes * 60;
// // // // // // // // // // // // // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // // // // // // // // // // // // //       setState(() {
// // // // // // // // // // // // // // //         if (seconds > 0) {
// // // // // // // // // // // // // // //           seconds--;
// // // // // // // // // // // // // // //           int minutes = seconds ~/ 60;
// // // // // // // // // // // // // // //           int remainingSeconds = seconds % 60;
// // // // // // // // // // // // // // //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // // // // // // // // // // // // //         } else {
// // // // // // // // // // // // // // //           _timer!.cancel();
// // // // // // // // // // // // // // //           if (_currentTimer == 0) {
// // // // // // // // // // // // // // //             _iterations++;
// // // // // // // // // // // // // // //             if (_iterations % 3 == 0) {
// // // // // // // // // // // // // // //               _currentTimer = 2; // Long Break
// // // // // // // // // // // // // // //               _timerText = '$_longBreakTime:00';
// // // // // // // // // // // // // // //             } else {
// // // // // // // // // // // // // // //               _currentTimer = 1; // Break
// // // // // // // // // // // // // // //               _timerText = '$_breakTime:00';
// // // // // // // // // // // // // // //             }
// // // // // // // // // // // // // // //           } else {
// // // // // // // // // // // // // // //             _currentTimer = 0; // Study
// // // // // // // // // // // // // // //             _timerText = '$_studyTime:00';
// // // // // // // // // // // // // // //           }
// // // // // // // // // // // // // // //           _isRunning = false;
// // // // // // // // // // // // // // //         }
// // // // // // // // // // // // // // //       });
// // // // // // // // // // // // // // //     });
// // // // // // // // // // // // // // //   }

// // // // // // // // // // // // // // //   void pauseTimer() {
// // // // // // // // // // // // // // //     if (_isRunning) {
// // // // // // // // // // // // // // //       _timer?.cancel();
// // // // // // // // // // // // // // //       _isRunning = false;
// // // // // // // // // // // // // // //     }
// // // // // // // // // // // // // // //   }

// // // // // // // // // // // // // // //   void restartTimer() {
// // // // // // // // // // // // // // //     pauseTimer();
// // // // // // // // // // // // // // //     setState(() {
// // // // // // // // // // // // // // //       if (_currentTimer == 0) {
// // // // // // // // // // // // // // //         _timerText = '$_studyTime:00';
// // // // // // // // // // // // // // //       } else if (_currentTimer == 1) {
// // // // // // // // // // // // // // //         _timerText = '$_breakTime:00';
// // // // // // // // // // // // // // //       } else {
// // // // // // // // // // // // // // //         _timerText = '$_longBreakTime:00';
// // // // // // // // // // // // // // //       }
// // // // // // // // // // // // // // //     });
// // // // // // // // // // // // // // //   }

// // // // // // // // // // // // // // //   @override
// // // // // // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // // // // // //     return Scaffold(
// // // // // // // // // // // // // // //       appBar: AppBar(
// // // // // // // // // // // // // // //         title: Text('Pomodoro Timer'),
// // // // // // // // // // // // // // //       ),
// // // // // // // // // // // // // // //       body: Center(
// // // // // // // // // // // // // // //         child: Column(
// // // // // // // // // // // // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // // // // //           children: [
// // // // // // // // // // // // // // //             Container(
// // // // // // // // // // // // // // //               width: 200,
// // // // // // // // // // // // // // //               height: 200,
// // // // // // // // // // // // // // //               child: Stack(
// // // // // // // // // // // // // // //                 children: [
// // // // // // // // // // // // // // //                   CircularProgressIndicator(
// // // // // // // // // // // // // // //                     value: _isRunning
// // // // // // // // // // // // // // //                         ? 1 - (_timerTextToSeconds() / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// // // // // // // // // // // // // // //                         : 0,
// // // // // // // // // // // // // // //                     backgroundColor: Colors.grey[300],
// // // // // // // // // // // // // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// // // // // // // // // // // // // // //                     strokeWidth: 10,
// // // // // // // // // // // // // // //                   ),
// // // // // // // // // // // // // // //                   Center(
// // // // // // // // // // // // // // //                     child: Text(
// // // // // // // // // // // // // // //                       _timerText,
// // // // // // // // // // // // // // //                       style: TextStyle(fontSize: 40, color: Colors.grey),
// // // // // // // // // // // // // // //                     ),
// // // // // // // // // // // // // // //                   ),
// // // // // // // // // // // // // // //                 ],
// // // // // // // // // // // // // // //               ),
// // // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // // //             SizedBox(height: 20),
// // // // // // // // // // // // // // //             Text('Study Time: $_studyTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // // // // //             Row(
// // // // // // // // // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // // // // //               children: [
// // // // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // // // //                     if (!_isRunning) {
// // // // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // // // //                         _studyTime++;
// // // // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // // // //                       });
// // // // // // // // // // // // // // //                     }
// // // // // // // // // // // // // // //                   },
// // // // // // // // // // // // // // //                   icon: Icon(Icons.arrow_upward),
// // // // // // // // // // // // // // //                 ),
// // // // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // // // //                     if (!_isRunning && _studyTime > 1) {
// // // // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // // // //                         _studyTime--;
// // // // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // // // //                       });
// // // // // // // // // // // // // // //                     }
// // // // // // // // // // // // // // //                   },
// // // // // // // // // // // // // // //                   icon: Icon(Icons.arrow_downward),
// // // // // // // // // // // // // // //                 ),
// // // // // // // // // // // // // // //               ],
// // // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // // //             Text('Break Time: $_breakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // // // // //             Row(
// // // // // // // // // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // // // // //               children: [
// // // // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // // // //                     if (!_isRunning) {
// // // // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // // // //                         _breakTime++;
// // // // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // // // //                       });
// // // // // // // // // // // // // // //                     }
// // // // // // // // // // // // // // //                   },
// // // // // // // // // // // // // // //                   icon: Icon(Icons.arrow_upward),
// // // // // // // // // // // // // // //                 ),
// // // // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // // // //                     if (!_isRunning && _breakTime > 1) {
// // // // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // // // //                         _breakTime--;
// // // // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // // // //                       });
// // // // // // // // // // // // // // //                     }
// // // // // // // // // // // // // // //                   },
// // // // // // // // // // // // // // //                   icon: Icon(Icons.arrow_downward),
// // // // // // // // // // // // // // //                 ),
// // // // // // // // // // // // // // //               ],
// // // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // // //             Text('Long Break Time: $_longBreakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // // // // //             Row(
// // // // // // // // // // // // // // //               mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // // // // //               children: [
// // // // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // // // //                     if (!_isRunning) {
// // // // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // // // //                         _longBreakTime++;
// // // // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // // // //                       });
// // // // // // // // // // // // // // //                     }
// // // // // // // // // // // // // // //                   },
// // // // // // // // // // // // // // //                   icon: Icon(Icons.arrow_upward),
// // // // // // // // // // // // // // //                 ),
// // // // // // // // // // // // // // //                 IconButton(
// // // // // // // // // // // // // // //                   onPressed: () {
// // // // // // // // // // // // // // //                     if (!_isRunning && _longBreakTime > 1) {
// // // // // // // // // // // // // // //                       setState(() {
// // // // // // // // // // // // // // //                         _longBreakTime--;
// // // // // // // // // // // // // // //                         restartTimer();
// // // // // // // // // // // // // // //                       });
// // // // // // // // // // // // // // //                     }
// // // // // // // // // // // // // // //                   },
// // // // // // // // // // // // // // //                   icon: Icon(Icons.arrow_downward),
// // // // // // // // // // // // // // //                 ),
// // // // // // // // // // // // // // //               ],
// // // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // // //             SizedBox(height: 20),
// // // // // // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // // // // // //               onPressed: () {
// // // // // // // // // // // // // // //                 if (!_isRunning) {
// // // // // // // // // // // // // // //                   _isRunning = true;
// // // // // // // // // // // // // // //                   startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// // // // // // // // // // // // // // //                 }
// // // // // // // // // // // // // // //               },
// // // // // // // // // // // // // // //               child: Text(_isRunning ? 'Timer Running' : 'Start Timer'),
// // // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // // //             SizedBox(height: 10),
// // // // // // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // // // // // //               onPressed: pauseTimer,
// // // // // // // // // // // // // // //               child: Text('Pause Timer'),
// // // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // // //             SizedBox(height: 10),
// // // // // // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // // // // // //               onPressed: restartTimer,
// // // // // // // // // // // // // // //               child: Text('Restart Timer'),
// // // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // // //           ],
// // // // // // // // // // // // // // //         ),
// // // // // // // // // // // // // // //       ),
// // // // // // // // // // // // // // //     );
// // // // // // // // // // // // // // //   }

// // // // // // // // // // // // // // //   int _timerTextToSeconds() {
// // // // // // // // // // // // // // //     List<String> timeSplit = _timerText.split(':');
// // // // // // // // // // // // // // //     int minutes = int.parse(timeSplit[0]);
// // // // // // // // // // // // // // //     int seconds = int.parse(timeSplit[1]);
// // // // // // // // // // // // // // //     return (minutes * 60) + seconds;
// // // // // // // // // // // // // // //   }

// // // // // // // // // // // // // // //   @override
// // // // // // // // // // // // // // //   void dispose() {
// // // // // // // // // // // // // // //     _timer?.cancel();
// // // // // // // // // // // // // // //     super.dispose();
// // // // // // // // // // // // // // //   }
// // // // // // // // // // // // // // // }










// // // // // // // // // // // // // // // // import 'dart:async';
// // // // // // // // // // // // // // // // import 'package:flutter/material.dart';

// // // // // // // // // // // // // // // // void main() {
// // // // // // // // // // // // // // // //   runApp(MyApp());
// // // // // // // // // // // // // // // // }

// // // // // // // // // // // // // // // // class MyApp extends StatelessWidget {
// // // // // // // // // // // // // // // //   @override
// // // // // // // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // // // // // // //     return MaterialApp(
// // // // // // // // // // // // // // // //       title: 'Pomodoro Timer',
// // // // // // // // // // // // // // // //       theme: ThemeData(
// // // // // // // // // // // // // // // //         primarySwatch: Colors.blue,
// // // // // // // // // // // // // // // //       ),
// // // // // // // // // // // // // // // //       home: PomodoroTimer(),
// // // // // // // // // // // // // // // //     );
// // // // // // // // // // // // // // // //   }
// // // // // // // // // // // // // // // // }

// // // // // // // // // // // // // // // // class PomodoroTimer extends StatefulWidget {
// // // // // // // // // // // // // // // //   @override
// // // // // // // // // // // // // // // //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // // // // // // // // // // // // // // // }

// // // // // // // // // // // // // // // // class _PomodoroTimerState extends State<PomodoroTimer> {
// // // // // // // // // // // // // // // //   int _studyTime = 25;
// // // // // // // // // // // // // // // //   int _breakTime = 5;
// // // // // // // // // // // // // // // //   int _longBreakTime = 15;
// // // // // // // // // // // // // // // //   int _currentTimer = 0;
// // // // // // // // // // // // // // // //   int _iterations = 0;
// // // // // // // // // // // // // // // //   bool _isRunning = false;
// // // // // // // // // // // // // // // //   String _timerText = '25:00';

// // // // // // // // // // // // // // // //   Timer? _timer;

// // // // // // // // // // // // // // // //   void startTimer(int minutes) {
// // // // // // // // // // // // // // // //     int seconds = minutes * 60;
// // // // // // // // // // // // // // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // // // // // // // // // // // // // //       setState(() {
// // // // // // // // // // // // // // // //         if (seconds > 0) {
// // // // // // // // // // // // // // // //           seconds--;
// // // // // // // // // // // // // // // //           int minutes = seconds ~/ 60;
// // // // // // // // // // // // // // // //           int remainingSeconds = seconds % 60;
// // // // // // // // // // // // // // // //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // // // // // // // // // // // // // //         } else {
// // // // // // // // // // // // // // // //           _timer!.cancel();
// // // // // // // // // // // // // // // //           if (_currentTimer == 0) {
// // // // // // // // // // // // // // // //             _iterations++;
// // // // // // // // // // // // // // // //             if (_iterations % 3 == 0) {
// // // // // // // // // // // // // // // //               _currentTimer = 2; // Long Break
// // // // // // // // // // // // // // // //               _timerText = '$_longBreakTime:00';
// // // // // // // // // // // // // // // //             } else {
// // // // // // // // // // // // // // // //               _currentTimer = 1; // Break
// // // // // // // // // // // // // // // //               _timerText = '$_breakTime:00';
// // // // // // // // // // // // // // // //             }
// // // // // // // // // // // // // // // //           } else {
// // // // // // // // // // // // // // // //             _currentTimer = 0; // Study
// // // // // // // // // // // // // // // //             _timerText = '$_studyTime:00';
// // // // // // // // // // // // // // // //           }
// // // // // // // // // // // // // // // //           _isRunning = false;
// // // // // // // // // // // // // // // //         }
// // // // // // // // // // // // // // // //       });
// // // // // // // // // // // // // // // //     });
// // // // // // // // // // // // // // // //   }

// // // // // // // // // // // // // // // //   @override
// // // // // // // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // // // // // // //     return Scaffold(
// // // // // // // // // // // // // // // //       appBar: AppBar(
// // // // // // // // // // // // // // // //         title: Text('Pomodoro Timer'),
// // // // // // // // // // // // // // // //       ),
// // // // // // // // // // // // // // // //       body: Center(
// // // // // // // // // // // // // // // //         child: Column(
// // // // // // // // // // // // // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // // // // // //           children: [
// // // // // // // // // // // // // // // //             Container(
// // // // // // // // // // // // // // // //               width: 200,
// // // // // // // // // // // // // // // //               height: 200,
// // // // // // // // // // // // // // // //               child: Stack(
// // // // // // // // // // // // // // // //                 children: [
// // // // // // // // // // // // // // // //                   CircularProgressIndicator(
// // // // // // // // // // // // // // // //                     value: _isRunning
// // // // // // // // // // // // // // // //                         ? 1 - (_timerTextToSeconds() / (_currentTimer == 0 ? _studyTime * 60.0 : (_currentTimer == 1 ? _breakTime * 60.0 : _longBreakTime * 60.0)))
// // // // // // // // // // // // // // // //                         : 0,
// // // // // // // // // // // // // // // //                     backgroundColor: Colors.grey[300],
// // // // // // // // // // // // // // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// // // // // // // // // // // // // // // //                     strokeWidth: 10,
// // // // // // // // // // // // // // // //                   ),
// // // // // // // // // // // // // // // //                   Center(
// // // // // // // // // // // // // // // //                     child: Text(
// // // // // // // // // // // // // // // //                       _timerText,
// // // // // // // // // // // // // // // //                       style: TextStyle(fontSize: 40, color: Colors.grey),
// // // // // // // // // // // // // // // //                     ),
// // // // // // // // // // // // // // // //                   ),
// // // // // // // // // // // // // // // //                 ],
// // // // // // // // // // // // // // // //               ),
// // // // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // // // //             SizedBox(height: 20),
// // // // // // // // // // // // // // // //             Text('Study Time: $_studyTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // // // // // //             Text('Break Time: $_breakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // // // // // //             Text('Long Break Time: $_longBreakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // // // // // //             SizedBox(height: 20),
// // // // // // // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // // // // // // //               onPressed: () {
// // // // // // // // // // // // // // // //                 if (!_isRunning) {
// // // // // // // // // // // // // // // //                   _isRunning = true;
// // // // // // // // // // // // // // // //                   startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// // // // // // // // // // // // // // // //                 }
// // // // // // // // // // // // // // // //               },
// // // // // // // // // // // // // // // //               child: Text(_isRunning ? 'Timer Running' : 'Start Timer'),
// // // // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // // // //           ],
// // // // // // // // // // // // // // // //         ),
// // // // // // // // // // // // // // // //       ),
// // // // // // // // // // // // // // // //     );
// // // // // // // // // // // // // // // //   }

// // // // // // // // // // // // // // // //   int _timerTextToSeconds() {
// // // // // // // // // // // // // // // //     List<String> timeSplit = _timerText.split(':');
// // // // // // // // // // // // // // // //     int minutes = int.parse(timeSplit[0]);
// // // // // // // // // // // // // // // //     int seconds = int.parse(timeSplit[1]);
// // // // // // // // // // // // // // // //     return (minutes * 60) + seconds;
// // // // // // // // // // // // // // // //   }

// // // // // // // // // // // // // // // //   @override
// // // // // // // // // // // // // // // //   void dispose() {
// // // // // // // // // // // // // // // //     _timer?.cancel();
// // // // // // // // // // // // // // // //     super.dispose();
// // // // // // // // // // // // // // // //   }
// // // // // // // // // // // // // // // // }













// // // // // // // // // // // // // // // // // import 'dart:async';
// // // // // // // // // // // // // // // // // import 'package:flutter/material.dart';

// // // // // // // // // // // // // // // // // void main() {
// // // // // // // // // // // // // // // // //   runApp(MyApp());
// // // // // // // // // // // // // // // // // }

// // // // // // // // // // // // // // // // // class MyApp extends StatelessWidget {
// // // // // // // // // // // // // // // // //   @override
// // // // // // // // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // // // // // // // //     return MaterialApp(
// // // // // // // // // // // // // // // // //       title: 'Pomodoro Timer',
// // // // // // // // // // // // // // // // //       theme: ThemeData(
// // // // // // // // // // // // // // // // //         primarySwatch: Colors.blue,
// // // // // // // // // // // // // // // // //       ),
// // // // // // // // // // // // // // // // //       home: PomodoroTimer(),
// // // // // // // // // // // // // // // // //     );
// // // // // // // // // // // // // // // // //   }
// // // // // // // // // // // // // // // // // }

// // // // // // // // // // // // // // // // // class PomodoroTimer extends StatefulWidget {
// // // // // // // // // // // // // // // // //   @override
// // // // // // // // // // // // // // // // //   _PomodoroTimerState createState() => _PomodoroTimerState();
// // // // // // // // // // // // // // // // // }

// // // // // // // // // // // // // // // // // class _PomodoroTimerState extends State<PomodoroTimer> {
// // // // // // // // // // // // // // // // //   int _studyTime = 25;
// // // // // // // // // // // // // // // // //   int _breakTime = 5;
// // // // // // // // // // // // // // // // //   int _longBreakTime = 15;
// // // // // // // // // // // // // // // // //   int _currentTimer = 0;
// // // // // // // // // // // // // // // // //   int _iterations = 0;
// // // // // // // // // // // // // // // // //   bool _isRunning = false;
// // // // // // // // // // // // // // // // //   String _timerText = '25:00';

// // // // // // // // // // // // // // // // //   Timer? _timer;

// // // // // // // // // // // // // // // // //   void startTimer(int minutes) {
// // // // // // // // // // // // // // // // //     int seconds = minutes * 60;
// // // // // // // // // // // // // // // // //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// // // // // // // // // // // // // // // // //       setState(() {
// // // // // // // // // // // // // // // // //         if (seconds > 0) {
// // // // // // // // // // // // // // // // //           seconds--;
// // // // // // // // // // // // // // // // //           int minutes = seconds ~/ 60;
// // // // // // // // // // // // // // // // //           int remainingSeconds = seconds % 60;
// // // // // // // // // // // // // // // // //           _timerText = '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
// // // // // // // // // // // // // // // // //         } else {
// // // // // // // // // // // // // // // // //           _timer!.cancel();
// // // // // // // // // // // // // // // // //           if (_currentTimer == 0) {
// // // // // // // // // // // // // // // // //             _iterations++;
// // // // // // // // // // // // // // // // //             if (_iterations % 3 == 0) {
// // // // // // // // // // // // // // // // //               _currentTimer = 2; // Long Break
// // // // // // // // // // // // // // // // //               _timerText = '$_longBreakTime:00';
// // // // // // // // // // // // // // // // //             } else {
// // // // // // // // // // // // // // // // //               _currentTimer = 1; // Break
// // // // // // // // // // // // // // // // //               _timerText = '$_breakTime:00';
// // // // // // // // // // // // // // // // //             }
// // // // // // // // // // // // // // // // //           } else {
// // // // // // // // // // // // // // // // //             _currentTimer = 0; // Study
// // // // // // // // // // // // // // // // //             _timerText = '$_studyTime:00';
// // // // // // // // // // // // // // // // //           }
// // // // // // // // // // // // // // // // //           _isRunning = false;
// // // // // // // // // // // // // // // // //         }
// // // // // // // // // // // // // // // // //       });
// // // // // // // // // // // // // // // // //     });
// // // // // // // // // // // // // // // // //   }

// // // // // // // // // // // // // // // // //   @override
// // // // // // // // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // // // // // // // //     return Scaffold(
// // // // // // // // // // // // // // // // //       appBar: AppBar(
// // // // // // // // // // // // // // // // //         title: Text('Pomodoro Timer'),
// // // // // // // // // // // // // // // // //       ),
// // // // // // // // // // // // // // // // //       body: Center(
// // // // // // // // // // // // // // // // //         child: Column(
// // // // // // // // // // // // // // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // // // // // // // // //           children: [
// // // // // // // // // // // // // // // // //             Container(
// // // // // // // // // // // // // // // // //               width: 200,
// // // // // // // // // // // // // // // // //               height: 200,
// // // // // // // // // // // // // // // // //               child: Stack(
// // // // // // // // // // // // // // // // //                 children: [
// // // // // // // // // // // // // // // // //                   CircularProgressIndicator(
// // // // // // // // // // // // // // // // //                     value: _isRunning ? 1 - (_timerTextToSeconds() / (_currentTimer == 0 ? _studyTime * 60 : (_currentTimer == 1 ? _breakTime * 60 : _longBreakTime * 60))),
// // // // // // // // // // // // // // // // //                     backgroundColor: Colors.grey[300],
// // // // // // // // // // // // // // // // //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
// // // // // // // // // // // // // // // // //                     strokeWidth: 10,
// // // // // // // // // // // // // // // // //                   ),
// // // // // // // // // // // // // // // // //                   Center(
// // // // // // // // // // // // // // // // //                     child: Text(
// // // // // // // // // // // // // // // // //                       _timerText,
// // // // // // // // // // // // // // // // //                       style: TextStyle(fontSize: 40, color: Colors.grey),
// // // // // // // // // // // // // // // // //                     ),
// // // // // // // // // // // // // // // // //                   ),
// // // // // // // // // // // // // // // // //                 ],
// // // // // // // // // // // // // // // // //               ),
// // // // // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // // // // //             SizedBox(height: 20),
// // // // // // // // // // // // // // // // //             Text('Study Time: $_studyTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // // // // // // //             Text('Break Time: $_breakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // // // // // // //             Text('Long Break Time: $_longBreakTime minutes', style: TextStyle(color: Colors.grey)),
// // // // // // // // // // // // // // // // //             SizedBox(height: 20),
// // // // // // // // // // // // // // // // //             ElevatedButton(
// // // // // // // // // // // // // // // // //               onPressed: () {
// // // // // // // // // // // // // // // // //                 if (!_isRunning) {
// // // // // // // // // // // // // // // // //                   _isRunning = true;
// // // // // // // // // // // // // // // // //                   startTimer(_currentTimer == 0 ? _studyTime : (_currentTimer == 1 ? _breakTime : _longBreakTime));
// // // // // // // // // // // // // // // // //                 }
// // // // // // // // // // // // // // // // //               },
// // // // // // // // // // // // // // // // //               child: Text(_isRunning ? 'Timer Running' : 'Start Timer'),
// // // // // // // // // // // // // // // // //             ),
// // // // // // // // // // // // // // // // //           ],
// // // // // // // // // // // // // // // // //         ),
// // // // // // // // // // // // // // // // //       ),
// // // // // // // // // // // // // // // // //     );
// // // // // // // // // // // // // // // // //   }

// // // // // // // // // // // // // // // // //   int _timerTextToSeconds() {
// // // // // // // // // // // // // // // // //     List<String> timeSplit = _timerText.split(':');
// // // // // // // // // // // // // // // // //     int minutes = int.parse(timeSplit[0]);
// // // // // // // // // // // // // // // // //     int seconds = int.parse(timeSplit[1]);
// // // // // // // // // // // // // // // // //     return (minutes * 60) + seconds;
// // // // // // // // // // // // // // // // //   }

// // // // // // // // // // // // // // // // //   @override
// // // // // // // // // // // // // // // // //   void dispose() {
// // // // // // // // // // // // // // // // //     _timer?.cancel();
// // // // // // // // // // // // // // // // //     super.dispose();
// // // // // // // // // // // // // // // // //   }
// // // // // // // // // // // // // // // // // }
