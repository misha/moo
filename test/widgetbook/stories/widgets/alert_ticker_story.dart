import 'package:flutter/material.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:moo/widgets/alert_ticker.dart';

@UseCase(name: 'Default', type: AlertTicker)
Widget buildAlertTickerStory(_) => const AlertTicker();
