package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/influxdata/influxdb1-client/v2"
)

const (
	MyDB     = "collector"
	username = "collector"
	password = "WZ40AxiHYw"
)

func handler(w http.ResponseWriter, r *http.Request) {

	// Create a new HTTPClient
	c, err := client.NewHTTPClient(client.HTTPConfig{
		Addr:     "http://influxdb:8086",
		Username: username,
		Password: password,
	})
	if err != nil {
		log.Fatal(err)
	}
	defer c.Close()

	// Create a new point batch
	bp, err := client.NewBatchPoints(client.BatchPointsConfig{
		Database:  MyDB,
		Precision: "s",
	})
	if err != nil {
		log.Fatal(err)
	}

	// Create a point and add to batch
	tags := map[string]string{"cpu": "cpu-total"}
	fields := map[string]interface{}{
		"idle":   10.1,
		"system": 53.3,
		"user":   46.6,
	}

	pt, err := client.NewPoint("cpu_usage", tags, fields, time.Now())
	if err != nil {
		log.Fatal(err)
	}
	bp.AddPoint(pt)

	// Write the batch
	if err := c.Write(bp); err != nil {
		log.Fatal(err)
	}

	// Close client resources
	if err := c.Close(); err != nil {
		log.Fatal(err)
	}

	fmt.Fprintf(w, "Hello World!")
}

func main() {

	var PORT string

	if PORT = os.Getenv("PORT"); PORT == "" {
		PORT = "80"
	}

	http.HandleFunc("/", handler)

	log.Println("Starting Server")
	http.ListenAndServe(":"+PORT, nil)
}
