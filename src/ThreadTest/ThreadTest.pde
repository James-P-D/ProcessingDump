// Tested against Processing v3.5.3

  
String time = "";
boolean threadStarted;

void setup() {
  size(100, 100);
}

void draw() {
  background(0);
  // Every 30 frames request new data
  if (frameCount % 30 == 0) {
    if(!threadStarted){
      print("Starting thread\n");
      threadStarted = true;
      thread("requestData");
    } else {
      print("Not starting thread yet...\n");
    }
  }
  text(time, 10, 50);
}

// This happens as a separate thread and can take as long as it wants
void requestData() {
  print("requestData()\n");
  JSONObject json = loadJSONObject("http://time.jsontest.com/");
  time = json.getString("time");
  int x =0;
  for(int i =0; i< 100000; i++) {
    for(int j =0; j< 100000; j++) {
      for(int k =0; k< 100000; k++) {
        x++;
      }
    }
  }
  threadStarted = false; 
}
