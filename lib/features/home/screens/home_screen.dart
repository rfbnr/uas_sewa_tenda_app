import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_sewa_tenda_app/core/extension/int_currency_ext.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/datas.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../transaction/screens/transaction_create_screen.dart';
import '../widgets/home_header_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(GetUserLogin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeaderSection(),
            SpaceHeight(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ClipRRect(
                child: Image.asset(
                  "assets/images/bg-camping.png",
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SpaceHeight(20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                  bottom: 120.0,
                  top: 20.0,
                ),
                physics: const ScrollPhysics(),
                itemCount: tendaItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 250.0,
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 16.0,
                ),
                itemBuilder: (context, index) {
                  final tenda = tendaItems[index];

                  return ProductTendaCardWidget(
                    data: tenda,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductTendaCardWidget extends StatelessWidget {
  final TendaItemModel data;

  const ProductTendaCardWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1.4,
            color: AppColors.gradient1,
          ),
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(0.8),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: Image.asset(
                "assets/images/tenda.png",
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data.name,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  data.description,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: AppColors.grey,
                  ),
                ),
                const SpaceHeight(6.0),
                Text(
                  data.price.currencyFormatRp,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SpaceHeight(10.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionCreateScreen(
                          item: data,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.gradient1,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Sewa Tenda",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SpaceHeight(8.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
