using { cuid, managed } from '@sap/cds/common';
namespace ib.recap2023.demo;

entity Countries : cuid, managed {
    code      : String(3) not null @title : '{i18n>code}';
    name      : String(64) @title : '{i18n>name}';
    continent : String(64) @title : '{i18n>continent}';
}

entity CityTypes: managed {
    key code : String;
    name     : String @title : 'City Type';
}

entity WorldCities : cuid, managed {
    code             : Integer;
    name             : String @title : '{i18n>name}';
    asciiName        : String;
    latitude         : Decimal;
    longitude        : Decimal;
    country          : Association to one Countries;
    adminArea        : String;
    capital          : String;
    population       : Integer @title : '{i18n>population}';
    partnerCountries : Composition of many Cities2Countries on partnerCountries.city = $self @title : '{i18n>partnerCountries}';
    cityType         : Association to one CityTypes @title : '{i18n>cityType}';
}

entity Cities2Countries : cuid, managed {
    city    : Association to one WorldCities;// on city.code = city_ID;
    country : Association to one Countries;// on country.code = country_ID;
}

@assert.unique : {
    travelersEmail: [email]
}
entity Travelers: cuid, managed {
    lastName      : String not null @title : '{i18n>lastName}';
    firstName     : String not null @title : '{i18n>firstName}';
    email         : String not null @title : '{i18n>email}';
    nationality   : Association to one Countries @title : '{i18n>nationalityCode}';
    visitedCities : Composition of many VisitedCities on visitedCities.traveler = $self @title: '{i18n>visitedCity}';
}

@assert.unique : {
    visitedCitiesCityCode: [city]
}
entity VisitedCities : cuid, managed {
    traveler : Association to one Travelers @title : '{i18n>traveler}';
    city     : Association to one WorldCities @title : '{i18n>country}';
}
