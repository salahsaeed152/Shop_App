import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget defaultTextForm({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          5.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            keyboardType: type,
            obscureText: isPassword,
            enabled: isClickable,
            onFieldSubmitted: onSubmit,
            onChanged: onChange,
            onTap: onTap,
            validator: validate,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(
                prefix,
              ),
              suffixIcon: suffix != null
                  ? IconButton(
                      onPressed: suffixPressed,
                      icon: Icon(
                        suffix,
                      ),
                    )
                  : null,
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

Widget buildArticleItem(context, {@required article}) => InkWell(
      // onTap: (){
      //   navigateTo(context, WebViewScreen(article['url']));
      // },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                    '${article['urlToImage']}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget articleBuilder(context, list, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            buildArticleItem(context, article: list[index]),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length,
      ),
      fallback: (context) =>
          Center(child: isSearch ? Container() : CircularProgressIndicator()),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

void showToast({
  @required String message,
  @required ToastState state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseColorState(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseColorState(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget loading(BuildContext context, String message) => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(),
      SizedBox(height: 10),
      Text(
        message,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    ],
  ),
);

// Widget buildListProduct(
//     DataModel model,
//     context, {
//       bool isOldPrice = true,
//     }) =>
//     Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Container(
//         height: 120.0,
//         child: Row(
//           children: [
//             Stack(
//               alignment: AlignmentDirectional.bottomStart,
//               children: [
//                 Image(
//                   image: NetworkImage(model.image),
//                   width: 120.0,
//                   height: 120.0,
//                 ),
//                 // if (model.discount != 0 && isOldPrice)
//                   Container(
//                     color: Colors.red,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 5.0,
//                     ),
//                     child: Text(
//                       'DISCOUNT',
//                       style: TextStyle(
//                         fontSize: 8.0,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             SizedBox(
//               width: 20.0,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     model.name,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       height: 1.3,
//                     ),
//                   ),
//                   Spacer(),
//                   Row(
//                     children: [
//                       Text(
//                         model.price.toString(),
//                         style: TextStyle(
//                           fontSize: 12.0,
//                           color: defaultColor,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5.0,
//                       ),
//                       // if (model.discount != 0 && isOldPrice)
//                       //   Text(
//                       //     model.oldPrice.toString(),
//                       //     style: TextStyle(
//                       //       fontSize: 10.0,
//                       //       color: Colors.grey,
//                       //       decoration: TextDecoration.lineThrough,
//                       //     ),
//                       //   ),
//                       Spacer(),
//                       IconButton(
//                         onPressed: () {
//                           ShopCubit.get(context).changeFavorites(model.id);
//                         },
//                         icon: CircleAvatar(
//                           radius: 15.0,
//                           backgroundColor:
//                           ShopCubit.get(context).favorites[model.id]
//                               ? defaultColor
//                               : Colors.grey,
//                           child: Icon(
//                             Icons.favorite_border,
//                             size: 14.0,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

