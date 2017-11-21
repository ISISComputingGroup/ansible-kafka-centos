#!/bin/bash

# Start the chopper
lewis chopper -p "epic: {prefix: 'SIM:'}"

# Publish on the forwarder config channel that we want this PV forwarded
kafkacat -b ${KAFKA_BROKER_NAME:=localhost}-t ${FORWARDER_CONFIG_TOPIC:=TEST_forwarderConfig} -P forwarder_config.json
