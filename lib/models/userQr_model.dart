// To parse this JSON data, do
//
//     final userQr = userQrFromJson(jsonString);

import 'dart:convert';

class UserQr {
    UserQr({
        this.message,
        this.success,
        this.data,
    });

    String? message;
    bool? success;
    Data? data;

    factory UserQr.fromRawJson(String str) => UserQr.fromJson(json.decode(str));

  

    factory UserQr.fromJson(Map<String, dynamic> json) => UserQr(
        message: json["message"],
        success: json["success"],
        data: Data.fromJson(json["data"]),
    );

  
}

class Data {
    Data({
        this.id,
        this.username,
        this.fullName,
        this.phone,
        this.email,
        this.passportNumber,
        this.address,
        this.count,
        this.brithDate,
        this.registeredTime,
        this.statusList,
        this.active,
        this.role,
        this.resident,
        this.know,
        this.company,
        this.workType,
        this.employee,
        this.botRegisteredTime,
        this.siteRegisteredTime,
    });

    int? id;
    String? username;
    String? fullName;
    String? phone;
    String? email;
    dynamic? passportNumber;
    Address? address;
    int? count;
    dynamic? brithDate;
    DateTime? registeredTime;
    List<dynamic>? statusList;
    bool? active;
    dynamic? role;
    bool? resident;
    String? know;
    String? company;
    String? workType;
    String? employee;
    dynamic? botRegisteredTime;
    dynamic? siteRegisteredTime;

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        username: json["username"],
        fullName: json["fullName"],
        phone: json["phone"],
        email: json["email"],
        passportNumber: json["passportNumber"],
        address: Address.fromJson(json["address"]),
        count: json["count"],
        brithDate: json["brithDate"],
        registeredTime: DateTime.parse(json["registeredTime"]),
        statusList: List<dynamic>.from(json["statusList"].map((x) => x)),
        active: json["active"],
        role: json["role"],
        resident: json["resident"],
        know: json["know"],
        company: json["company"],
        workType: json["workType"],
        employee: json["employee"],
        botRegisteredTime: json["botRegisteredTime"],
        siteRegisteredTime: json["siteRegisteredTime"],
    );

   
}

class Address {
    Address({
        this.id,
        this.district,
        this.country,
        this.region,
        this.streetHome,
        this.latitude,
        this.longitude,
    });

    int? id;
    String? district;
    Country? country;
    Region? region;
    String? streetHome;
    double? latitude;
    double? longitude;

    factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));



    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        district: json["district"],
        country: Country.fromJson(json["country"]),
        region: Region.fromJson(json["region"]),
        streetHome: json["streetHome"],
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

   
}

class Country {
    Country({
        this.id,
        this.name,
        this.shortName,
    });

    int? id;
    String? name;
    String? shortName;

    factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        shortName: json["shortName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "shortName": shortName,
    };
}

class Region {
    Region({
        this.id,
        this.name,
        this.description,
        this.country,
    });

    int? id;
    String? name;
    String? description;
    Country? country;

    factory Region.fromRawJson(String str) => Region.fromJson(json.decode(str));

    factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        country: Country.fromJson(json["country"]),
    );


}
