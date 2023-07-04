
using { ib.recap2023.demo as db } from '../db/schema';

@(path: '/world-data')
service WorldDataService {

    @readonly entity Countries as projection on db.Countries;

    entity CityTypes as projection on db.CityTypes;
    @odata.draft.enabled
    entity WorldCities as projection on db.WorldCities {
        *,
        cityType.name as cityTypeName : String
    };
    extend projection WorldCities with {
        null as targetCityId : UUID // annotated as a SemanticKey, used for navigation from another app to one specific WorldCity
    }

    entity Cities2Countries as projection on db.Cities2Countries;

    function publishNumberOfWorldCities() returns Integer;
}




