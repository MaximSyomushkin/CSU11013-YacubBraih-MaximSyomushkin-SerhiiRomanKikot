import java.util.ArrayList;
import java.util.List;

public class DataMapper {
    private DataMapper() {
    }

    static ArrayList<ArrayList<String>> flightsToTableData(List<Flight> flights) {
        ArrayList<ArrayList<String>> tableData = new ArrayList<>();
        for (int i = 0; i < flights.size(); i++) {
            Flight flight = flights.get(i);
            ArrayList<String> row = new ArrayList<>();
            row.add(String.valueOf(flight.id));
            row.add(flight.flightDate);
            row.add(flight.carrier);
            row.add(String.valueOf(flight.carrierNum));
            row.add(flight.origin);
            row.add(flight.originCity);
            row.add(flight.originState);
            row.add(String.valueOf(flight.originWAC));
            row.add(flight.destinationAir);
            row.add(flight.destinationCity);
            row.add(flight.destinationState);
            row.add(String.valueOf(flight.destinationWAC));
            row.add(String.valueOf(flight.crsDepartureTime));
            row.add(String.valueOf(flight.departureTime));
            row.add(String.valueOf(flight.crsArrivalTime));
            row.add(String.valueOf(flight.arrivalTime));
            row.add(String.valueOf(flight.cancelled));
            row.add(String.valueOf(flight.diverted));
            row.add(String.valueOf(flight.distance));
            tableData.add(row);
        }
        return tableData;
    }
}
