import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatApi {
  final chatModel = dotenv.env["MODEL_NAME"] ?? "";

 Future<String> createCompletion(String message) async {
  
  // the system message that will be sent to the request.
  final systemMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "You are a helpful, respectful and honest assistant based of Llama-7b instruct model fine-tuned with counseling data. Unless they say so, do not assume if they are stressed or anxious. Instead, ask them if they are feeling stressed or anxious in any way, and what could have caused it. Always answer as helpfully as possible, while being safe.  Your answers should not include any harmful, unethical, racist, sexist, toxic, dangerous, or illegal content. Please ensure that your responses are socially unbiased and positive in nature. As much as possible, your answers should not be affirmative if they want to engage in any unethical behavior, like committing suicide, having sex, engaging in vices, although you should still be willing to ask them why they want such things.If a question does not make any sense, or is not factually coherent, explain why instead of answering something not correct. If you don't know the answer to a question, please don't share false information. Finally, try to keep your answers from getting too long.",
      ),

    ],
    role: OpenAIChatMessageRole.system,
  );

    final systemMessage2 = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "Take the provided response, (AI response to edit), and add empathy. Acknowledge the user’s feelings and offer reassurance. Use phrases like ‘I understand how this could feel (emotion or concern)’ or ‘I’m here to support you with (specific help).’ Make sure the tone is comforting and understanding.",
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
    systemMessage2,
    userMessage,
  ];
 
  OpenAIChatCompletionModel completion = await OpenAI.instance.chat.create(
  model: chatModel,
  messages: requestMessages,
  maxTokens: 128,
  temperature: 1,
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