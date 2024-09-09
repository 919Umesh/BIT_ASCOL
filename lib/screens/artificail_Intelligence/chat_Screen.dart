import 'package:flutter/material.dart';
import 'baseView.dart';
import 'chat_Model.dart';
import 'chat_ViewModel.dart';
import 'color_Constant.dart';
import 'image_constant.dart';
import 'inputField.dart';
import 'messageContent.dart';


class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  ChatViewModel? model;
  @override
  Widget build(BuildContext context) {
    return BaseView<ChatViewModel>(
      onModelReady: (model) {
        this.model = model;
      },
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            model.setShowEmoji=false;
          },
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstants.defaultWallpaper),
                fit: BoxFit.fill,
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
             backgroundColor: ColorConstants.transparent,
              appBar: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 80),
                child: buildAppBar(context),
              ),
              body: buildBody(context),
            ),
          ),
        );
      },
    );
  }
  //
  // Widget buildAppBar(BuildContext context) {
  //   return  Container(
  //     color: primaryColor,
  //     child: Padding(
  //       padding: EdgeInsets.only(left: 20, top: 40, bottom: 10),
  //       child: ListTile(
  //         // leading: ClipRRect(
  //         //   borderRadius: BorderRadius.circular(30),
  //         //   child: Image.asset(ImageConstants.logo, fit: BoxFit.fill),
  //         // ),
  //         title:  Center(
  //           child: Text(
  //             "ASCOL AI",
  //             style: TextStyle(color: ColorConstants.white, fontSize: 20),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  // Widget buildAppBar(BuildContext context) {
  //   return Container(
  //     margin: const EdgeInsets.only(top: 20,left: 10,right: 10), // Margin to create space around the floating effect
  //     decoration: BoxDecoration(
  //       color: primaryColor,
  //       borderRadius: BorderRadius.circular(30), // Circular border radius
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.2), // Shadow color with opacity
  //           spreadRadius: 2, // Spread radius of the shadow
  //           blurRadius: 8, // Blur radius of the shadow
  //           offset: Offset(0, 4), // Offset of the shadow
  //         ),
  //       ],
  //     ),
  //     child: ListTile(
  //       // leading: ClipRRect(
  //       //   borderRadius: BorderRadius.circular(30),
  //       //   child: Image.asset(ImageConstants.logo, fit: BoxFit.fill),
  //       // ),
  //       title: Center(
  //         child: Text(
  //           "ASCOL AI",
  //           style: TextStyle(color: ColorConstants.white, fontSize: 20),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('ASCOL AI'),
      backgroundColor: ColorConstants.transparent,
    );
  }


  Widget buildBody(context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: model?.scrollController,
            itemCount: model?.messages.length,
            itemBuilder: (context, index) {
              ChatModel? chatModel;
              int lastIndex = (model?.messages.length ?? 0);
              if (model?.messages != null) {
                chatModel = model?.messages[index];
              }
              return chatModel != null
                  ? MessageContent(message: chatModel, index: index, lastIndex: lastIndex)
                  : Container();
            },
          ),
        ),
        InputFieldWidget(
          model: model,
        ),
        // if (model?.showEmoji == true)
        //   SizedBox(
        //     height: MediaQuery.of(context).size.height * .35,
        //     child: EmojiPickerWidget(
        //         controller:
        //         model?.messageController ?? TextEditingController()),
        //   ),
      ],
    );
  }
}
