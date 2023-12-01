import 'package:_iwu_pack/_iwu_pack.dart';
import 'package:_iwu_pack/setup/app_utils.dart';
import 'package:_iwu_pack/setup/index.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: hexColor('355797')),
      padding: EdgeInsets.symmetric(
          horizontal: _paddingHorizontal(context), vertical: 24),
      child: Row(
        children: [
          const WidgetAppSVG(
                'm5',
                width: 56,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 16,
            width: 1,
            color: Colors.white,
          ),
          Expanded(
            child: Text(
              'Support Inbox'.tr(),
              style: w300TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  double _paddingHorizontal(BuildContext context) =>
      context.width > 1280 ? (context.width - 1280) / 2 : 16;
}
