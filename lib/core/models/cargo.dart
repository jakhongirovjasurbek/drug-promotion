import 'package:drugpromotion/core/enums/cargo_status.dart';
import 'package:drugpromotion/core/models/order.dart';
import 'package:equatable/equatable.dart';

final class CargoModel extends Equatable {
  final String cargoId;
  final String cargoDate;
  final CargoStatus cargoStatus;
  final List<OrderModel> orders;

  const CargoModel({
    required this.cargoId,
    required this.cargoDate,
    required this.cargoStatus,
    required this.orders,
  });

  factory CargoModel.fromJson(Map<String, dynamic> json) {
    return CargoModel(
      cargoId: json['cargo_id'],
      cargoDate: json['cargo_date'],
      cargoStatus: CargoStatus.fromCode(json['cargo_status']),
      orders: OrderModel.buildList(json['orders']),
    );
  }

  static List<CargoModel> buildList(List cargos) {
    return cargos.map((cargo) => CargoModel.fromJson(cargo)).toList();
  }

  @override
  List<Object> get props => [cargoId, cargoDate, cargoStatus, orders];
}
