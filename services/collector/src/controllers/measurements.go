package controllers

import (
	"encoding/json"
	"net/http"

	"github.com/julienschmidt/httprouter"

	"github.com/Pawilonek/PollutionMonitor/services/collector/repo"
)

func Measurements(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {

	if r.Body == nil {
		http.Error(w, "Please send a request body", 400)
		return
	}

	var m repo.Mearsurement

	err := json.NewDecoder(r.Body).Decode(&m)

	if err != nil {
		http.Error(w, err.Error(), 400)
		return
	}

	repo.Save(m)

	w.WriteHeader(http.StatusCreated)
}
