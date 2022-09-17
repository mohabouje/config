# Simple alias for the weather app
alias weather="ansiweather"
function weather-in() {
    ansiweather -l "$1"
}
