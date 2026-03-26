import java.util.List;
RepositoryFile repository;
DataService dataService;
DataQuery dataQuery;
QueryEngine queryEngine;
HScrollbar hs1;
Screen initialScreen;
TableWidget tableWidget;
float scrollMultiplier = 1.0f;
ArrayList<String> headers = new ArrayList<String>();
Button btn1, btn2;

void setup() {
    size(1400,800);
    repository = new RepositoryFile("flights2k.csv");
    dataService = new DataService(repository);
    queryEngine = new QueryEngine(dataService);
    dataQuery = new DataQuery();
    initialScreen = new Screen();
    tableWidget = new TableWidget();
    ArrayList<ArrayList<String>> tableData = new ArrayList<ArrayList<String>>();
    List<Flight> flights = queryEngine.execute(dataQuery, 0, 0);
    

    initialScreen.addWidget(tableWidget);
    headers.add("ID");
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

    for (int i = 0; i < flights.size(); i++) {
        Flight flight = flights.get(i);
        ArrayList<String> row = new ArrayList<String>();
        row.add(String.valueOf(i + 1));
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
    tableWidget.setDisplayData(headers, tableData);
    hs1 = new HScrollbar(0, height-8, width, 16, 2);
    initialScreen.addWidget(hs1);
    if (tableWidget.h > height) {
        scrollMultiplier = (float) (tableWidget.h / width);
    }
    tableWidget.y += 50;

    // button setup
    btn1 = new Button(200, 150, 200, 50, "Table");
    btn2 = new Button(200, 250, 200, 50, "Graphs");

    
}

void draw() {
    background(255);
    initialScreen.drawScreen();
    
    
    hs1.update();
    hs1.drawWidget();

    if (hs1.firstMousePress) {
      hs1.firstMousePress = false;
    }

   if (gameState == 0) {
    drawMenu();
  } else if (gameState == 1) {
    textSize(10);
    tableWidget.drawWidget(0, -hs1.spos * scrollMultiplier);
  } else if (gameState == 2) {
    drawSceneB();
  }
}
void mousePressed() {
    if (!hs1.firstMousePress) {
        hs1.firstMousePress = true;
    }
    if (gameState == 0) {
    if (btn1.isClicked()) {
      println("Loading Tables...");
      // 
      gameState = 1;
    }
    if (btn2.isClicked()) {
      println("Loading Graphs...");
      // 
      gameState = 2;
}
    }
}