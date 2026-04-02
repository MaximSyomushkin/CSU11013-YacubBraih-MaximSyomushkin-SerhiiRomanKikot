class PieChart extends Widget {
    private List<String> labels;
    private List<Float> values;
    private color[] colors;

    private float vRadius;
    private float hRadius;
    private float total;
    private int labelOffset = 20;
    private int labelsPerColumn = 0;
    private String title;
    PieChart(float x, float y, int w, int h,color backgroundColor, HashMap<String, Float> data, String title) {
        super(x, y, w, h, backgroundColor);
        this.labels = new ArrayList(data.keySet());
        this.values = new ArrayList(data.values());
        this.vRadius = (float) h / 2;
        this.hRadius = (float) w / 2;
        this.colors = new color[values.size()];
        this.total = 0;
        this.labelsPerColumn = 0;
        this.title = title;

        
        this.initColors();
        this.initTotal();
    }
    private void initColors() {
        for (int i = 0; i < values.size(); i++) {
            colors[i] = (color(random(255), random(255), random(255)));
        }
    }
    private void initTotal() {
        for (int i = 0; i < values.size(); i++) {
            total += values.get(i);
        }
        labelsPerColumn = (int) (this.h / (textDescent() + textAscent() + 10));
    }
    void setData(HashMap<String, Float> data) {
        this.labels = new ArrayList(data.keySet());
        this.values = new ArrayList(data.values());
        this.colors = new color[values.size()];
        this.total = 0;
        this.initColors();
        this.initTotal();
    }
    void drawWidget() {
        fill(255);
        ellipse(x + this.hRadius, y + this.vRadius, this.hRadius * 2, this.vRadius * 2);
        textAlign(LEFT, CENTER);
        float startAngle = -HALF_PI;
        for (int i= 0; i <values.size(); i++ ) {
            float percentage = values.get(i) / total;
            float angle = percentage * TWO_PI;
            fill(colors[i]);
            float x = this.x + this.hRadius ;
            float y = this.y + this.vRadius;
            arc(x, y, this.hRadius * 2, this.vRadius * 2, startAngle, startAngle + angle);
            startAngle += angle;
        }
        float textX = this.x + this.hRadius * 2 + this.labelOffset;
        int column = 0;
        float textY = this.y + 20;
        for (int i = 0; i < labels.size(); i++) {
            if (i > 0 && i % labelsPerColumn == 0) {
                column++;
                textX = this.x + this.hRadius * 2 + this.labelOffset + column * 100;
                textY = this.y + 20;
            }
            fill(colors[i]);
            text(labels.get(i) + " (" + values.get(i).intValue() + ")", textX, textY);
            textY += 20;
        }

        textAlign(LEFT, LEFT);
        fill(0);
        textSize(16);
        text(this.title, this.x, this.y - 2);
    }
}
