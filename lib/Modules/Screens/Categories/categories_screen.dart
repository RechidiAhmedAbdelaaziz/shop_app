import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/Shop_Cubit/shop_cubit.dart';
import 'package:shop_app/Layout/Shop_Cubit/shop_states.dart';
import 'package:shop_app/Moldels/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) =>
                buildCatitem(cubit.categoriesModel!.data.data[index]),
            separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
            itemCount: cubit.categoriesModel!.data.data.length);
      },
    );
  }
}

Widget buildCatitem(CategoryDataModel model) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          model.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}
