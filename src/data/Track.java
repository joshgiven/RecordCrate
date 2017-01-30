package data;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class Track {
	private String title;
	private int length;
	private int index;
	
	public Track() { }
	
	@JsonCreator
	public Track(
			@JsonProperty("index")  int index,
			@JsonProperty("title")  String title, 
			@JsonProperty("length") int length ) {
		this();
		this.index  = index;
		this.title  = title;
		this.length = length;
	}

	public String getTime() {
		int t = length/1000;
		
		return String.format("%02d:%02d", t/60, t%60); 
	}

	public int getLength() {
		return length;
	}
	
	public void setLength(int length) {
		this.length = length;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}
	
}
