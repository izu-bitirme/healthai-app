class EndPoints {
  static const String paramIdentifier = "__param__";
  static const String model = "__model__";
  //chat-bot api
  static const Map chatBot = {
    "url": "chat-bot/chat-response/?message=${paramIdentifier}&model=${model} /",
    "method": "GET",
  };

  
// auth api
  static const Map login = {
    "url": "token/",
    // "login_required": false,
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