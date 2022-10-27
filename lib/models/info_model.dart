
class TedaJson {
    TedaJson({
        this.tel,
        this.tashkilot,
        this.fio,
        this.qrkod,
    });

    String? tel;
    String? tashkilot;
    String? fio;
    String? qrkod;

    factory TedaJson.fromJson(Map<String, dynamic> json) => TedaJson(
        tel: json["tel"],
        tashkilot: json["tashkilot"],
        fio: json["fio"],
        qrkod: json["qrkod"],
    );
    
    // factory TedaJson.fromJson(Map<String, String> json) => TedaJson.fromJson(
    //   json.decode(json[""])
      
    // );

    Map<String, dynamic> toJson() => {
        "tel": tel,
        "tashkilot": tashkilot,
        "fio": fio,
        "qrkod": qrkod,
    };

}
