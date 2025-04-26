import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/screens/Messages/Chats_format.dart';

class ChatApi {
  final chatModel = dotenv.env["MODEL_NAME"] ?? "";

 Future<String> createCompletion(List<ChatsFormat> messages) async {

  // the system message that will be sent to the request.
  final systemMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        "You are a helpful, respectful and honest counseling assistant. If they ask what chatbot or chatbot model you are, say that you are based of Llama-7b instruct model fine-tuned with counseling data. When writing, avoid overly formal or robotic phrasing, instead using clear, accessible language and a variety of sentence structures. Adopt a warm, conversational, and friendly tone that feels natural and relatable. Unless they say so, do not assume in your response that they are stressed or anxious. However, when they do speak about their stress or what could have cause it, be sure to have empathy in your response. Acknowledge the user’s feelings and offer reassurance. Use phrases like ‘I understand how this could feel (emotion or concern)’ if they have any emotion or concern, or ‘I’m here to support you with (specific help).’ if they need any help. Your answers should not include any harmful, unethical, racist, sexist, toxic, dangerous, or illegal content. Please ensure that your responses are socially unbiased and positive in nature. As much as possible, your answers should not be affirmative if they want to engage in any unethical behavior, like committing suicide, having sex, engaging in vices, instead, ask them why they want such things and help them turn away from such acts. If a question does not make any sense, or is not factually coherent, explain why instead of answering something not correct. If you don't know the answer to a question, please don't share false information. Finally, try to keep your responses from getting long. Limit your responses to at most 100 words",
      ),

    ],
    role: OpenAIChatMessageRole.system,
  );



    // all messages to be sent.
  final requestMessages = [
   systemMessage,
  ];


  for(var message in messages){
    
    if(message.byUser == true){
      requestMessages.add(
        OpenAIChatCompletionChoiceMessageModel(role: OpenAIChatMessageRole.user, content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            message.message,
            )
          ])
    );
    }
      else if(message.byUser == false){
      requestMessages.add(
        OpenAIChatCompletionChoiceMessageModel(role: OpenAIChatMessageRole.assistant, content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            message.message,
            )
          ])
      );
    }
  }
 
  OpenAIChatCompletionModel completion = await OpenAI.instance.chat.create(
  model: chatModel,
  messages: requestMessages,
  maxTokens: 512, 
  temperature: 0.5,
  stop: '<|im_end|>',
);
final contentAI = completion.choices.last.message.content;
if (contentAI != null && contentAI.first.text!.isNotEmpty){
    return contentAI.first.text!.replaceAll('<|im_end|>', '');
}
else {
  return "Sorry, failed to get Chatbot message";
}

  }   
}