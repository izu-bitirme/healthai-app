class Errors {
  static const Map data = {

      "200": {
        "title": "Başarılı",
        "message": "İşlem başarıyla tamamlandı."
      },
      "400": {
        "title": "Hatalı İstek",
        "message": "Geçersiz istek, lütfen girdilerinizi kontrol edin."
      },
      "401": {
        "title": "Yetkisiz Erişim",
        "message": "Bu işlemi gerçekleştirmek için yetkiniz yok."
      },
      "403": {
        "title": "Erişim Engellendi",
        "message": "Bu içeriğe erişim izniniz yok."
      },
      "404": {
        "title": "Bulunamadı",
        "message": "Aradığınız içerik bulunamadı, lütfen daha sonra tekrar deneyin."
      },
      "500": {
        "title": "Sunucu Hatası",
        "message": "Sunucu hatası nedeniyle işlem gerçekleştirilemedi."
      }


  };

  static getError(String code) {
    if (data.containsKey(code)) {
      return data[code];
    }
    return {"title": "", "message": ""};
  }
}