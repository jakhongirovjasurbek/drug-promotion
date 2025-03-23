import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/bloc/orders/cargo_bloc.dart';
import 'package:drugpromotion/core/widgets/app_bar/app_bar.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:drugpromotion/screens/home/widgets/cargo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: WAppBar(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Text(
          AppLocalization.current.order_history,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.blackish,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
        ),
      ),
      body: BlocConsumer<CargoBloc, CargoState>(
        listener: (context, state) {
          if (state.status.isLoadFailure) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                dismissDirection: DismissDirection.horizontal,
                elevation: 0,
                backgroundColor: Colors.transparent,
                content: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: Text(state.error!),
                  ),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status.isPure) {
            context.read<CargoBloc>().add(CargoGetItemsEvent(args: null));
          }

          if (state.status.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final cargos = state.cargos
              .where((cargo) => cargo.cargoStatus.isClosed)
              .toList();

          return ListView.separated(
            padding: EdgeInsets.fromLTRB(0, 8.h, 0, 100.h),
            itemBuilder: (context, index) => CargoItem(cargo: cargos[index]),
            separatorBuilder: (_, __) => SizedBox(height: 8.h),
            itemCount: cargos.length,
          );
        },
      ),
    );
  }
}
