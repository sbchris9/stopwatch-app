import 'package:flutter/material.dart';

bool isScreenSmallerThan(int length, BuildContext context) =>
    isScreenWidthSmallerThan(length, context) ||
    isScreenHeightSmallerThan(length, context);

bool isScreenWidthSmallerThan(int length, BuildContext context) =>
    MediaQuery.of(context).size.width <= length;

bool isScreenHeightSmallerThan(int length, BuildContext context) =>
    MediaQuery.of(context).size.height <= length;
