import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget{
  const LoadingWidget({super.key, this.padding});

  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Padding(
        padding:padding?? EdgeInsets.all(8.0),
        child:
        // SizedBox(
        //   height: 80,
        //   width: 80,
        //   child: LoadingIndicator(
        //       indicatorType: Indicator.pacman, /// Required, The loading type of the widget
        //       colors:  [MyColors.primary],       /// Optional, The color collections
        //       strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
        //       backgroundColor:MyColors.canvasColor,      /// Optional, Background of the widget
        //       pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
        //   ),
        // )
        CircularProgressIndicator(),
      ),
    );
  }

}
