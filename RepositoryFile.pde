import java.util.ArrayList;

class RepositoryFile implements Repository {
    String filename;

    RepositoryFile(String filename) {
        this.filename = filename;
    }

    public List<Flight> loadData() {
        if (this.filename == null)
            return new ArrayList<>();

        Table table = loadTable(this.filename, "header");
        ArrayList<Flight> flights = new ArrayList<>();
        int index = 0;
        for (TableRow row : table.rows()) {
            flights.add(new Flight(index, row.getString("FL_DATE"), row.getString("MKT_CARRIER"),
                    row.getInt("MKT_CARRIER_FL_NUM"), row.getString("ORIGIN"), row.getString("ORIGIN_CITY_NAME"),
                    row.getString("ORIGIN_STATE_ABR"), row.getInt("ORIGIN_WAC"), row.getString("DEST"),
                    row.getString("DEST_CITY_NAME"), row.getString("DEST_STATE_ABR"), row.getInt("DEST_WAC"),
                    row.getInt("DEST_WAC"), row.getInt("DEP_TIME"), row.getInt("CRS_ARR_TIME"), row.getInt("ARR_TIME"),
                    row.getInt("CANCELLED"), row.getInt("DIVERTED"), row.getInt("DISTANCE")));
            index++;
        }
        return flights;
    }
}
