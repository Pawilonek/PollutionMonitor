package repo

import (
	"log"
	"time"

	"github.com/orourkedd/influxdb1-client/client"
)

type Mearsurement struct {
	Timestamp   time.Time `json:"timestamp"`
	Hummiditiy  float32   `json:"hummiditiy"`
	Temperature float32   `json:"temperature"`
}

var connection client.Client

// var bp client.BatchPoints

const (
	myDB     = "collector"
	username = "collector"
	password = "WZ40AxiHYw"
)

// Connect z
func Connect() error {

	log.Println("Connecting to database")

	var err error

	connection, err = client.NewHTTPClient(client.HTTPConfig{
		Addr:     "http://influxdb:8086",
		Username: username,
		Password: password,
	})

	if err != nil {
		return err
	}

	return nil
}

func Disconnect() {
	log.Println("Disconeting database")

	// if connection == nil {
	// 	return
	// }

	// Close client resources
	if err := connection.Close(); err != nil {
		log.Fatal(err)
	}

}

func Save(m Mearsurement) {
	log.Println("Saving", m)

	// Create a point and add to batch
	tags := map[string]string{"deviceId": "some-random-value"}
	fields := map[string]interface{}{
		"hummiditiy":  m.Hummiditiy,
		"temperature": m.Temperature,
	}

	// Create a new point batch
	bp, err := client.NewBatchPoints(client.BatchPointsConfig{
		Database:  myDB,
		Precision: "s",
	})

	if err != nil {
		log.Fatal(err)
	}

	// todo: Check if timestyamp is accualy good

	pt, err := client.NewPoint("sensors_data", tags, fields, m.Timestamp)
	if err != nil {
		log.Fatal(err)
	}
	bp.AddPoint(pt)

	// Write the batch
	if err := connection.Write(bp); err != nil {
		log.Fatal(err)
	}

}
