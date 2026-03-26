class TableWidget extends Widget {
    ArrayList<ArrayList<String>> matrixData;
    ArrayList<String> headers;
    ArrayList<Integer> columnWidths;
    ArrayList<Integer> rowHeights;
    int headerHeight;
    TableWidget() {
        super(0, 0, 0, 0, color(255));
        matrixData = new ArrayList<ArrayList<String>>();
        headers = new ArrayList<String>();
        columnWidths = new ArrayList<Integer>();
        rowHeights = new ArrayList<Integer>();
        headerHeight = 0;
    }
    void setDisplayData(ArrayList<String> newHeaders, ArrayList<ArrayList<String>> data) {
        headers = new ArrayList<String>(newHeaders);
        matrixData = new ArrayList<ArrayList<String>>(data);

        columnWidths.clear();
        rowHeights.clear();

        headerHeight = (int) (textAscent() + textDescent() + 10);

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
        this.h += headerHeight;
    }
    void drawWidget(float scrollOffsetX, float scrollOffsetY) {
        super.drawWidget();
        textSize(12);
        textAlign(LEFT, CENTER);
        int startCol = 0;
        float startColX = x + scrollOffsetX;
        if (matrixData.size() == 0) {
            text("No data to display", x + 20, y + 40);
            return;
        }

        while (startCol < columnWidths.size() && startColX + columnWidths.get(startCol) < 0) {
            startColX += columnWidths.get(startCol);
            startCol++;
        }

        int endCol = startCol;
        float scanX = startColX;
        while (endCol < columnWidths.size() && scanX <= width) {
            scanX += columnWidths.get(endCol);
            endCol++;
        }
        float yOffset = scrollOffsetY;
        float xOffset = scrollOffsetX;
        for (int i = 0; i < headers.size(); i++) {
            fill(200);
            rect(x + xOffset, y + yOffset, columnWidths.get(i), rowHeights.get(0));
            fill(0);
            text(headers.get(i), x + xOffset + 5, y+ yOffset + rowHeights.get(0) / 2 + 5);
            xOffset += columnWidths.get(i);
        }
        int startRow = 0;
        float startRowY = y + scrollOffsetY + headerHeight;

        while (startRow < matrixData.size() && startRowY + rowHeights.get(startRow) < 0) {
            startRowY += rowHeights.get(startRow);
            startRow++;
        }

        int endRow = startRow;
        float scanY = startRowY;
        while (endRow < matrixData.size() && scanY <= height) {
            scanY += rowHeights.get(endRow);
            endRow++;
        }

        float rowY = startRowY;
        for (int i = startRow; i < endRow; i++) {
            ArrayList<String> row = matrixData.get(i);

            float cellX = startColX;
            for (int j = startCol; j < endCol; j++) {
                fill(255);
                rect(cellX, rowY, columnWidths.get(j), rowHeights.get(i));
                fill(0);

                String cellText = (j < row.size()) ? row.get(j) : "";
                text(cellText, cellX + 5, rowY + rowHeights.get(i) / 2 + 5);

                cellX += columnWidths.get(j);
            }

            rowY += rowHeights.get(i);
        }
    }
    int getHeaderIndexByCoords(float headerX, float headerY) {
        if (headerY < y || headerY > y + headerHeight) {
            return -1;
        }
        println("Clicked on header area");
        float xOffset = 0;
        for (int i = 0; i < columnWidths.size(); i++) {
            println("Checking column " + i + " at X: " + (x + xOffset) + " to " + (x + xOffset + columnWidths.get(i)));
            if (headerX >= x + xOffset && headerX <= x + xOffset + columnWidths.get(i)) {
                return i;
            }
            xOffset += columnWidths.get(i);
        }
        return -1;
    }
    void handleMousePressed(int mx, int my) {
        int headerIndex = getHeaderIndexByCoords(mx, my);
        if (headerIndex != -1) {
            println("Clicked on header: " + headers.get(headerIndex));
        }
    }

}
