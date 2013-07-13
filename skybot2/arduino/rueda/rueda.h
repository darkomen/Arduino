#ifndef Rueda_h
#define Rueda_h


class Rueda 
{
  public:
  
    //-- Constructor
    Rueda();
    
    //-- Add a new servo to the worm. It should be done
    //-- during the Setup
    void add_servo(int pin, bool rev=false);

    //-- Set the amplitude (deg)
    void set_stop(unsigned int D, int servo  = -1);
    

    
    //-- Update the worm state. This method should be
    //-- called periodically from the main loop() function
    void refresh();
    
    
  private:
    //-- Number of servos in the robot
    int _nservo
    //-- Current initial phase
    int _stop;
    
    //-- Current phase difference
    int _direction;
};

#endif
