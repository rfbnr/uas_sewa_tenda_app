import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../auth/bloc/auth_bloc.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.gradient2,
            AppColors.gradient1,
          ],
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(
            MediaQuery.of(context).size.width,
            100,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "SAPALA ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "OUTDOOR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            letterSpacing: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SpaceHeight(30),
                  Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: AppColors.primary,
                        ),
                      ),
                      SpaceWidth(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                final hour = DateTime.now().hour;
                                final time = hour == 4 && hour < 10
                                    ? "Pagi"
                                    : hour == 10 && hour < 15
                                        ? "Siang"
                                        : hour == 15 && hour < 18
                                            ? "Sore"
                                            : "Malam";

                                switch (state.dataStatus) {
                                  case DataStatus.failure:
                                    return Text(
                                      "Selamat $time, ERROR",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );

                                  case DataStatus.success:
                                    final data = state.dataUser!;

                                    return Text(
                                      "Selamat $time, ${data.name ?? "-"}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );

                                  default:
                                    return Text(
                                      "Selamat $time, ANONYMOUS",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SpaceHeight(60),
          ],
        ),
      ),
    );
  }
}
