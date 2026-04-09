import java.time.LocalDateTime;
import java.util.function.Predicate;
/*
    Implemented by: Serhii-Roman Kikot
    Factory class providing various predicates to filter flights
*/
class FlightFiltersFabric {
    private FlightFiltersFabric() {
    }
    // Returns a predicate to filter flights by a specific origin or destination airport
    public static Predicate<Flight> byAirport(String airportName) {
        return flight -> flight.origin.equals(airportName) || flight.destinationAir.equals(airportName);
    }
    // Returns a predicate to filter flights within a specific date and time range
    public static Predicate<Flight> byDateRange(LocalDateTime start, LocalDateTime end) {
        return flight -> flight.getFlightDate().compareTo(start) >= 0 && flight.getFlightDate().compareTo(end) <= 0;
    }
    // Returns a predicate to filter flights by airline carrier name (case-insensitive prefix match)
    public static Predicate<Flight> byAirline(String airlineName) {
        return flight -> flight.carrier.toLowerCase().startsWith(airlineName.toLowerCase());
    }
    // Returns a predicate to filter flights by origin city (case-insensitive prefix match)
    public static Predicate<Flight> byOriginCity(String origin) {
        return flight -> flight.originCity.toLowerCase().startsWith(origin.toLowerCase());
    }
    // Returns a predicate to filter flights by destination city (case-insensitive prefix match)
    public static Predicate<Flight> byDestinationCity(String destination) {
        return flight -> flight.destinationCity.toLowerCase().startsWith(destination.toLowerCase());
    }
    // Returns a predicate to filter only cancelled flights
    public static Predicate<Flight> byCancelled() {
        return flight -> flight.cancelled == 1;
    }

}
