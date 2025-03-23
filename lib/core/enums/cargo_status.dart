import 'package:drugpromotion/generated/l10n.dart';

enum CargoStatus {
  beingFormed(1),
  readyForLoading(2),
  onTheWay(3),
  closed(4),
  unknown(0);

  final int number;

  const CargoStatus(this.number);

  static CargoStatus fromCode(int number) => CargoStatus.values.firstWhere(
        (status) => status.number == number,
        orElse: () => CargoStatus.unknown,
      );

  String get description => switch (this) {
        CargoStatus.beingFormed => AppLocalization.current.beingFormed,
        CargoStatus.readyForLoading => AppLocalization.current.readyForLoading,
        CargoStatus.onTheWay => AppLocalization.current.onTheWay,
        CargoStatus.closed => AppLocalization.current.closed,
        CargoStatus.unknown => AppLocalization.current.unknown,
      };

  bool get isBeingFormed => this == beingFormed;

  bool get isReadyForLoading => this == readyForLoading;

  bool get isOnTheWay => this == onTheWay;

  bool get isClosed => this == closed;

  bool get isUnknown => this == unknown;
}
