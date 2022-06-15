/*
 * kafka consumers must run in the same vpc as the kafka deployment.
 * there is no (easy) way to test this locally. it may be possible to ssh
 * tunnel all the brokers an schema registry.
 */
const { Kafka, logLevel } = require('kafkajs')
const { SchemaRegistry } = require('@kafkajs/confluent-schema-registry')

// schema registry runs over http on port 8081 in dev, default https in our deployment
const registry = new SchemaRegistry({ host: 'https://schemas-v2021-01.ec.sandbox.openstax.org' })

const kafka = new Kafka({
  logLevel: logLevel.INFO,
  brokers: [
    // change to match environment
    `b-1.v2021-01-quasar.ignmgu.c3.kafka.us-east-2.amazonaws.com:9092`,
    `b-2.v2021-01-quasar.ignmgu.c3.kafka.us-east-2.amazonaws.com:9092`,
    `b-3.v2021-01-quasar.ignmgu.c3.kafka.us-east-2.amazonaws.com:9092`,
  ],
  clientId: 'example-consumer',
})

const topic = 'started_session'
const consumer = kafka.consumer({ groupId: 'test-group' })

const run = async () => {
  await consumer.connect()
  await consumer.subscribe({ topic, fromBeginning: false })
  await consumer.run({
    // eachBatch: async ({ batch }) => {
    //   console.log(batch)
    // },
    eachMessage: async ({ topic, partition, message }) => {

      // this is apparently not encoded, its just returning `null` for me
      const decodedKey = message.key; // await registry.decode(message.key)
      const decodedValue = await registry.decode(message.value)

      // random logging for message data
      const prefix = `${topic}[${partition} | ${message.offset}] / ${message.timestamp}`
      console.log(`- ${prefix} ${decodedKey}#${decodedValue}`)

      // avoid flooding console just to see it work
      process.exit(1);
    },
  })
}

run().catch(e => console.error(`[example/consumer] ${e.message}`, e))

const errorTypes = ['unhandledRejection', 'uncaughtException']
const signalTraps = ['SIGTERM', 'SIGINT', 'SIGUSR2']

errorTypes.forEach(type => {
  process.on(type, async e => {
    try {
      console.log(`process.on ${type}`)
      console.error(e)
      await consumer.disconnect()
      process.exit(0)
    } catch (_) {
      process.exit(1)
    }
  })
})

signalTraps.forEach(type => {
  process.once(type, async () => {
    try {
      await consumer.disconnect()
    } finally {
      process.kill(process.pid, type)
    }
  })
})
