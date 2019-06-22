package main

import (
	"app/controllers"
	"app/repo"
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
