// providersTest/stateManagmentWithInherit/test.dart
import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text(
          'Hello, world!\nSecond line!',
          style: TextStyle(fontSize: 8, fontFamily: 'Raleway'),
          strutStyle: StrutStyle(
            fontFamily: 'Roboto',
            fontSize: 4,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class InheritNumber extends InheritedWidget {
  const InheritNumber({super.key, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    throw UnimplementedError();
  }
}
