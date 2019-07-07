package main

import (
	"github.com/Pawilonek/PollutionMonitor/services/collector/controllers"
	"github.com/Pawilonek/PollutionMonitor/services/collector/repo"
	"log"
	"net/http"
	"os"

	"github.com/julienschmidt/httprouter"
)

func main() {

	var PORT string

	if PORT = os.Getenv("PORT"); PORT == "" {
		PORT = "80"
	}

	router := httprouter.New()
	router.POST("/measurements", controllers.Measurements)

	repo.Connect()
	defer repo.Disconnect()

	log.Println("Starting Server")
	http.ListenAndServe(":"+PORT, router)

}
