import 'package:flutter/material.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Featuers/authUseingProvider/custom_check_box.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({super.key, required this.onChange});
  final ValueChanged<bool> onChange;
  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  bool isTearmAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCheckBox(
          onChange: (value) {
            isTearmAccepted = value;
            widget.onChange(value);
            setState(() {});
          },
          isChecked: isTearmAccepted,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'By creating an account, you agree to ',
                  style: AppStyles.styleRegular16.copyWith(
                    color: const Color(0xff949d9e),
                  ),
                ),
                TextSpan(
                  text: 'our terms and conditions',
                  style: AppStyles.styleBold16.copyWith(
                    color: const Color(0xff949d9e),
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xff949d9e),
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
  }
}
