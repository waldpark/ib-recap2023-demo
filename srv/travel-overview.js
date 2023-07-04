const cds = require('@sap/cds')
const log = cds.log('travel-overview-service')

const { Travelers } = cds.entities('ib.recap2023.demo')

class TravelOverviewService extends cds.ApplicationService {

  async _getNumberOfTravelers() {
    const nTravelers = (await cds.run(SELECT.from(Travelers))).length
    log.info('Number of Travelers', nTravelers)
    return nTravelers
  }

  async init(){

    const messaging = await cds.connect.to('messaging')

    messaging.on('topic-object1/published', msg => {
      log.info('Consuming message from event topic-object1/published: ', msg)
    })

    this.on ('publishNumberOfTravelers', async () => {
      try {
        const numberOfTravelers = await this._getNumberOfTravelers()
        // Emit event to messaging service
        const messagingService = await cds.connect.to('messaging')

        const event = 'topic-object2/published'
        const result = await messagingService.emit({
          event,
          data: {
            time: new Date(),
            numberOfTravelers
          },
          headers: { 'X-Correlation-ID': cds.context.id }
        })
        log.log(`Used Protocol: httprest`)
        log.log(`Event ${event} sent - result:`, result)
      } catch (error) {
        log.error('emitEvent failed: ', error)
      }
    });

    return super.init()
  }
}

module.exports = { TravelOverviewService }
