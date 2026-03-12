import java.util.List;



void setup() {
  ArrayList<Flight> flights = new ArrayList<Flight>();
  Table table = loadTable("flights2k.csv", "header");
  for (TableRow row : table.rows()) {
    flights.add(new Flight(row.getString("FL_DATE"), row.getString("MKT_CARRIER"), row.getInt("MKT_CARRIER_FL_NUM"), row.getString("ORIGIN"), row.getString("ORIGIN_CITY_NAME"), row.getString("ORIGIN_STATE_ABR"), row.getInt("ORIGIN_WAC"), row.getString("DEST"), row.getString("DEST_CITY_NAME"), row.getString("DEST_STATE_ABR"),row.getInt("DEST_WAC"), row.getInt("DEST_WAC"), row.getInt("DEP_TIME"), row.getInt("CRS_ARR_TIME"), row.getInt("ARR_TIME"), row.getInt("CANCELLED"), row.getInt("DIVERTED"), row.getInt("DISTANCE")));
  }
  RepositoryFile f = new RepositoryFile(flights);

  List<Flight> data = f.loadData();
  println(data);
}
