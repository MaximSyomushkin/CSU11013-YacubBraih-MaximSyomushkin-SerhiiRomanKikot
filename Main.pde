import java.util.List;
import java.util.HashMap;
import java.util.Map;
import java.util.Comparator;
import java.util.function.Function;
import processing.sound.*;

RepositoryFile repository;
DataService dataService;
DataQuery dataQuery;
QueryEngine queryEngine;
SoundFile clickSound;
SoundFile loadSound;
SoundFile transitionSound;

Screen tableScreen, graphScreen, menuScreen;

PieChart pieChart, cancelledPieChart, top5PieChart;
    
ScrollableTable scrollableTable;
TextInput sortByAirline, sortByDestination, sortByOrigin;
Button btn1, btn2, quitButton, applyButton, backButton;

HashMap<String, TextInput> focusedInput = new HashMap<>();
TextInputGroup textInputGroup;

int gameState = 0; // 0 = Menu, 1 = Table , 2 = Graph

ArrayList<String> headers = new ArrayList<>();

HashMap<String, Function<Boolean, Comparator<Flight>>> sorters;
HashMap<String, Boolean> sortOrders;
HashMap<String, String> carrierImages;
Select select;
PImage airlineLogo;
String mostPopularCarrier;

void prepareTableData(List<Flight> flights) {
    ArrayList<ArrayList<String>> tableData = DataMapper.flightsToTableData(flights);
    scrollableTable.setDisplayData(headers, tableData);
}
void setup() {
    size(1400,800);

    clickSound = new SoundFile(this, "universfield-computer-mouse-click-352734.mp3");
    loadSound = new SoundFile(this, "ElevenLabs_Smooth_ascending_tones,_process_start.mp3");
    transitionSound = new SoundFile(this, "oxidvideos-transition-sfx-2-409073.mp3");


    tableScreen = new Screen();
    graphScreen = new Screen();
    menuScreen = new Screen();

    repository = new RepositoryFile("flights10k.csv");
    dataService = new DataService(repository);
    queryEngine = new QueryEngine(dataService);
    dataQuery = new DataQuery();
    textInputGroup = new TextInputGroup(200,50,300, 300, color(220));
    
    List<Flight> flights = queryEngine.execute(dataQuery, 0, 0);
    

    scrollableTable = new ScrollableTable(100, 300, 1200, 500, color(200));
    tableScreen.addWidget(scrollableTable);

    // Input fields for sorting
    sortByAirline = new TextInput(200, 50, 200, 30, color(220), "Sort by Carrier");
    sortByDestination = new TextInput(200, 120, 200, 30, color(220), "Sort by Destination City");
    sortByOrigin = new TextInput(200, 180, 200, 30, color(220), "Sort by Origin City");

    

    backButton = new Button(50, 50, 100, 30, color(180), "Back");
    applyButton = new Button(200, 250, 100, 30, color(180), "Apply");

    select = new Select(200, 50, 200, 30, color(220), "Carrier");
    
    sortByAirline.setFocused(true);

    textInputGroup.addTextInput(sortByAirline);
    textInputGroup.addTextInput(sortByDestination);
    textInputGroup.addTextInput(sortByOrigin);

    tableScreen.addWidget(applyButton);
    tableScreen.addWidget(backButton);
    tableScreen.addWidget(textInputGroup);
    
    

    HashMap<String, Float> pieData = new HashMap<String, Float>();
    HashMap<String, Float> cancelledPieData = new HashMap<String, Float>();
    carrierImages = new HashMap<String, String>();
    carrierImages.put("AA", "american_airlines.png");
    carrierImages.put("DL", "delta_airlines.png");
    carrierImages.put("UA", "united_airlines.png");
    carrierImages.put("WN", "southwest_airlines.png");
    carrierImages.put("AS", "alaska_airlines.png");
    carrierImages.put("F9", "frontier_airlines.png");
    carrierImages.put("HA", "hawaiian_airlines.png");
    carrierImages.put("NK", "spirit_airlines.png");
    carrierImages.put("G4", "allegiant_airlines.png");

    HashMap<String, Float> top5PieData = new HashMap<String, Float>();
    int count = 0;
    for (Flight flight : flights) {
        String carrier = flight.carrier;
        if (top5PieData.containsKey(carrier)) {
            top5PieData.put(carrier, top5PieData.get(carrier) + 1);
        } else {
            if (count < 5) {
                top5PieData.put(carrier, 1.0f);
                count++;
            }
        }
    }
    top5PieChart = new PieChart(800, 420, 250, 250, color(200,100,100), top5PieData, "Top 5 Carriers");
    
    graphScreen.addWidget(top5PieChart);

    for (Flight flight : flights) {
        String carrier = flight.carrier;
        if (pieData.containsKey(carrier)) {
            pieData.put(carrier, pieData.get(carrier) + 1);
        } else {
            pieData.put(carrier, 1.0f);
        }
    }
    mostPopularCarrier = "";
    float maxFlights = 0;
    for (String carrier : pieData.keySet()) {
        if (pieData.get(carrier) > maxFlights) {
            maxFlights = pieData.get(carrier);
            mostPopularCarrier = carrier;
        }
    }
    airlineLogo = loadImage(String.format("./data/%s", carrierImages.get(mostPopularCarrier)));

    pieChart = new PieChart(100, 420, 250, 250, color(100,200,100), pieData, "All Flights by Carrier");
    dataQuery.setFilter("cancelled", FlightFiltersFabric.byCancelled());
    List<Flight> cancelledFlights = queryEngine.execute(dataQuery, 0, 0);
    for (Flight flight : cancelledFlights) {
        String carrier = flight.carrier;
        if (cancelledPieData.containsKey(carrier)) {
            cancelledPieData.put(carrier, cancelledPieData.get(carrier) + 1);
        } else {
            cancelledPieData.put(carrier, 1.0f);
        }
    }
    cancelledPieChart = new PieChart(400, 120, 250, 250, color(200,100,100), cancelledPieData, "Cancelled Flights");
   
    
    graphScreen.addWidget(pieChart);
    graphScreen.addWidget(cancelledPieChart);
    graphScreen.addWidget(backButton);

    // Headers for table
    headers.add("ID(↓)"); // 0
    headers.add("Flight Date(↓)"); // 1
    headers.add("Carrier"); // 2
    headers.add("Carrier ID(↓)"); // 3
    headers.add("Origin"); // 4
    headers.add("Origin City"); // 5
    headers.add("Origin State"); // 6
    headers.add("Origin WAC"); // 7
    headers.add("Dest. Air"); // 8
    headers.add("Dest. City"); // 9
    headers.add("Dest. State"); // 10
    headers.add("Dest. WAC"); // 11
    headers.add("CRS Dep. Time(↓)"); // 12 
    headers.add("Dep. Time"); // 13
    headers.add("CRS Arrival Time(↓)"); // 14
    headers.add("Arrival Time"); // 15
    headers.add("Cancelled(↓)"); // 16
    headers.add("Diverted(↓)"); // 17
    headers.add("Distance(↓)"); // 18

    sorters = new HashMap<>();
    sortOrders = new HashMap<>();

    sorters.put("0", FlightsSortersFabric::byId);
    sortOrders.put("0", true);
    sorters.put("1", FlightsSortersFabric::byFlightDate);
    sortOrders.put("1", true);
    sorters.put("3", FlightsSortersFabric::byCarrierId);
    sortOrders.put("3", true);
    sorters.put("12", FlightsSortersFabric::byCrsDepartureTime);
    sortOrders.put("12", true);
    sorters.put("14", FlightsSortersFabric::byCrsArrivalTime);
    sortOrders.put("14", true);
    sorters.put("16", FlightsSortersFabric::byCancelled);
    sortOrders.put("16", true);
    sorters.put("17", FlightsSortersFabric::byDiverted);
    sortOrders.put("17", true);
    sorters.put("18", FlightsSortersFabric::byDistance);
    sortOrders.put("18", true);

    select.addOption("Carrier");
    select.addOption("Origin State");
    select.addOption("Dest. State");

    graphScreen.addWidget(select);


    prepareTableData(flights);
     // button setup
    btn1 = new Button(width/2-100, 150, 200, 50,color(180), "Table");
    btn2 = new Button(width/2-100, 250, 200, 50, color(180), "Pie Chart");
    quitButton = new Button(width/2-100, 350, 200, 50, color(180), "Quit");
    menuScreen.addWidget(btn1);
    menuScreen.addWidget(btn2);
    menuScreen.addWidget(quitButton);

    loadSound.play();
}

void draw() {
    background(255);
   if (gameState == 0) {
    fill(0);
    textAlign(CENTER);
    textSize(100);
    text("Main menu", width/2, 80);
    textSize(20);
    menuScreen.drawScreen();
  } else if (gameState == 1) {
    tableScreen.drawScreen();
} else if (gameState == 2) {
    graphScreen.drawScreen();
    textAlign(LEFT, LEFT);
    text("Most popular carrier: " + mostPopularCarrier, 500, 400);
    image(airlineLogo, 500, 420, 200, 200);
  }
}


void keyPressed() {
    if (gameState == 0) {
        // Handle menu navigation if needed
    } else if (gameState == 1) {
        tableScreen.handleKeyPressed(key, keyCode);
    } else if (gameState == 2) {
        // Handle graph interactions if needed
    }
}

void mousePressed() {
    if (gameState == 0) {
        if (btn1.isClicked(mouseX, mouseY)) {
            println("Loading Tables...");
            clickSound.play();
            gameState = 1;
            dataQuery = new DataQuery();
        }
        if (btn2.isClicked(mouseX, mouseY)) {
            println("Loading Graphs...");
            clickSound.play();
            gameState = 2;
            dataQuery = new DataQuery();
        }
        if (quitButton.isClicked(mouseX, mouseY)) {
            println("Quitting...");
            clickSound.play();
            exit();
        }
    } else if (gameState == 1) {
        tableScreen.handleMousePressed(mouseX, mouseY); 
        if (applyButton.isClicked(mouseX,mouseY)) {
            String airline = sortByAirline.getText().trim();
            String destination = sortByDestination.getText().trim();
            String origin = sortByOrigin.getText().trim();
            dataQuery.setFilter("airline", FlightFiltersFabric.byAirline(airline));
            dataQuery.setFilter("destination", FlightFiltersFabric.byDestinationCity(destination));
            dataQuery.setFilter("origin", FlightFiltersFabric.byOriginCity(origin));
            List<Flight> flights = queryEngine.execute(dataQuery, 0, 0);
            prepareTableData(flights);
        }
        int headerIndex = scrollableTable.getHeaderIndexByCoords(mouseX, mouseY);
        if (headerIndex != -1) {
            Function<Boolean, Comparator<Flight>> sorter = sorters.containsKey(String.valueOf(headerIndex)) ? sorters.get(String.valueOf(headerIndex)) : null;
            if (sorter == null) return;
            Boolean currentOrder = sortOrders.getOrDefault(String.valueOf(headerIndex), false);
            Comparator<Flight> comparator = sorters.get(String.valueOf(headerIndex)).apply(!currentOrder);
            sortOrders.put(String.valueOf(headerIndex), !currentOrder);
            dataQuery.setSort(comparator);
            headers.set(headerIndex, headers.get(headerIndex).charAt(headers.get(headerIndex).length() - 2) == '↓' ? headers.get(headerIndex).replace("↓", "↑") : headers.get(headerIndex).replace("↑", "↓"));
            List<Flight> flights = queryEngine.execute(dataQuery, 0, 0);
            prepareTableData(flights);
        }
    } else if (gameState == 2) {
        transitionSound.play();
        graphScreen.handleMousePressed(mouseX, mouseY);
        if (select.isOptionClicked(mouseX, mouseY)) {
            String selectedOption = select.selectedOption;
            HashMap<String, Float> newPieData = new HashMap<String, Float>();
            dataQuery.setFilter("cancelled", FlightFiltersFabric.byCancelled());
            List<Flight> flights = queryEngine.execute(dataQuery, 0, 0);
            switch (selectedOption) {
                case "Carrier":
                    for (Flight flight : flights) {
                        String carrier = flight.carrier;
                        if (newPieData.containsKey(carrier)) {
                            newPieData.put(carrier, newPieData.get(carrier) + 1);
                        } else {
                            newPieData.put(carrier, 1.0f);
                        }
                    }
                    break;
                case "Dest. State":
                    for (Flight flight : flights) {
                        String destState = flight.destinationState;
                        if (newPieData.containsKey(destState)) {
                            newPieData.put(destState, newPieData.get(destState) + 1);
                        } else {
                            newPieData.put(destState, 1.0f);
                        }
                    }
                    break;
                case "Origin State":
                    for (Flight flight : flights) {
                        String originState = flight.originState;
                        if (newPieData.containsKey(originState)) {
                            newPieData.put(originState, newPieData.get(originState) + 1);
                        } else {
                            newPieData.put(originState, 1.0f);
                        }
                    }
                    break;
            }
            cancelledPieChart.setData(newPieData);
        }
    }
    if (backButton.isClicked(mouseX, mouseY)) {
        gameState = 0; // Return to menu
        transitionSound.play();
    }
}

void mouseReleased() {
    if (gameState == 1) {
        tableScreen.handleMouseReleased(mouseX, mouseY);
    } else if (gameState == 2) {
        graphScreen.handleMouseReleased(mouseX, mouseY);
    }
}
void mouseDragged() {
    if (gameState == 1) {
        tableScreen.handleMouseDragged(mouseX, mouseY);
    } else if (gameState == 2) {
        // Handle mouse drag for graphs if needed
    }
}
void mouseWheel(MouseEvent event) {
    if (gameState == 1) {
        // tableScreen.handleMouseWheel(event);
        if (scrollableTable != null) {
            scrollableTable.handleMouseWheel(event.getCount());
        }
    } else if (gameState == 2) {
        // Handle mouse wheel for graphs if needed
    }
}
