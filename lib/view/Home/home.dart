import 'package:ai_chat_bot/config/app_colors.dart';
import 'package:ai_chat_bot/core/base_state/base_state.dart';
import 'package:ai_chat_bot/core/error/failure.dart';
import 'package:ai_chat_bot/core/local_storage/app_prefrences.dart';
import 'package:ai_chat_bot/extension/app_extenstion.dart';
import 'package:ai_chat_bot/models/chat_data.dart';
import 'package:ai_chat_bot/view/Home/providers/chat_response_notifier.dart';
import 'package:ai_chat_bot/view/Home/providers/firebase_notifier.dart';
import 'package:ai_chat_bot/view/authentication/sign_in.dart';
import 'package:ai_chat_bot/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/Message.dart';
import '../../widgets/text_typing_animation.dart';

class HomePage extends ConsumerStatefulWidget {
  final String email;
  const HomePage({super.key, required this.email});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> implements ChatResponseI {
  final TextEditingController _controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  late var _fireBaseState;
  late var _chatResponseState;
  late var _isTyping;

  final isTypingProvider = StateProvider((ref) => false);

  @override
  void initState() {
    Future.microtask(() {
      ref.read(fireBaseProvider.notifier).getChatDataFromFireBase(widget.email);
    });

    ref.read(chatResponseProvider.notifier).chatResponseI = this;

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    callAllProviders();
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                AppPrefrences().clear();
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInPage(),
                    ));
              },
              child: Text(
                'Log Out',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ))
        ],
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
          child: _fireBaseState is LoadingState
              ? _loadingWidget()
              : _buildContent()),
    );
  }

  Widget _loadingWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        15.vPad,
        const Text(
          "Please wait while we fetching your data...",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        )
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Expanded(
            child: _fireBaseState is SuccessState<List<ChatingMessage>> &&
                    (_fireBaseState.data?.isEmpty ?? false)
                ? _details()
                : _chatList()),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: _sendMessageBtn()),
      ],
    );
  }

  Widget _chatList() {
    return ListView.builder(
        controller: scrollController,
        itemCount: _fireBaseState.data.length,
        itemBuilder: (BuildContext context, int index) {
          ChatingMessage message = _fireBaseState.data[index];
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(25, 10, 0, 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: const BoxDecoration(
                          color: color10A37F,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('user_chat'.toPng, height: 23),
                          8.hPad,
                          Flexible(
                            child: Text(
                              message.user ?? '',
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: _fireBaseState.data.length - 1 == index && _isTyping
                        ? _aiChatMessage(message.ai ?? '', index)
                        : TextTypingAnimation(
                            text: message.ai ?? '',
                            isAutoTypingRequired: false,
                          ),
                  )
                ],
              )
            ],
          );
        });
  }

  Widget _chatModelsDropDown(var chatModelsState) {
    return chatModelsState is LoadingState
        ? const Center(child: CircularProgressIndicator())
        : chatModelsState is SuccessState
            ? Center(
                child: Text(chatModelsState.toString(),
                    style: const TextStyle(color: Colors.red)),
              )
            : chatModelsState is ErrorState<Failure>
                ? Text(
                    chatModelsState.data?.msg ?? "",
                    style: const TextStyle(color: Colors.red),
                  )
                : const SizedBox.shrink();
  }

  Widget _aiChatMessage(String message, int index) {
    return _chatResponseState is LoadingState
        ? const LoadingIndicator()
        : _chatResponseState is SuccessState<ChatData>
            ? TextTypingAnimation(
                text: message,
                onCompleteTyping: () {
                  ref.read(isTypingProvider.notifier).state = false;
                },
                onTyping: () {
                  scrollToBottom();
                })
            : _chatResponseState is ErrorState<Failure>
                ? const Text("Some Thing Went Wrong!",
                    style: TextStyle(color: Colors.red))
                : const SizedBox.shrink();
  }

  Widget _sendMessageBtn() {
    return TextFormField(
      controller: _controller,
      onChanged: (value) {},
      decoration: InputDecoration(
          hintText: "Ask something",
          suffixIcon: GestureDetector(
            onTap: () {
              ref.read(isTypingProvider.notifier).state = true;
              FocusManager.instance.primaryFocus?.unfocus();
              ref.read(chatResponseProvider.notifier).getChatResponse(
                  ChatResponseParams(content: _controller.text));
              ref.read(fireBaseProvider.notifier).add(_controller.text);

              _controller.clear();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SvgPicture.asset(
                'message-send'.toSvg,
              ),
            ),
          )),
    );
  }

  Widget _details() {
    return Container(
      alignment: Alignment.center,
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        shrinkWrap: true,
        children: [
          Image.asset('chatbot'.toPng, height: 100),
          Text(
            "Chat Bot",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
          25.vPad,
          Text(
            "I'm here to help you with whatever you need, from answering questions to providing recommendations. Let's chat!",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          20.vPad,
          Text(
            "Example: Explain Quantum computing in simple terms",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  @override
  void onSuccess({required ChatData chatData}) {
    ref
        .read(fireBaseProvider.notifier)
        .storeDataToFireBase(chatData.choices?.first.message?.content ?? '');
  }

  void scrollToBottom() {
    scrollController.animateTo(
        scrollController.position.maxScrollExtent +
            MediaQuery.of(context).size.width * 0.7,
        duration: const Duration(milliseconds: 100),
        curve: Curves.ease);
  }

  void callAllProviders() {
    _chatResponseState = ref.watch(chatResponseProvider);
    _fireBaseState = ref.watch(fireBaseProvider);
    _isTyping = ref.watch(isTypingProvider);
    providerListen();
  }

  void providerListen() {
    ref.listen(fireBaseProvider, (previous, next) {
      if (next is SuccessState<List<ChatingMessage>>) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollToBottom();
          }
        });
      }
    });
  }
}
