import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatApi {
  final chatModel = dotenv.env["MODEL_NAME"] ?? "";

 Future<String> createCompletion(String message) async {
  
  // the system message that will be sent to the request.
  final systemMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "You are a helpful, respectful and honest assistant. If the user is feeling stressed be there to help them. Always answer as helpfully as possible, while being safe.  Your answers should not include any harmful, unethical, racist, sexist, toxic, dangerous, or illegal content. Please ensure that your responses are socially unbiased and positive in nature. If a question does not make any sense, or is not factually coherent, explain why instead of answering something not correct. If you don't know the answer to a question, please don't share false information.",
      ),
    ],
    role: OpenAIChatMessageRole.system,
  );

    // the user message that will be sent to the request.
 final userMessage = OpenAIChatCompletionChoiceMessageModel(
   content: [
     OpenAIChatCompletionChoiceMessageContentItemModel.text(
       message,
     ),
   ],
   role: OpenAIChatMessageRole.user,
 );

    // all messages to be sent.
  final requestMessages = [
    systemMessage,
    userMessage,
  ];
 
  OpenAIChatCompletionModel completion = await OpenAI.instance.chat.create(
  model: chatModel,
  messages: requestMessages,
  maxTokens: 512,
  temperature: 0.5,
  stop: ["<|im_end|>"]
);
final contentAI = completion.choices.first.message.content;
if (contentAI != null && contentAI.first.text!.isNotEmpty){
  print(contentAI);
    return contentAI.first.text!;
}
else {
  return "Sorry, failed to get Chatbot message";
}

  }   



}