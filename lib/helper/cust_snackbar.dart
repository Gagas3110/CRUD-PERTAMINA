
import 'package:flutter/material.dart';

successSnackBar(String message) {
  return SnackBar(
    duration: Duration(seconds: 5),
    content: Text(
      message,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
    backgroundColor: Colors.green,
  );
}

failSnackBar(String message) {
  return SnackBar(
    duration: Duration(seconds: 5),
    content: Text(
      message,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
    backgroundColor: Colors.red,
  );
}
