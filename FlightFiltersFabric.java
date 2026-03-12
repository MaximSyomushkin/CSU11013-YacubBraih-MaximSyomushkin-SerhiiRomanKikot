import java.time.LocalDateTime;
import java.util.function.Predicate;

class FlightFiltersFabric {
    private FlightFiltersFabric() {
    }

    public static Predicate<Flight> byAirport(String airportName) {
        return flight -> flight.origin.equals(airportName) || flight.destinationAir.equals(airportName);
    }

    public static Predicate<Flight> byDateRange(LocalDateTime start, LocalDateTime end) {
        return flight -> flight.getFlightDate().compareTo(start) >= 0 && flight.getFlightDate().compareTo(end) <= 0;
    }

    public static Predicate<Flight> byAirline(String airlineName) {
        return flight -> flight.carrier.equals(airlineName);
    }
}
