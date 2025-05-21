import 'package:drugpromotion/core/enums/cargo_status.dart';
import 'package:drugpromotion/core/models/order.dart';
import 'package:equatable/equatable.dart';

final class CargoModel extends Equatable {
  final String cargoId;
  final String cargoDate;
  final String description;
  final CargoStatus cargoStatus;
  final List<OrderModel> orders;

  const CargoModel({
    required this.cargoId,
    required this.cargoDate,
    required this.cargoStatus,
    required this.orders,
    required this.description,
  });

  factory CargoModel.fromJson(Map<String, dynamic> json) {
    return CargoModel(
      cargoId: json['cargo_id'],
      cargoDate: json['cargo_date'],
      cargoStatus: CargoStatus.fromCode(json['cargo_status']),
      orders: OrderModel.buildList(json['orders']),
      description: json['cargo_description'],
    );
  }

  static List<CargoModel> buildList(List cargos) {
    return cargos.map((cargo) => CargoModel.fromJson(cargo)).toList();
  }

  @override
  List<Object> get props => [cargoId, cargoDate, cargoStatus, orders, description];

  CargoModel copyWith({
    String? cargoId,
    String? cargoDate,
    String? description,
    CargoStatus? cargoStatus,
    List<OrderModel>? orders,
  }) {
    return CargoModel(
      cargoId: cargoId ?? this.cargoId,
      cargoDate: cargoDate ?? this.cargoDate,
      description: description ?? this.description,
      cargoStatus: cargoStatus ?? this.cargoStatus,
      orders: orders ?? this.orders,
    );
  }

  @override
  String toString() {
    return 'CargoModel{cargoId: $cargoId, cargoDate: $cargoDate, description: $description, cargoStatus: $cargoStatus, orders: $orders}';
  }
}
