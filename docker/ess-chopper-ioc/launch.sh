#!/bin/bash

KAFKA_BROKER_NAME=${KAFKA_BROKER_NAME:=localhost}

# Set up environment (important EPICS env variables)
. /etc/profile

# Wait for Kafka broker to be up
kafkacat -b kafka -L
OUT=$?
i="0"
while [ $OUT -ne 0 -a  $i -ne 5  ]; do
   echo "Waiting for Kafka to be ready"
   kafkacat -b ${KAFKA_BROKER_NAME} -L
   OUT=$?
   let i=$i+1
   echo $i
done
if [ $i -eq 5 ]
then
   echo "Kafka broker not accessible at ESS Chopper Sim launch"
   exit 1
fi

# Publish on the forwarder config channel that we want the speed and phase PVs forwarded
echo "{\"cmd\":\"add\",\"streams\":[{\"channel\":\"SIM:SIM:Spd-RB\",\"channel_provider_type\":\"ca\",\"converter\":{\"schema\":\"f142\",\"topic\":\"${FORWARDER_OUTPUT_TOPIC}\"}},"\
"{\"channel\":\"SIM:SIM:Phs-RB\",\"channel_provider_type\":\"ca\",\"converter\":{\"schema\":\"f142\",\"topic\":\"${FORWARDER_OUTPUT_TOPIC}\"}}]}"|\
kafkacat -P -b ${KAFKA_BROKER_NAME} -t ${FORWARDER_CONFIG_TOPIC}

# Start the chopper
lewis chopper -p "epics: {prefix: '${CHANNEL_PREFIX:=SIM}:'}"
