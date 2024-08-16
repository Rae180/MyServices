// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'app_text.dart';

class DialogItem extends StatelessWidget {
  final String? title;
  final String? paragraph;
  final String? image;
  final String? cancelButtonText;
  final String? nextButtonText;
  final Function? cancelButtonFunction;
  final Function? nextButtonFunction;
  final Widget? icon;
  const DialogItem({
    super.key,
    this.title,
    this.paragraph,
    this.image,
    this.cancelButtonText,
    this.nextButtonText,
    this.cancelButtonFunction,
    this.nextButtonFunction,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.all(10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (image != null) _buildImage(),
          if (icon != null) _buildIcon(),
          const SizedBox(
            height: 16,
          ),
          if (title != null) _buildTitle(),
          const SizedBox(
            height: 16,
          ),
          if (paragraph != null) _buildParagraph(),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (nextButtonText != null) _buildNextButton(context),
              const SizedBox(
                width: 20,
              ),
              if (cancelButtonText != null) _buildCancelBtn(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() => icon!;

  Image _buildImage() {
    return Image.asset(
      image!,
      width: 90,
      height: 90,
    );
  }

  AppText _buildTitle() {
    return AppText(
      title!,
      bold: true,
      
    );
  }

  AppText _buildParagraph() {
    return AppText(
      paragraph!,
      color: const Color(0xff9B9B9B),
      textAlign: TextAlign.center,
    );
  }

  Expanded _buildCancelBtn() {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          cancelButtonFunction!();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.withOpacity(.5),
        ),
        child: Text(
          cancelButtonText!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Expanded _buildNextButton(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          nextButtonFunction!();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        child: Text(
          nextButtonText!,
          maxLines: 1,
          style: const TextStyle(color: Colors.white,fontSize: 15),
        ),
      ),
    );
  }
}
