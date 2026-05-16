package handlers

import (
	"fmt"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/trainwithshubham/skillpulse/database"
	"github.com/trainwithshubham/skillpulse/models"
)

func GetDashboard(c *gin.Context) {
	var dash models.Dashboard

	database.DB.QueryRow("SELECT COUNT(*) FROM skills").Scan(&dash.TotalSkills)
	database.DB.QueryRow("SELECT COALESCE(SUM(hours), 0) FROM learning_logs").Scan(&dash.TotalHours)
	database.DB.QueryRow("SELECT COUNT(*) FROM learning_logs").Scan(&dash.TotalLogs)

	err := database.DB.QueryRow(`
		SELECT s.name FROM skills s
		LEFT JOIN learning_logs l ON s.id = l.skill_id
		GROUP BY s.id, s.name
		ORDER BY COALESCE(SUM(l.hours), 0) DESC
		LIMIT 1
	`).Scan(&dash.TopSkill)
	if err != nil {
		dash.TopSkill = "N/A"
	}

	c.JSON(http.StatusOK, dash)
}

func HealthCheck(c *gin.Context) {
	err := database.DB.Ping()
	if err != nil {
		c.JSON(http.StatusServiceUnavailable, gin.H{"status": "unhealthy", "error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{"status": "healthy"})
}

func Metrics(c *gin.Context) {
	var dash models.Dashboard

	database.DB.QueryRow("SELECT COUNT(*) FROM skills").Scan(&dash.TotalSkills)
	database.DB.QueryRow("SELECT COALESCE(SUM(hours), 0) FROM learning_logs").Scan(&dash.TotalHours)
	database.DB.QueryRow("SELECT COUNT(*) FROM learning_logs").Scan(&dash.TotalLogs)

	metrics := []string{
		"# HELP skillpulse_skills_total Total skills tracked.",
		"# TYPE skillpulse_skills_total gauge",
		"skillpulse_skills_total " + fmt.Sprintf("%d", dash.TotalSkills),
		"# HELP skillpulse_learning_hours_total Total learning hours logged.",
		"# TYPE skillpulse_learning_hours_total gauge",
		"skillpulse_learning_hours_total " + fmt.Sprintf("%g", dash.TotalHours),
		"# HELP skillpulse_learning_logs_total Total learning log entries.",
		"# TYPE skillpulse_learning_logs_total gauge",
		"skillpulse_learning_logs_total " + fmt.Sprintf("%d", dash.TotalLogs),
	}

	c.Data(http.StatusOK, "text/plain; version=0.0.4", []byte(strings.Join(metrics, "\n")+"\n"))
}
