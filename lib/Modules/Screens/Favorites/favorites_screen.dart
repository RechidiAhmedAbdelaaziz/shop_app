// ignore_for_file: unnecessary_null_comparison

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/Shop_Cubit/shop_cubit.dart';
import 'package:shop_app/Layout/Shop_Cubit/shop_states.dart';
import 'package:shop_app/Moldels/home_models.dart';
import 'package:shop_app/Shared/Compenents/constants.dart';
import 'package:shop_app/Shared/Styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.favoritesModel != null ,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => myDivider(),
            itemBuilder: (context, index) =>
                buildFavItem(cubit.favoritesModel!.data.products[index], context),
            itemCount: cubit.favoritesModel!.data.products.length,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Widget buildFavItem(ProductModel model, context) => Container(
      height: 120,
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
              if (model.discount != 0)
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 0, 0, 1),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'DISCOUNT ${model.discount.round().toString()}%',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16.0,
                    height: 1.0,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price.round()} \$',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFav(id: model.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.id] == true
                                  ? defaultColor
                                  : Colors.grey,
                          radius: 15,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 18,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
