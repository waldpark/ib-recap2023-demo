# Getting Started
## Steps to make the app run locally

In order to make this application run, you must first build it and deploy it to your SAP BTP cloud foundry space. Unfortunately, the SAP Enterprise Messaging service is not available anymore on the Trial account. You need a proper SAP BTP subscription or you need to sign up for a Pay-as-you-Go or CPEA account. You may run this application on a Trial account if you remove all the parts related to messagin (SAP Enterprise Messaging)

Open a new terminal and run

        npm install
        npm run build

to build the MTA project.
Then, login to your SAP BTP sub-account development space

        cf login

and deploy the MTA project

        npm run deploy

Afterwards, retrieve the VCAP_SERVICES credentials and create the **default-env.json** using the command

        npm run env:update-cf

However, for this command to work, you will need to install the command-line JSON parser [*jq*](https://jqlang.github.io/jq/download/) first.

Before starting the app in your local development environment, run

        cds deploy --to sqlite

Now, you should be able to run

        cds serve


## How to connect to the conectivity service on SAP BTP to access an OData Service of an On-Premise System

    cf enable-ssh ib-recap2023-demo-srv
    cf restart ib-recap2023-demo-srv
    cf ssh ib-recap2023-demo-srv -L 20003:connectivityproxy.internal.cf.eu10.hana.ondemand.com:20003

Then, inside the 'default-env.json', replace the line

        "onpremise_proxy_host": "connectivityproxy.internal.cf.eu10.hana.ondemand.com",

by the line

        "onpremise_proxy_host": "localhost",


