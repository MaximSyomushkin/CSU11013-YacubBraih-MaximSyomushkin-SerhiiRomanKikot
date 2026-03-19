import java.util.List;
RepositoryFile repository;
DataService dataService;
DataQuery dataQuery;
QueryEngine queryEngine;
HScrollbar hs1;
VScrollbar vs1;
    
void setup() {
    repository = new RepositoryFile("flights2k.csv");
    dataService = new DataService(repository);
    queryEngine = new QueryEngine(dataService);
    dataQuery = new DataQuery();
    dataQuery.setFilter("byAirport", FlightFiltersFabric.byAirport("BDL"));
    dataQuery.setSort("byDate", FlightsSortersFabric.byDate(false));
    queryEngine.execute(dataQuery, 0,0).forEach(System.out::println);
    println("Without filters");
    dataQuery.clearFilters();
    queryEngine.execute(dataQuery, 0, 10).forEach(System.out::println);
    
    size(640, 360);
    noStroke();
  
    hs1 = new HScrollbar(0, height-8, width, 16, 16);
    vs1 = new VScrollbar(width-8, 0, height, 16, 16);
}

  void draw() {
    background(255);
    fill(255);
  
    hs1.update();
    hs1.display();
    vs1.update();
    vs1.display();

  
    //After it has been used in the sketch, set it back to false
    
    if (hs1.firstMousePress) {
      hs1.firstMousePress = false;
    }
    println(hs1.spos);
  }
  void mousePressed() {
  if (!hs1.firstMousePress) {
    hs1.firstMousePress = true;
  }
}
