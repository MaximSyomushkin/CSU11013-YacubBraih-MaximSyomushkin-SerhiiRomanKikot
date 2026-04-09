import java.util.Comparator;

/*
    Implemented by: Serhii-Roman Kikot
    Factory class providing various comparators to sort flights
*/
public class FlightsSortersFabric {
    private FlightsSortersFabric() {
    }

    // Returns a comparator to sort flights by distance
    public static final Comparator<Flight> byDistance(Boolean asc) {
        return (f1, f2) -> Boolean.TRUE.equals(asc) ? f1.distance - f2.distance : f2.distance - f1.distance;
    }

    // Returns a comparator to sort flights by flight date
    public static final Comparator<Flight> byFlightDate(Boolean asc) {
        return (f1, f2) -> Boolean.TRUE.equals(asc) ? f1.getFlightDate().compareTo(f2.getFlightDate())
                : f2.getFlightDate().compareTo(f1.getFlightDate());
    }

    // Returns a comparator to sort flights by carrier numeric ID
    public static final Comparator<Flight> byCarrierId(Boolean asc) {
        return (f1, f2) -> Boolean.TRUE.equals(asc) ? Integer.compare(f1.carrierNum, f2.carrierNum)
                : Integer.compare(f2.carrierNum, f1.carrierNum);
    }

    // Returns a comparator to sort flights by scheduled arrival time
    public static final Comparator<Flight> byCrsArrivalTime(Boolean asc) {
        return (f1, f2) -> Boolean.TRUE.equals(asc) ? Integer.compare(f1.crsArrivalTime, f2.crsArrivalTime)
                : Integer.compare(f2.crsArrivalTime, f1.crsArrivalTime);
    }

    // Returns a comparator to sort flights by scheduled departure time
    public static final Comparator<Flight> byCrsDepartureTime(Boolean asc) {
        return (f1, f2) -> Boolean.TRUE.equals(asc) ? Integer.compare(f1.crsDepartureTime, f2.crsDepartureTime)
                : Integer.compare(f2.crsDepartureTime, f1.crsDepartureTime);
    }

    // Returns a comparator to sort flights by delay
    public static final Comparator<Flight> byDelay(Boolean asc) {
        return (f1, f2) -> {
            int delay1 = f1.getDelay();
            int delay2 = f2.getDelay();
            return Boolean.TRUE.equals(asc) ? Integer.compare(delay1, delay2) : Integer.compare(delay2, delay1);
        };
    }

    // Returns a comparator to sort flights by cancelled flag
    public static final Comparator<Flight> byCancelled(Boolean asc) {
        return (f1, f2) -> Boolean.TRUE.equals(asc) ? Integer.compare(f1.cancelled, f2.cancelled)
                : Integer.compare(f2.cancelled, f1.cancelled);
    }

    // Returns a comparator to sort flights by diverted flag
    public static final Comparator<Flight> byDiverted(Boolean asc) {
        return (f1, f2) -> Boolean.TRUE.equals(asc) ? Integer.compare(f1.diverted, f2.diverted)
                : Integer.compare(f2.diverted, f1.diverted);
    }

    // Returns a comparator to sort flights by flight ID
    public static final Comparator<Flight> byId(Boolean asc) {
        return (f1, f2) -> Boolean.TRUE.equals(asc) ? Integer.compare(f1.id, f2.id)
                : Integer.compare(f2.id, f1.id);
    }
}
