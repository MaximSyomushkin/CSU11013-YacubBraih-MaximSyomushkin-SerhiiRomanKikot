class TableWidget extends Widget {
    ArrayList<ArrayList<String>> matrixData;
    ArrayList<String> headers;
    ArrayList<Integer> columnWidths;
    ArrayList<Integer> rowHeights;
    TableWidget() {
        super(0, 0, 0, 0, color(255));
        matrixData = new ArrayList<ArrayList<String>>();
        headers = new ArrayList<String>();
        columnWidths = new ArrayList<Integer>();
        rowHeights = new ArrayList<Integer>();
    }
    void setDisplayData(ArrayList<String> newHeaders, ArrayList<ArrayList<String>> data) {

        headers = newHeaders;
        matrixData = data;
        for (int i = 0; i< data.size(); i++) {
            rowHeights.add((int) (textAscent() + textDescent() + 10));
            for (int j = 0; j < data.get(i).size(); j++) {
                int cellWidth = (int) textWidth(data.get(i).get(j)) + 10;
                if (columnWidths.size() <= j) {
                    columnWidths.add(cellWidth);
                } else if (cellWidth > columnWidths.get(j)) {
                    columnWidths.set(j, cellWidth);
                }
            }
        }
        for (int i = 0; i < headers.size(); i++) {
            int headerWidth = (int) textWidth(headers.get(i)) + 10;
            if (columnWidths.size() <= i) {
                columnWidths.add(headerWidth);
            } else if (headerWidth > columnWidths.get(i)) {
                columnWidths.set(i, headerWidth);
            }
        }

        this.w = 0;
        for (int width : columnWidths) {
            this.w += width;
        }
        this.h = 0;
        for (int height : rowHeights) {
            this.h += height;
        }
    }
    void drawWidget() {
        super.drawWidget();
        int yOffset = 0;
        // Draw headers
        int xOffset = 0;
        for (int i = 0; i < headers.size(); i++) {
            fill(200);
            rect(x + xOffset, y + yOffset, columnWidths.get(i), rowHeights.get(0));
            fill(0);
            text(headers.get(i), x + xOffset + 5, y + yOffset + rowHeights.get(0) / 2 + 5);
            xOffset += columnWidths.get(i);
        }
        yOffset += rowHeights.get(0);
        // Draw data rows
       for (int i = 0; i < matrixData.size(); i++) {
            ArrayList<String> row = matrixData.get(i);
            xOffset = 0;
            for (int j = 0; j < row.size(); j++) {
                fill(255);
                rect(x + xOffset, y + yOffset, columnWidths.get(j), rowHeights.get(i));
                fill(0);
                text(row.get(j), x + xOffset + 5, y + yOffset + rowHeights.get(i) / 2 + 5);
                xOffset += columnWidths.get(j);
            }
            yOffset += rowHeights.get(i);
        }
    }

}
