/*
ARIES Cassette Manufacturing Line
Workstation #1, #2
*/

const unsigned long  startup_delay = 1000;
const unsigned long  cyl_fire_pulse_width_ms = 50;
const unsigned long  cyl_clear_pulse_width_ms = 150;
const unsigned long  cyl_home_debounce_time = 100;
const unsigned long  cyl_home_dwell_time = 1000;
unsigned long time;
unsigned long cyl_start;

const int  switch_in = 7;
const int  sequence_start_out_n = 6;

const int  cyl_a_clear_in_n = 8;
const int  cyl_b_clear_in_n = 9;

const int  cyl_a_fire_out = 10;
const int  cyl_b_fire_out = 11;

const int  cyl_a_home_in = 3;
const int  cyl_b_home_in = 4;
const int  car_clear_out = 5;

const int  led_pin_out = 2;

const unsigned int  cyl_inactive = 0;
const unsigned int  cyl_triggered = 1;
const unsigned int  cyl_debounce = 2;
const unsigned int  cyl_home = 3;
const unsigned int  cyl_clear = 4;
unsigned int  state;


void  setup()  {
//  Serial.begin(9600);
  pinMode(switch_in, INPUT);
  pinMode(sequence_start_out_n, OUTPUT);

  pinMode(cyl_a_clear_in_n, INPUT);
  pinMode(cyl_a_fire_out, OUTPUT);

  pinMode(cyl_b_clear_in_n, INPUT);
  pinMode(cyl_b_fire_out, OUTPUT);
  
  pinMode(cyl_a_home_in, INPUT);
  pinMode(cyl_b_home_in, INPUT);
  pinMode(car_clear_out, OUTPUT);
  
  state = cyl_inactive;
  cyl_start = 0;
  digitalWrite(car_clear_out, LOW);  
}

void  loop()  {
  time = millis();
  if (time > startup_delay) {
    if (digitalRead(switch_in)) {
      digitalWrite(sequence_start_out_n, LOW);
    } else {
      digitalWrite(sequence_start_out_n, HIGH);
    }
    if (digitalRead(cyl_a_clear_in_n)) {
      digitalWrite(cyl_a_fire_out, LOW);
    } else {
      digitalWrite(cyl_a_fire_out, HIGH);
    }
    if (digitalRead(cyl_b_clear_in_n)) {
      digitalWrite(cyl_b_fire_out, LOW);
    } else {
      digitalWrite(cyl_b_fire_out, HIGH);
    }
  } else {
    digitalWrite(sequence_start_out_n, HIGH);
    digitalWrite(cyl_a_fire_out, LOW);
    digitalWrite(cyl_b_fire_out, LOW);
  }
  switch (state) {
    case cyl_inactive:
//      Serial.println("Inactive");
      if ((digitalRead(cyl_a_home_in) == LOW) || (digitalRead(cyl_b_home_in) == LOW)) {
        state = cyl_triggered;
        digitalWrite(car_clear_out, LOW);
      } else {
        state = cyl_inactive;
        digitalWrite(car_clear_out, LOW);
      }
      break;
    case cyl_triggered:
//      Serial.println("Triggered");
      if ((digitalRead(cyl_a_home_in) == HIGH) && (digitalRead(cyl_b_home_in) == HIGH)) {
        state = cyl_debounce;
        digitalWrite(car_clear_out, LOW);
        cyl_start = time;
      } else {
        state = cyl_triggered;
        digitalWrite(car_clear_out, LOW);
      }
      break;
    case cyl_debounce:
      if ((digitalRead(cyl_a_home_in) == HIGH) && (digitalRead(cyl_b_home_in) == HIGH)) {
        if (time > cyl_start + cyl_home_debounce_time) {
          state = cyl_home;
        } else {
          state = cyl_debounce;
        }
      } else {
        state = cyl_triggered;
      }
      break;
    case cyl_home:
//      Serial.println("Home");
      if (time > cyl_start + cyl_home_debounce_time + cyl_home_dwell_time) {
        state = cyl_clear;
        digitalWrite(car_clear_out, HIGH);
      } else {
        state = cyl_home;
        digitalWrite(car_clear_out, LOW);
      }        
      break;
    case cyl_clear:
//      Serial.println("Clear");
      if (time > cyl_start + cyl_home_dwell_time + cyl_clear_pulse_width_ms) {
        state = cyl_inactive;
        digitalWrite(car_clear_out, LOW);
      } else {
        state = cyl_clear;
        digitalWrite(car_clear_out, HIGH);
      }        
      break;
    default:
      state = cyl_inactive;
      digitalWrite(car_clear_out, LOW);  
  }
}
