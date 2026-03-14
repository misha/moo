import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:moo/design.dart';
import 'package:moo/hooks/use_now.dart';
import 'package:moo/widgets/blinker.dart';

class TerminalHeader extends HookWidget {
  const TerminalHeader();

  @override
  Widget build(context) {
    final now = useNow();
    final clock = useMemoized(() {
      final date =
          '1984-'
          '${now.month.toString().padLeft(2, '0')}-'
          '${now.day.toString().padLeft(2, '0')}';

      final time =
          '${now.hour.toString().padLeft(2, '0')}:'
          '${now.minute.toString().padLeft(2, '0')}:'
          '${now.second.toString().padLeft(2, '0')}';

      return '$date :: $time';
    }, [now]);

    return Container(
      color: Palette.radiation,
      height: 36,
      padding: Space.p2,
      child: Row(
        crossAxisAlignment: .center,
        children: [
          Text('MINISTRY OF ORDER - SECURE CONNECTION', style: Typography.decor),
          Spacer(),
          Row(
            spacing: Space.x1,
            children: [
              Blinker(
                period: const Duration(milliseconds: 750),
                // Somehow not centered on web without this nudge.
                child: Transform.translate(
                  offset: const Offset(0, 1),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Palette.blood,
                      shape: .circle,
                    ),
                  ),
                ),
              ),
              Text('REC', style: Typography.surveillance),
            ],
          ),
          Spacer(),
          Text(clock, style: Typography.decor),
        ],
      ),
    );
  }
}
