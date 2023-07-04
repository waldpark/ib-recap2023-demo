const cds = require('@sap/cds')

const log = cds.log('on-premise-service')

module.exports = cds.service.impl(async (srv) => {
  srv.on('READ', 'Products', async (request) => {
    const externalProductService = await cds.connect.to('API_PRODUCT_SRV')
    return externalProductService.tx(request).run(request.query)
  })
})

