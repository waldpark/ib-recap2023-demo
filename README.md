# Getting Started

Welcome to your new project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`README.md` | this getting started guide


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

