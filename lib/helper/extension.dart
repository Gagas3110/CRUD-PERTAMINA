import 'package:pertamina_test/helper/cust_snackbar.dart';

import 'package:flutter/material.dart';

extension Scaler on BuildContext {
  double scaleFont(double initialFontSize) {
    return (MediaQuery.of(this).size.width * 0.0027) * initialFontSize;
  }

  double scaleHeight(double initialHeight) {
    return (MediaQuery.of(this).size.height * 0.0011) * initialHeight;
  }

  double deviceWidth() {
    return (MediaQuery.of(this).size.width);
  }

  double deviceHeight() {
    return (MediaQuery.of(this).size.height);
  }
}

extension SnackBars on BuildContext {
  failSnackbar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(failSnackBar(message));
  }

  succesSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(successSnackBar(message));
  }
}
