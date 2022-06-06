import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//lo covertimos a widget reutilizable
class SearchButton extends StatelessWidget {
  const SearchButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/pages/home/search.svg',
              width: 20,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            Text(
              'Encuentra tu comida',
              style: FontStyles.normalnegrito.copyWith(color: Colors.grey),
            )
          ],
        ),
        onPressed: () {});
  }
}
