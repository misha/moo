import 'package:moo/design.dart';
import 'package:moo/gen/assets.gen.dart';

enum FileGroup {
  bureaucratic(Palette.sky),
  economic(Palette.amber),
  banal(Palette.phosphor),
  scientific(Palette.ether),
  evil(Palette.blood)
  ;

  const FileGroup(this.color);

  final Color color;
}

enum FileType {
  arc(group: .scientific, label: 'ARC', directory: 'ARCHIVES'),
  bio(group: .scientific, label: 'BIO', directory: 'BIODATA'),
  cal(group: .banal, label: 'CAL', directory: 'CALENDAR'),
  fin(group: .economic, label: 'FIN', directory: 'FINANCIAL'),
  frm(group: .banal, label: 'FRM', directory: 'FORMS'),
  pid(group: .bureaucratic, label: 'PID', directory: 'PERSONNEL'),
  pwd(group: .economic, label: 'PWD', directory: 'PASSWORDS'),
  rpt(group: .bureaucratic, label: 'RPT', directory: 'REPORTS'),
  sec(group: .evil, label: 'SEC', directory: 'SECRETS'),
  wep(group: .evil, label: 'WPN', directory: 'WEAPONS'),
  ;

  const FileType({
    required this.group,
    required this.label,
    required this.directory,
  });

  final FileGroup group;
  final String label;
  final String directory;

  AssetGenImage get asset => switch (this) {
    .arc => Assets.images.extArc,
    .bio => Assets.images.extBio,
    .cal => Assets.images.extCal,
    .fin => Assets.images.extFin,
    .frm => Assets.images.extFrm,
    .pid => Assets.images.extPid,
    .pwd => Assets.images.extPwd,
    .rpt => Assets.images.extRpt,
    .sec => Assets.images.extSec,
    .wep => Assets.images.extWep,
  };

  Color get color => group.color;
}
