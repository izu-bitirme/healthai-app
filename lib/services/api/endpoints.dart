class EndPoints {
  static const String paramIdentifier = "__param__";
  static const String model = "__model__";
  //chat-bot api
  static const Map chatBot = {
    "url": "chat-bot/chat-response/?message=${paramIdentifier}&model=${model} /",
    "method": "GET",
  };

  
  static const Map login = {
    "url": "token/",
    "method": "POST",
  };

  static const Map refreshToken = {
    "url": "token/refresh/",
    "method": "POST",
  };

  static const Map registerProfile = {
    "url": "profile/register/",
    "method": "POST",
  };

  
}