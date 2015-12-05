String plan;

float x, y, z;
float rotate_x, rotate_y;

void setup() {
  plan = "A";
}

void draw() {
}

void keyPressed() {
  switch (key) {
  case '1':
    stepPlan();
    break;
  case '2':
    plan = "A";
    break;
}

void stepPlan() {
  StringBuffer next = new StringBuffer();

  for (int i = 0; i < plan.length(); i++) {
    char c = plan.charAt(i);
    switch (c) {
    case 'A':
      next.append("ABA");
      break;
    case 'B':
      next.append("BBB");
      break;
    }
  }
  plan = next.toString();
  println(plan);
}
