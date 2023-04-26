import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Layout/Shop_Cubit/shop_cubit.dart';
import 'package:shop_app/Layout/Shop_Cubit/shop_states.dart';
import 'package:shop_app/Moldels/categories_model.dart';
import 'package:shop_app/Moldels/home_models.dart';
import 'package:shop_app/Shared/Styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is SuccessChangeFavState) {
          if (!state.changeFavModel.status) {
            Fluttertoast.showToast(
                msg: state.changeFavModel.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.orange,
                textColor: Colors.white,
                fontSize: 13.0);
          }else {
            Fluttertoast.showToast(
                msg: state.changeFavModel.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 13.0);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) =>
              widgetBuilder(cubit.homeModel, cubit.categoriesModel, context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Widget widgetBuilder(
    HomeModel? hModel, CategoriesModel? cModel, BuildContext context) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: hModel!.data.banners.map((e) {
            return Image(
              image: NetworkImage(e.image),
              width: double.infinity,
              fit: BoxFit.cover,
            );
          }).toList(),
          options: CarouselOptions(
              height: 200.0,
              initialPage: 0,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              scrollDirection: Axis.horizontal),
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Categories :',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 120,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                buildCategory(cModel.data.data[index]),
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
            itemCount: cModel!.data.data.length,
          ),
        ),
        const Text(
          'New Products :',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1 / 2.3,
            children: List.generate(hModel.data.products.length, (index) {
              return gridProductItem(hModel.data.products[index], context);
            }),
          ),
        ),
      ],
    ),
  );
}

Widget buildCategory(CategoryDataModel model) => Container(
      margin: const EdgeInsets.only(bottom: 8, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image(
                image: NetworkImage(model.image),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              Container(
                  width: 100,
                  color: Colors.black.withOpacity(0.8),
                  child: Text(
                    model.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ],
      ),
    );

Widget gridProductItem(ProductModel model, context) {
  return Container(
    color: Colors.white,
    child: Column(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: double.infinity,
              height: 350,
              fit: BoxFit.contain,
            ),
            if (model.discount != 0)
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 0, 0, 1),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
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
        
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
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
}
