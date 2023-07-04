const cds = require('@sap/cds')
const cov2ap = require("@cap-js-community/odata-v2-adapter");

// Add OData V2 adapter to CAP application
cds.on("bootstrap", (app) => app.use(cov2ap()));

if (process.env.NODE_ENV !== 'production') {
  const { cds_launchpad_plugin } = require('cds-launchpad-plugin')
  // Enable Fiori launchpad plugin for local development
  cds.once('bootstrap', (app) => {
    const handler = new cds_launchpad_plugin()
    app.use(handler.setup())
  })
}

module.exports = cds.server


