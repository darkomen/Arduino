class rueda 
{
  public:
  
    //-- Constructor
    rueda();
    
    //-- Add a new servo to the worm. It should be done
    //-- during the Setup
    void add_servo(int pin, bool rev=false);
    
    //-- Assign a "wave" to the worm
    void set_stop(Wave w, int servo = -1);
    
    //-- Set the amplitude (deg)
    void set_dir(unsigned int D, int servo  = -1);
    
    
    //-- Update the worm state. This method should be
    //-- called periodically from the main loop() function
    void refresh();
 
};

#endif
