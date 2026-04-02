class ScrollableTable extends Widget {
    TableWidget table;
    VScrollbar vScrollBar;
    HScrollbar hScrollBar;
    float hScrollMultiplier = 1.0f;
    float vScrollMultiplier = 1.0f;
    int scrollBarWidth = 16;

    ScrollableTable(float x, float y, int w, int h, color backgroundColor) {
        super(x, y, w, h, backgroundColor);
        table = new TableWidget();
        table.x = x;
        table.y = y;
        
        hScrollBar = new HScrollbar(x, y + h - scrollBarWidth, w - scrollBarWidth, scrollBarWidth, 2);
        vScrollBar = new VScrollbar(x + w - scrollBarWidth, y, scrollBarWidth, h - scrollBarWidth, 2);
    }

     void setDisplayData(ArrayList<String> headers, ArrayList<ArrayList<String>> data) {
        table.setDisplayData(headers, data);
        
        float hScrollTravel = (w - scrollBarWidth) - scrollBarWidth;
        if (hScrollTravel > 0 && table.w > w - scrollBarWidth) {
            this.hScrollMultiplier = (float) (table.w - (w - scrollBarWidth) + scrollBarWidth) / hScrollTravel;
        } else {
            this.hScrollMultiplier = 0;
        }

        float vScrollTravel = (h - scrollBarWidth) - scrollBarWidth;
        if (vScrollTravel > 0 && table.h > h - scrollBarWidth) {
            this.vScrollMultiplier = (float) (table.h - (h - scrollBarWidth) + scrollBarWidth) / vScrollTravel;
        } else {
            this.vScrollMultiplier = 0;
        }
    }

    @Override
    void drawWidget() {
        fill(backgroundColor);
        rect(x, y, w, h);

        float scrollX = (hScrollBar.spos - hScrollBar.sposMin) * hScrollMultiplier;
        float scrollY = (vScrollBar.spos - vScrollBar.sposMin) * vScrollMultiplier;

        clip((int)x, (int)y, w - scrollBarWidth, h - scrollBarWidth);
        table.drawWidget(-Math.max(0, scrollX), -Math.max(0, scrollY));
        noClip();

        hScrollBar.update();
        hScrollBar.drawWidget();
        
        vScrollBar.update();
        vScrollBar.drawWidget();
    }

    boolean isClicked(float mouseX, float mouseY) {
        return mouseX >= x && mouseX <= x + w - scrollBarWidth && mouseY >= y && mouseY <= y + h - scrollBarWidth;
    }

    @Override
    void handleMousePressed(int mouseX, int mouseY) {
        if (hScrollBar.isClicked(mouseX, mouseY)) {
            hScrollBar.handleMousePressed(mouseX, mouseY);
        } else if (vScrollBar.isClicked(mouseX, mouseY)) {
            vScrollBar.handleMousePressed(mouseX, mouseY);
        } else if (this.isClicked(mouseX, mouseY)) {
            float scrollX = (hScrollBar.spos - hScrollBar.sposMin) * hScrollMultiplier;
            float scrollY = (vScrollBar.spos - vScrollBar.sposMin) * vScrollMultiplier;
            int index = table.getHeaderIndexByCoords((int)(mouseX + Math.max(0, scrollX)), (int)(mouseY + Math.max(0, scrollY)));
            println(index);
        }
    }
    int getHeaderIndexByCoords(int mouseX, int mouseY) {
        float scrollX = (hScrollBar.spos - hScrollBar.sposMin) * hScrollMultiplier;
        float scrollY = (vScrollBar.spos - vScrollBar.sposMin) * vScrollMultiplier;
        int index = table.getHeaderIndexByCoords((int)(mouseX + Math.max(0, scrollX)), (int)(mouseY + Math.max(0, scrollY)));
        println(index);
        return index;
    }

    @Override
    void handleMouseDragged(int mouseX, int mouseY) {
        hScrollBar.handleMouseDragged(mouseX, mouseY);
        vScrollBar.handleMouseDragged(mouseX, mouseY);
    }

    @Override
    void handleMouseReleased(int mouseX, int mouseY) {
        hScrollBar.handleMouseReleased(mouseX, mouseY);
        vScrollBar.handleMouseReleased(mouseX, mouseY);
    }
    
    void handleMouseWheel(float amount) {
        vScrollBar.scrollByWheel(amount);
    }
}
