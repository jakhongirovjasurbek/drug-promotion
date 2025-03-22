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
}
