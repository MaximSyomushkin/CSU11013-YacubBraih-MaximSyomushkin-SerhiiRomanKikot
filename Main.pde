import java.util.List;

RepositoryFile repository;
DataService dataService;
DataQuery dataQuery;
QueryEngine queryEngine;
Screen initialScreen;
TableWidget tableWidget;
float scrollMultiplier = 1.0f;
ArrayList<String> headers = new ArrayList<String>();
PieChart pieChart;
PieChart top5PieChart;
    
ScrollableTable scrollableTable;
TextInput sortByAirline;
TextInput sortByDestination;
TextInput sortByOrigin;
Button applyButton;

HashMap<String, TextInput> focusedInput = new HashMap<>();
TextInputGroup textInputGroup;

void prepareTableData(List<Flight> flights) {
    ArrayList<ArrayList<String>> tableData = DataMapper.flightsToTableData(flights);
    scrollableTable.setDisplayData(headers, tableData);
}
void setup() {
    size(1400,800);
    repository = new RepositoryFile("flights2k.csv");
    dataService = new DataService(repository);
    queryEngine = new QueryEngine(dataService);
    dataQuery = new DataQuery();
    initialScreen = new Screen();
    tableWidget = new TableWidget();
    textInputGroup = new TextInputGroup(50,50,300, 300, color(220));
    
    List<Flight> flights = queryEngine.execute(dataQuery, 0, 0);

    scrollableTable = new ScrollableTable(0, 300, 1200, 500, color(200));
    initialScreen.addWidget(scrollableTable);

    // Input fields for sorting
    sortByAirline = new TextInput(50, 50, 200, 30, color(220), "Sort by Airline");
    sortByDestination = new TextInput(50, 120, 200, 30, color(220), "Sort by Destination");
    sortByOrigin = new TextInput(50, 180, 200, 30, color(220), "Sort by Origin");
    applyButton = new Button(50, 250, 100, 30, color(180), "Apply");
    sortByAirline.setFocused(true);

    textInputGroup.addTextInput(sortByAirline);
    textInputGroup.addTextInput(sortByDestination);
    textInputGroup.addTextInput(sortByOrigin);

    initialScreen.addWidget(applyButton);
    initialScreen.addWidget(textInputGroup);
    
    // Prepare pie chart data
    // HashMap<String, Float> top5PieData = new HashMap<String, Float>();
    // int count = 0;
    // for (Map.Entry<String, Float> entry : pieData.entrySet()) {
    //     if (count < 5) {
    //         top5PieData.put(entry.getKey(), entry.getValue());
    //         count++;
    //     } else {
    //         break;
    //     }
    // }
     // top5PieChart = new PieChart(1200, 50, 250, 250, color(200,100,100), top5PieData);
    // initialScreen.addWidget(top5PieChart);
    HashMap<String, Float> pieData = new HashMap<String, Float>();
    for (Flight flight : flights) {
        String carrier = flight.carrier;
        if (pieData.containsKey(carrier)) {
            pieData.put(carrier, pieData.get(carrier) + 1);
        } else {
            pieData.put(carrier, 1.0f);
        }
    }
    pieChart = new PieChart(800, 50, 250, 250, color(100,200,100), pieData);
   
    
    initialScreen.addWidget(pieChart);

    // Headers for table
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
    
    prepareTableData(flights);
}

void draw() {
    background(255);
    initialScreen.drawScreen();
    // pieChart.drawWidget();
    // scrollableTable.drawWidget();
}


void keyPressed() {
   initialScreen.handleKeyPressed(key, keyCode);
}
void mousePressed() {
    initialScreen.handleMousePressed(mouseX, mouseY);
    // if (!scrollableTable.scrollBar.firstMousePress) {
    //     scrollableTable.scrollBar.firstMousePress = true;
    // }
    //if (scrollableTable.isClicked(mouseX, mouseY)) {
    //    int headerIndex = scrollableTable.clickedOnHeaderIndex(mouseX, mouseY);
    //    if (headerIndex != -1) {
    //        println("Clicked on header: " + headers.get(headerIndex));
    //    }
    //}
    if (applyButton.isClicked(mouseX, mouseY)) {
        dataQuery.setFilter("Airline",FlightFiltersFabric.byAirline(sortByAirline.getText()));
        dataQuery.setFilter("Destination",FlightFiltersFabric.byDestination(sortByDestination.getText()));
        dataQuery.setFilter("Origin",FlightFiltersFabric.byOrigin(sortByOrigin.getText()));
        List<Flight> flights = queryEngine.execute(dataQuery, 0, 0);
        prepareTableData(flights);
    }
    if (sortByAirline.isClicked(mouseX, mouseY)) {
        sortByAirline.setFocused(true);
        sortByDestination.setFocused(false);
        sortByOrigin.setFocused(false);
    } else if (sortByDestination.isClicked(mouseX, mouseY)) {
        sortByAirline.setFocused(false);
        sortByDestination.setFocused(true);
        sortByOrigin.setFocused(false);
    } else if (sortByOrigin.isClicked(mouseX, mouseY)) {
        sortByAirline.setFocused(false);
        sortByDestination.setFocused(false);
        sortByOrigin.setFocused(true);
    } else {
        sortByAirline.setFocused(false);
        sortByDestination.setFocused(false);
        sortByOrigin.setFocused(false);
    }
}

void mouseReleased() {
    initialScreen.handleMouseReleased(mouseX, mouseY);
}
void mouseDragged() {
    initialScreen.handleMouseDragged(mouseX, mouseY);
}
void mouseWheel(MouseEvent event) {
    if (scrollableTable != null) {
        scrollableTable.handleMouseWheel(event.getCount());
    }
}
