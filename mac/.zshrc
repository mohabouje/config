# Simple alias to integrate with system calendar
alias calendar-today="icalBuddy eventsToday"
alias calendar-now="icalBuddy eventsNow"
alias calendar-tomorrow="icalBuddy eventsFrom:'tomorrow' to:'tomorrow'"
alias calendar-week="icalBuddy eventsToday+7"
calendar-in() {
    icalBuddy eventsWeek+"$1"
}
