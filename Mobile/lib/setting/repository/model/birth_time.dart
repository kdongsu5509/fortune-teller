import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.none)
enum BirthTime {
  Missing('모름'),
  Ja('자시 (23:30~01:30)'),
  Chuk('축시 (01:30~03:30)'),
  In('인시 (03:30~05:30)'),
  Myo('묘시 (05:30~07:30)'),
  Jin('진시 (07:30~09:30)'),
  Sa('사시 (09:30~11:30)'),
  O('오시 (11:30~13:30)'),
  Mi('미시 (13:30~15:30)'),
  Sin('신시 (15:30~17:30)'),
  Yu('유시 (17:30~19:30)'),
  Sul('술시 (19:30~21:30)'),
  Hae('해시 (21:30~23:30)');


  final String label;
  const BirthTime(this.label);
}
