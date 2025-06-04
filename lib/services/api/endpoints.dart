class EndPoints {
  static const String paramIdentifier = "__param__";
  static const String model = "__model__";
  //chat-bot api
  static const Map chatBot = {
    "url":
        "chat-bot/chat-response/?message=$paramIdentifier&model=$paramIdentifier",
    "method": "GET",
    "login_required": true,
  };

  static const Map videoCall = {
    "url": "socket/video-call/?receiver_id=$paramIdentifier",
    "method": "GET",
    "login_required": true,
  };

  static const Map doctorList = {
    "url": "user/doctors/",
    "method": "GET",
    "login_required": true,
  };

  static const Map notificationList = {
    "url": "user/notifications/",
    "method": "GET",
    "login_required": true,
  };

  static const Map patientDetail = {
    "url": "user/patient_profile/",
    "method": "GET",
    "login_required": true,
  };

  static const Map submitPatientData = {
    "url": "user/patient_profile/",
    "method": "POST",
    "login_required": true,
  };

  static const Map taskList = {
    "url": "task/tasks/",
    "method": "GET",
    "login_required": true,
  };

  static const Map taskComplete = {
    "url": "task/tasks/$paramIdentifier/",
    "method": "POST",
    "login_required": true,
  };

  static const Map login = {"url": "auth/token/", "method": "POST"};

  static const Map appData = {"url": "app-data/", "method": "GET"};

  static const Map refreshToken = {
    "url": "auth/token/refresh/",
    "method": "POST",
  };

  static const Map registerProfile = {
    "url": "user/register/",
    "method": "POST",
  };

  static const Map profile = {
    "url": "user/profile/",
    "method": "GET",
    "login_required": true,
  };
}
