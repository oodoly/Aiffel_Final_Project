import 'package:flutter/material.dart';
import '../util/appcolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../util/apptext.dart';

class ButtonBox extends StatelessWidget {
  const ButtonBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.buttonSetDefault,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultInUseButtonFactory(
            onDefaultPressed: () {
              print('Default button clicked - STT 시작');
            },
            onInUsePressed: () {
              print('InUse button clicked - STT 종료');
            },
          ).createButton('Default-InUse'),
          const SizedBox(width: 24),
          DefaultDisabledButtonFactory(
            onDefaultPressed: () {
              print('Default button clicked');
            },
          ).createButton('Default-Disabled'),
          const SizedBox(width: 24),
          DefaultDisabledInUseButtonFactory(
            isCartEmpty: false,
            onDefaultPressed: () {
              print('카트에 아이템 있음, 페이지 이동');
            },
          ).createButton('All States'),
        ],
      ),
    );
  }
}

enum ButtonState { buttonDefault, inUse, disabled }

abstract class ButtonFactory {
  Widget createButton(String label);
}

class DefaultDisabledButtonFactory implements ButtonFactory {
  final VoidCallback? onDefaultPressed;

  DefaultDisabledButtonFactory({this.onDefaultPressed});

  @override
  Widget createButton(String label) {
    return BasicButton(
      label: label,
      state: ButtonState.buttonDefault,
      onPressed: onDefaultPressed,
      buttonColor: Colors.lightBlue,
      isClickable: true,
    );
  }
}

class DefaultInUseButtonFactory implements ButtonFactory {
  final VoidCallback? onDefaultPressed;
  final VoidCallback? onInUsePressed;

  DefaultInUseButtonFactory({
    this.onDefaultPressed,
    this.onInUsePressed,
  });

  @override
  Widget createButton(String label) {
    return BasicButton(
      label: label,
      state: ButtonState.buttonDefault,
      onPressed: onDefaultPressed,
      buttonColor: Colors.green,
      isClickable: true,
    );
  }
}

class DefaultDisabledInUseButtonFactory implements ButtonFactory {
  final VoidCallback? onDefaultPressed;
  final VoidCallback? onInUsePressed;
  final bool isCartEmpty;

  DefaultDisabledInUseButtonFactory({
    required this.isCartEmpty,
    this.onDefaultPressed,
    this.onInUsePressed,
  });

  @override
  Widget createButton(String label) {
    if (isCartEmpty) {
      return BasicButton(
        label: label,
        state: ButtonState.disabled,
        buttonColor: Colors.grey,
        isClickable: false,
      );
    } else {
      return BasicButton(
        label: label,
        state: ButtonState.buttonDefault,
        onPressed: onDefaultPressed,
        buttonColor: Colors.lightBlue,
        isClickable: true,
      );
    }
  }
}

class BasicButton extends StatelessWidget {
  final String label;
  final ButtonState state;
  final VoidCallback? onPressed;
  final Color buttonColor;
  final bool isClickable;

  const BasicButton({
    super.key,
    required this.label,
    required this.state,
    this.onPressed,
    required this.buttonColor,
    required this.isClickable,
  });

  @override
  Widget build(BuildContext context) {
    double buttonSize =
        ScreenUtil().orientation == Orientation.portrait ? 70.h : 40.w;

    TextStyle textStyle =
        isClickable ? AppText.buttonText : AppText.buttonTextDisabled;

    return GestureDetector(
      onTap: isClickable ? onPressed : null,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isClickable
              ? const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(-1, 3),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
