import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/bloc/orders/cargo_bloc.dart';
import 'package:drugpromotion/core/routes/route_names.dart';
import 'package:drugpromotion/core/widgets/scale/scale.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:drugpromotion/screens/home/widgets/cargo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            pinned: true,
            elevation: 5,
            shadowColor: Colors.black.withAlpha(70),
            centerTitle: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text(
              AppLocalization.current.home_page,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppColors.blackish,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
            actions: [
              WScale(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNames.notifications);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Icon(
                    Icons.notifications_none_outlined,
                    size: 24.w,
                    color: AppColors.deepBlue,
                  ),
                ),
              ),
            ],
          )
        ],
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
            print('Status: ${state.status}');

            if (state.status.isPure) {
              context.read<CargoBloc>().add(CargoGetItemsEvent(args: null));
            }

            if (state.status.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            print('Length: ${state.cargos.length}');

            return ListView.separated(
              padding: EdgeInsets.fromLTRB(0, 8.h, 0, 100.h),
              itemBuilder: (context, index) => CargoItem(
                cargo: state.cargos[index],
              ),
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemCount: state.cargos.length,
            );
          },
        ),
      ),
    );
  }
}
