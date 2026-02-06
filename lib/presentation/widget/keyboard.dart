import 'package:flutter/material.dart';
import 'package:wapipay_challenge/presentation/theme/colors.dart';
import 'package:wapipay_challenge/presentation/widget/text.dart';

class WPKeyboard extends StatelessWidget {
  final Color buttonColour;
  final Color iconColour;
  final Function delete;
  final TextEditingController controller;

  const WPKeyboard({
    required this.delete,
    required this.controller,
    super.key,
    this.buttonColour = appBlack,
    this.iconColour = appBlack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _KeyButton(number: 1, controller: controller),
              _KeyButton(number: 2, controller: controller),
              _KeyButton(number: 3, controller: controller),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _KeyButton(number: 4, controller: controller),
              _KeyButton(number: 5, controller: controller),
              _KeyButton(number: 6, controller: controller),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _KeyButton(number: 7, controller: controller),
              _KeyButton(number: 8, controller: controller),
              _KeyButton(number: 9, controller: controller),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: InkWell(
                  splashColor: Colors.black12,
                  customBorder: CircleBorder(),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.photo_camera_front_outlined,
                      color: appBlack,
                      size: 24,
                    ),
                  ),
                ),
              ),
              _KeyButton(number: 0, controller: controller),
              Expanded(
                child: InkWell(
                  splashColor: Colors.black12,
                  customBorder: CircleBorder(),
                  onTap: () => delete(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(Icons.backspace, color: appBlack, size: 24),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _KeyButton extends StatelessWidget {
  final int number;
  final TextEditingController controller;

  const _KeyButton({required this.number, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        customBorder: CircleBorder(),
        splashColor: Colors.black12,
        onTap: () {
          controller.text += number.toString();
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(child: WPText.bold(number.toString(), fontSize: 18)),
        ),
      ),
    );
  }
}
