import 'package:moo/constants.dart';
import 'package:moo/design.dart';
import 'package:moo/widgets/alert_ticker.dart';
import 'package:moo/widgets/crt.dart';
import 'package:moo/widgets/terminal_header.dart';

class Terminal extends StatelessWidget {
  const Terminal({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(context) {
    return Crt(
      child: FittedBox(
        child: Container(
          width: TERMINAL_SIZE,
          height: TERMINAL_SIZE,
          margin: Space.p5,
          decoration: BoxDecoration(
            color: Palette.neon.withValues(alpha: 0.04),
            border: .all(color: Palette.system),
          ),
          child: Column(
            children: [
              const TerminalHeader(),
              Container(height: 1, color: Palette.system),
              const AlertTicker(),
              Container(height: 1, color: Palette.system),
              Expanded(
                child: Padding(
                  padding: Space.p3,
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
