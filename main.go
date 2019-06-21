package main

import "github.com/confluentinc/confluent-kafka-go/kafka"

func main() {
	// do nothing example just to get librdkafka to link

	consumer, err := kafka.NewConsumer(&kafka.ConfigMap{
		"bootstrap.servers": "",
		"group.id":          "",
		"auto.offset.reset": "earliest"})

	if err != nil {
		panic(err)
	}

	consumer.Close()
}