import 'package:flutter/material.dart';

extension CenteredSizedBox on double {
  SizedBox hSpace() {
    return SizedBox(
      height: this,
    );
  }

  SizedBox wSpace() {
    return SizedBox(
      width: this,
    );
  }
}
