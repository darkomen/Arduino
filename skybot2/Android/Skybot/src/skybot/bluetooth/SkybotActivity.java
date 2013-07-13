package skybot.bluetooth;


import at.abraxas.amarino.Amarino;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class SkybotActivity extends Activity {
    /** Called when the activity is first created. */
	
	Button adelante,detras,izquierda,derecha,paro;
	private static final String DEVICE_ADDRESS = "00:12:03:09:14:75";

	
    @Override
    public void onCreate(Bundle savedInstanceState) {
    	Amarino.connect(this, DEVICE_ADDRESS);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        adelante = (Button) findViewById(R.id.adelante);
        detras = (Button) findViewById(R.id.atras);
        izquierda = (Button) findViewById(R.id.derecha);
        derecha = (Button) findViewById(R.id.izquierda);
        paro = (Button) findViewById(R.id.paro);
        adelante.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				adelante();
			}
			

		});
        detras.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				detras();
				
			}
		});
        izquierda.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				izquierda();
			}
		});
        derecha.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				derecha();
			}
		});
        paro.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				paro();
			}
		});
    }
	protected void onStop() {
		super.onStop();

		// stop Amarino's background service, we don't need it any more 
		Amarino.disconnect(this, DEVICE_ADDRESS);
	}
	private void adelante(){
		// I have chosen random small letters for the flag 'o' for red, 'p' for green and 'q' for blue
		// you could select any small letter you want
		// however be sure to match the character you register a function for your in Arduino sketch
		Amarino.sendDataToArduino(this, DEVICE_ADDRESS, 'a', '1');
	}
	private void detras(){
		// I have chosen random small letters for the flag 'o' for red, 'p' for green and 'q' for blue
		// you could select any small letter you want
		// however be sure to match the character you register a function for your in Arduino sketch
		Amarino.sendDataToArduino(this, DEVICE_ADDRESS, 'd', '1');
	}
	private void izquierda(){
		// I have chosen random small letters for the flag 'o' for red, 'p' for green and 'q' for blue
		// you could select any small letter you want
		// however be sure to match the character you register a function for your in Arduino sketch
		Amarino.sendDataToArduino(this, DEVICE_ADDRESS, 'l', '1');
	}
	private void derecha(){
		// I have chosen random small letters for the flag 'o' for red, 'p' for green and 'q' for blue
		// you could select any small letter you want
		// however be sure to match the character you register a function for your in Arduino sketch
		Amarino.sendDataToArduino(this, DEVICE_ADDRESS, 'r', '1');
	}
	private void paro(){
		// I have chosen random small letters for the flag 'o' for red, 'p' for green and 'q' for blue
		// you could select any small letter you want
		// however be sure to match the character you register a function for your in Arduino sketch
		Amarino.sendDataToArduino(this, DEVICE_ADDRESS, 'p', '1');
	}
}