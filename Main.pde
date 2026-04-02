import java.util.List;

PFont headerFont;
PFont everythingFont;

RepositoryFile repository;
DataService dataService;
DataQuery dataQuery;
QueryEngine queryEngine;

Screen tableScreen, graphScreen, menuScreen;

TableWidget tableWidget;
PieChart pieChart, top5PieChart;
    
ScrollableTable scrollableTable;
TextInput sortByAirline, sortByDestination, sortByOrigin;
Button btn1, btn2, applyButton, backButton;

HashMap<String, TextInput> focusedInput = new HashMap<>();
TextInputGroup textInputGroup;

int gameState = 0; // 0 = Menu, 1 = Table , 2 = Graph

ArrayList<String> headers = new ArrayList<>();

void prepareTableData(List<Flight> flights) {
    ArrayList<ArrayList<String>> tableData = DataMapper.flightsToTableData(flights);
    scrollableTable.setDisplayData(headers, tableData);
}
void setup() {
    size(1400,800);
    headerFont = createFont("Arial-BoldMT-48.vlw", 48);
    everythingFont = createFont("ArialMT-20.vlw", 20);
    textFont(everythingFont);
    tableScreen = new Screen();
    graphScreen = new Screen();
    menuScreen = new Screen();

    repository = new RepositoryFile("flights2k.csv");
    dataService = new DataService(repository);
    queryEngine = new QueryEngine(dataService);
    dataQuery = new DataQuery();
    tableWidget = new TableWidget();
    textInputGroup = new TextInputGroup(200,50,300, 300, color(220));
    
    List<Flight> flights = queryEngine.execute(dataQuery, 0, 0);
    

    scrollableTable = new ScrollableTable(100, 300, 1200, 500, color(200));
    tableScreen.addWidget(scrollableTable);

    // Input fields for sorting
    sortByAirline = new TextInput(200, 50, 200, 30, color(220), "Sort by Airline");
    sortByDestination = new TextInput(200, 120, 200, 30, color(220), "Sort by Destination");
    sortByOrigin = new TextInput(200, 180, 200, 30, color(220), "Sort by Origin");

    

    backButton = new Button(50, 50, 100, 30, color(180), "Back");
    applyButton = new Button(200, 250, 100, 30, color(180), "Apply");
    
    sortByAirline.setFocused(true);

    textInputGroup.addTextInput(sortByAirline);
    textInputGroup.addTextInput(sortByDestination);
    textInputGroup.addTextInput(sortByOrigin);

    tableScreen.addWidget(applyButton);
    tableScreen.addWidget(backButton);
    tableScreen.addWidget(textInputGroup);
    
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
    // tableScreen.addWidget(top5PieChart);
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
   
    
    graphScreen.addWidget(pieChart);
    graphScreen.addWidget(backButton);

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
     // button setup
    btn1 = new Button(width/2-100, 150, 200, 50,color(180), "Table");
    btn2 = new Button(width/2-100, 250, 200, 50, color(180), "Pie Chart");
    menuScreen.addWidget(btn1);
    menuScreen.addWidget(btn2);
}

void draw() {
    background(255);
   if (gameState == 0) {
    fill(0);
    textAlign(CENTER);
    textSize(100);
    textFont(headerFont);
    text("Main menu", width/2, 80);
    textFont(everythingFont);
    menuScreen.drawScreen();
  } else if (gameState == 1) {
    tableScreen.drawScreen();
  } else if (gameState == 2) {
    graphScreen.drawScreen();
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
            gameState = 1;
        }
        if (btn2.isClicked(mouseX, mouseY)) {
            println("Loading Graphs...");
            gameState = 2;
        }
    } else if (gameState == 1) {
        tableScreen.handleMousePressed(mouseX, mouseY);
        if (backButton.isClicked(mouseX, mouseY)) {
            gameState = 0; // Return to menu
        }
    } else if (gameState == 2) {
        graphScreen.handleMousePressed(mouseX, mouseY);
        if (backButton.isClicked(mouseX, mouseY)) {
            gameState = 0; // Return to menu
        }
    }
}

void mouseReleased() {
    if (gameState == 1) {
        tableScreen.handleMouseReleased(mouseX, mouseY);
    } else if (gameState == 2) {
        // Handle mouse release for graphs if needed
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
