#!/bin/bash

# Start the chopper
lewis chopper -p "epic: {prefix: 'SIM:'}"

# Publish on the forwarder config channel that we want the speed and phase PVs forwarded
echo "{\"cmd\":\"add\",\"streams\":[{\"channel\":\"SIM:SIM:Spd-RB\",\"channel_provider_type\":\"ca\",\"converter\":{\"schema\":\"f142\",\"topic\":\"${FORWARDER_OUTPUT_TOPIC}\"}},"\
"{\"channel\":\"SIM:SIM:Phs-RB\",\"channel_provider_type\":\"ca\",\"converter\":{\"schema\":\"f142\",\"topic\":\"${FORWARDER_OUTPUT_TOPIC}\"}}]}"|\
kafkacat -P -b ${KAFKA_BROKER_NAME:=localhost}-t ${FORWARDER_CONFIG_TOPIC}

# Move the chopper to a specified speed and phase
caput SIM:CmdS init
caput SIM:Spd 100.0
caput SIM:Phs 23.0
caput SIM:CmdS start
