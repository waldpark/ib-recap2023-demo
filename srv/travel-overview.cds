
using { ib.recap2023.demo as db } from '../db/schema';

@(path: '/travel-overview')
service TravelOverviewService {

    @readonly entity Countries as projection on db.Countries;
    @odata.draft.enabled
    entity Travelers as projection on db.Travelers;
    entity VisitedCities as projection on db.VisitedCities {
        *,
        city.ID as targetCityId  // Cross-App-Outbound Navigation
    };

    entity CityTypes as projection on db.CityTypes;
    entity WorldCities as projection on db.WorldCities;

    function publishNumberOfTravelers() returns Integer;
}
