import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatApi {
  final chatModel = dotenv.env["MODEL_NAME"] ?? "";

 Future<String> createCompletion(String message) async {
  
  /* This is for using chatcompletion
  // the system message that will be sent to the request.
  final systemMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "You are a helpful, respectful and honest assistant. If the user is feeling stressed be there to help them. Always answer as helpfully as possible, while being safe.  Your answers should not include any harmful, unethical, racist, sexist, toxic, dangerous, or illegal content. Please ensure that your responses are socially unbiased and positive in nature. If a question does not make any sense, or is not factually coherent, explain why instead of answering something not correct. If you don't know the answer to a question, please don't share false information.",
      ),
    ],
    role: OpenAIChatMessageRole.assistant,
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
  //  systemMessage,
    userMessage,
  ];
  */
  OpenAICompletionModel completion = await OpenAI.instance.completion.create(
  model: chatModel,
  prompt: message,
  maxTokens: 512,
  temperature: 0.3,
  stop: ["\n"]
);
final content = completion.choices[0].text;
if (content.isNotEmpty){
    return content;
}
else {
  return "Sorry, failed to get Chatbot message";
}

  }   



}