import 'package:collection/collection.dart';
import 'package:marquee/marquee.dart';

import 'package:moo/constants.dart';
import 'package:moo/content.dart';
import 'package:moo/design.dart';

final _TICKER = ALERTS
    .shuffled() //
    .map((headline) => headline.padLeft(TERMINAL_SIZE ~/ 6))
    .join();

class AlertTicker extends StatelessWidget {
  const AlertTicker();

  @override
  Widget build(context) {
    return SizedBox(
      height: 36,
      child: Row(
        children: [
          Container(
            alignment: .center,
            color: Palette.blood,
            padding: const .symmetric(
              horizontal: Space.x2,
              vertical: Space.x1,
            ),
            child: Text(
              'ALERT',
              style: .new(
                color: Colors.black,
                letterSpacing: 2,
              ),
            ),
          ),
          Expanded(
            child: Marquee(
              text: _TICKER,
              style: .new(
                color: Palette.amber,
                letterSpacing: 1.2,
              ),
              startPadding: Space.x2,
            ),
          ),
        ],
      ),
    );
  }
}
