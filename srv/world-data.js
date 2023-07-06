const cds = require('@sap/cds')
const log = cds.log('world-data-service')

const { WorldCities } = cds.entities('ib.recap2023.demo')

class WorldDataService extends cds.ApplicationService {

  async _getNumberOfWorldCities() {
    const nWorldCities = (await cds.run(SELECT.from(WorldCities))).length
    log.info('Number of WorldCities', nWorldCities)
    return nWorldCities
  }

  async init(){

    // Sending messages via Channel 1
    this.on ('publishNumberOfWorldCities', async () => {
      try {
        const numberOfWorldCities = await this._getNumberOfWorldCities()
        // Emit event to messaging service
        const messagingService = await cds.connect.to('messaging')

        const event = 'topic-object1/published'
        const result = await messagingService.emit({
          event,
          data: {
            time: new Date(),
            numberOfWorldCities
          },
          headers: { 'X-Correlation-ID': cds.context.id }
        })
        log.log(`Used Protocol: amqp10ws`)
        log.log(`Event ${event} sent - result:`, result)
      } catch (error) {
        log.error('emitEvent failed: ', error)
      }
    });

    /**
     *
     * Handling Cross-App-Inbound-Navigation into the Object-Page of WorldCities
     *
     */

    this.before('READ', ['WorldCities'], (request) => {
      /**
       * $filter=targetCityId must be replaced by $filter=ID
       * in order to enter the correct Object Page
       */
      if (request?.query?.SELECT?.where?.length) {
        request.query.SELECT.where.forEach((each, index) => {
          if (each?.ref?.length) {
            request.query.SELECT.where[index].ref = each.ref.map(
              (whereItem) => ([
                'targetCityId'
              ].includes(whereItem) ? 'ID' : whereItem)
            )
          }
        })
      }
    })

    /**
     * This 'targetCityId' field is mereley a projection extension with initial value null in the 'word-data.cds'.
     * It must get the correct value from the 'ID' here.
     */
    // this.after('READ', 'WorldCities', (each) => {
    //   each.targetCityId = each.ID
    // })

    return super.init()
  }
}

module.exports = { WorldDataService }
