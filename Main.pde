import java.util.List;
RepositoryFile repository;
DataService dataService;
DataQuery dataQuery;
QueryEngine queryEngine;
Screen initialScreen;
    ArrayList<String> headers = new ArrayList<String>();


void setup() {
    size(1400,800);
    repository = new RepositoryFile("flights2k.csv");
    dataService = new DataService(repository);
    queryEngine = new QueryEngine(dataService);
    dataQuery = new DataQuery();
    initialScreen = new Screen();
    TableWidget table = new TableWidget();
    ArrayList<ArrayList<String>> tableData = new ArrayList<ArrayList<String>>();
    List<Flight> flights = queryEngine.execute(dataQuery, 0, 0);

    initialScreen.addWidget(table);
    headers.add("Flight Date");
    headers.add("Carrier");
    headers.add("Carrier ID");
    headers.add("Origin");
    headers.add("Origin City");
    headers.add("Origin State");
    headers.add("Origin WAC");
    headers.add("Dest. Air");
    headers.add("Dest. City");
    headers.add("Dest. State");
    headers.add("Dest. WAC");
    headers.add("CRS Dep. Time");
    headers.add("Dep. Time");
    headers.add("CRS Arrival Time");
    headers.add("Arrival Time");
    headers.add("Cancelled");
    headers.add("Diverted");
    headers.add("Distance");

    for (Flight flight : flights) {
        ArrayList<String> row = new ArrayList<String>();
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
    table.setDisplayData(headers, tableData);
}

void draw() {
    background(255);
    initialScreen.drawScreen();
}
