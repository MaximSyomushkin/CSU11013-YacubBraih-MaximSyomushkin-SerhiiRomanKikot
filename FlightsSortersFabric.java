import java.util.Comparator;

public class FlightsSortersFabric {
    private FlightsSortersFabric() {
    }

    public static Comparator<Flight> byDelay(Boolean asc) {
        return (f1, f2) -> 0;
    }

    public static Comparator<Flight> byDistance(Boolean asc) {
        return (f1, f2) -> Boolean.TRUE.equals(asc) ? f1.distance - f2.distance : f2.distance - f1.distance;
    }

    public static Comparator<Flight> byDate(Boolean asc) {
        return (f1, f2) -> Boolean.TRUE.equals(asc) ? f1.getFlightDate().compareTo(f2.getFlightDate())
                : f2.getFlightDate().compareTo(f1.getFlightDate());
    }
}
