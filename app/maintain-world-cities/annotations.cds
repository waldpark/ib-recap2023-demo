using WorldDataService as service from '../../srv/world-data';
annotate service.WorldCities with @(

    Common.SemanticKey : [ targetCityId ],

    UI.HeaderInfo : {
        TypeName : 'WorldCities',
        TypeNamePlural : 'WorldCities',
        Title :  {
            $Type : 'UI.DataField',
            Value: name
        },
        Description : {
            $Type : 'UI.DataField',
            Value: country.name
        }
    },

    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : name
        },
        {
            $Type : 'UI.DataField',
            Value : population
        },
        {
            $Type : 'UI.DataField',
            Value : cityType.name
        }
    ],

    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>latitude}',
                Value : latitude,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>longitude}',
                Value : longitude,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>country}',
                Value : country_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>adminArea}',
                Value : adminArea,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>capital}',
                Value : capital,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>population}',
                Value : population,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            Label: '{i18n>partnerCountries}',
            $Type: 'UI.ReferenceFacet',
            ID : 'Cities2CountriesFacet',
            Target: 'partnerCountries/@UI.LineItem'
        }
    ]
){
    ID @UI.Hidden;
    targetCityId @UI.Hidden @UI.HiddenFilter;
    code @UI.ExcludeFromNavigationContext : true;
    name @UI.ExcludeFromNavigationContext : true;
    latitude @readonly;
    longitude @readonly;
    adminArea @readonly;
    capital @readonly;
    country @readonly;
    country @(
        Common.Text: country.name,
        Common.TextArrangement: #TextOnly,
    );
};


annotate service.Cities2Countries with @(

    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>country}',
            Value : country_ID
        }

    ],

    UI.FieldGroup #GeneratedGroup2 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>country}',
                Value : country_ID
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet2',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup2',
        }
    ]

){

    country @(
        Common.Text: country.name,
        Common.TextArrangement: #TextOnly,
        Common.ValueList : {
            Label: '{i18n>country}',
            CollectionPath: 'Countries',
            SearchSupported,
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: country_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'code'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'continent'
                }
            ]
        }
    );
};

annotate service.Countries with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : code
        },
        {
            $Type : 'UI.DataField',
            Value : name
        },
        {
            $Type : 'UI.DataField',
            Value : continent
        }
    ],

);

