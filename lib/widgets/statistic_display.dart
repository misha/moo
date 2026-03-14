import 'package:animated_flip_counter/animated_flip_counter.dart';

import 'package:moo/design.dart';
import 'package:moo/widgets/blinker.dart';

class StatisticRow {
  const StatisticRow({
    required this.label,
    required this.value,
    this.best = false,
  });

  final String label;
  final int value;
  final bool best;
}

class StatisticTable extends StatelessWidget {
  const StatisticTable({
    required this.rows,
  });

  final List<StatisticRow> rows;

  @override
  Widget build(context) {
    return Table(
      defaultVerticalAlignment: .middle,
      columnWidths: const {
        0: FixedColumnWidth(60),
        1: IntrinsicColumnWidth(),
        2: IntrinsicColumnWidth(),
        3: FixedColumnWidth(25),
        4: IntrinsicColumnWidth(),
        5: FixedColumnWidth(20),
        6: FixedColumnWidth(80),
      },
      children: [
        for (final row in rows) //
          TableRow(
            children: [
              const SizedBox.shrink(),
              const SizedBox.shrink(),
              Text(
                row.label,
                textAlign: .right,
                style: Typography.body.copyWith(fontSize: 18),
              ),
              const SizedBox.shrink(),
              AnimatedFlipCounter(
                value: row.value,
                duration: const Duration(milliseconds: 500),
                textStyle: Typography.special.copyWith(fontSize: 24),
                mainAxisAlignment: .start,
              ),
              const SizedBox.shrink(),
              Visibility(
                visible: row.best,
                child: Blinker(
                  period: const Duration(milliseconds: 500),
                  child: Text('BEST!', style: Typography.alert),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
