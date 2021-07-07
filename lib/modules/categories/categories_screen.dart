import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_cubit/shop_states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var shopCubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: shopCubit.categoriesModel != null,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                buildCatItem(shopCubit.categoriesModel.data.data[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: shopCubit.categoriesModel.data.data.length,
          ),
          fallback: (context) => loading(context, 'Loading...'),
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            Text(
              model.name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
