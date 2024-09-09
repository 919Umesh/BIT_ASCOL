import 'dart:io';

import 'package:bit_ascol/screens/artificail_Intelligence/popup_Menu.dart';
import 'package:flutter/material.dart';

import 'chat_ViewModel.dart';
import 'color_Constant.dart';
import 'common_text_form_Widget.dart';
import 'image_constant.dart';
import 'inputfield_Button.dart';


class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget({super.key, this.model});
  final ChatViewModel? model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom:25,left:25,right:25,top:10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: ColorConstants.grey3D4354,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  model?.imageFile != null
                      ? Container(
                    padding: const EdgeInsets.only(left: 22),
                    child: TextFormFieldWidget(
                      model: model,
                    ),
                  )
                      : const SizedBox(),
                  model?.imageFile != null
                      ? Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: Image(
                      height: 200,
                      width: 200,
                      image: FileImage(
                          model?.imageFile ?? File(ImageConstants.demo)),
                    ),
                  )
                      : const SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InputFieldButton(
                        icon: Icons.attach_file,
                        onpressed: () {
                          model?.setShowEmoji=false;
                          showModalBottomSheet(
                              backgroundColor: ColorConstants.transparent,
                              context: context,
                              isScrollControlled: true,
                              builder: (builder) => Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: PopUpWidget(model: model,)));
                        },
                      ),
                      model?.imageFile == null
                          ? Flexible(
                          child: TextFormFieldWidget(
                            model: model,
                          ))
                          : const SizedBox(),

                      InputFieldButton(
                        icon: Icons.send,
                        onpressed: () {
                          if (model?.imageFile != null &&
                              model!.messageController.text
                                  .toString()
                                  .isEmpty) {
                            model?.getTextAndImageInfo();
                          }
                          if (model?.messageController.text
                              .toString()
                              .isNotEmpty ??
                              false) {
                            model?.getTextAndImageInfo();
                            model?.messageController.clear();
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
