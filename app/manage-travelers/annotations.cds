using TravelOverviewService as service from '../../srv/travel-overview';

annotate service.Travelers with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : lastName,
        },
        {
            $Type : 'UI.DataField',
            Value : firstName,
        },
        {
            $Type : 'UI.DataField',
            Value : email,
        }
    ],

    UI.HeaderInfo : {
        TypeName: '{i18n>traveler}',
        TypeNamePlural: '{i18n>travelers}',
        Title: { Value: email },
        Description: { Value : { $edmJson: { $Apply: [ { Path: 'firstName' }, ' ', { Path: 'lastName' } ], $Function: 'odata.concat' } } }
    },

    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : lastName,
            },
            {
                $Type : 'UI.DataField',
                Value : firstName,
            },
            {
                $Type : 'UI.DataField',
                Value : email,
            },
        ]
    },

    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            Label: '{i18n>visitedCities}',
            $Type: 'UI.ReferenceFacet',
            ID : 'VisitedCitiesFacet',
            Target: 'visitedCities/@UI.LineItem'
        }
    ]
){
    nationality @(
        Common : {
            Text: {
                $value: nationality.name,
                ![@UI.TextArrangement] : #TextFirst
            }
        }
    );

    ID @UI.ExcludeFromNavigationContext : true;
    email @UI.ExcludeFromNavigationContext : true;
    firstName @UI.ExcludeFromNavigationContext : true;
    lastName @UI.ExcludeFromNavigationContext : true;
};

annotate service.VisitedCities with @(

    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>city}',
            Value : city_ID
        },
        {
            $Type : 'UI.DataFieldWithIntentBasedNavigation',
            Label : '{i18n>details}',
            Value : targetCityId,         // Cross-App-Outbound Navigation
            SemanticObject: 'WorldCities',
            Action: 'Maintain'
        }
    ],

    UI.FieldGroup #GeneratedGroup3 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>adminArea}',
                Value : city.adminArea
            },
        ],
    },

    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet3',
            Label : 'General',
            Target : '@UI.FieldGroup#GeneratedGroup3',
        }
    ]


){
    targetCityId @readonly;
    targetCityId @(
        UI.Hidden              : false,
        Common.Text            : city.name,
        Common.TextArrangement : #TextOnly
    );
    ID @UI.ExcludeFromNavigationContext : true;
    city @UI.ExcludeFromNavigationContext : true;
    traveler @UI.ExcludeFromNavigationContext : true;

    city @(
        Common.Text: city.name,
        Common.TextArrangement: #TextOnly,
        Common.ValueList : {
            Label: '{i18n>city}',
            CollectionPath: 'WorldCities',
            SearchSupported,
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: city_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        }
    );
};

annotate service.WorldCities with {
    adminArea @readonly;
}