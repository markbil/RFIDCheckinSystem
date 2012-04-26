class FloorplanButton extends Button{
	String id;
//        boolean selected = false;
        Floorplan floorplan;
      
      
        
        FloorplanButton(String title, String id, Floorplan f) {
		super(title);
                this.id = id;
                this.floorplan = f;
 		
	}
        
        void setBoundaries(int w, int h){
           bb.reset();
           bb.addPoint((int)(-w/2), (int)(-h/2)); 
           bb.addPoint((int)(w/2), (int)(-h/2)); 
           bb.addPoint((int)(w/2), (int)(h/2)); 
           bb.addPoint((int)(-w/2), (int)(h/2));
        }
        
        public void onTouch(){
          //if NOT an already selected space is being touched on...
          if (floorplan.selectedFloorplanButton != this){
            //println("not this");
            if (floorplan.selectedFloorplanButton.id != "nowhere"){
              //println("not nowhere");
              floorplan.selectedFloorplanButton.fillColor = systemFillColor; //paint the previously selected area back to white
              floorplan.selectedFloorplanButton.textColor = systemTextColor; //paint the previously selected area back to white
              
            }
            floorplan.selectedFloorplanButton = this;
            print(buttonText);
            floorplan.selectedFloorplanButton.fillColor = floorplan.selectedSpaceFillColor; //paint the currently selected area
            floorplan.selectedFloorplanButton.textColor = floorplan.selectedSpaceTextColor;
            println(" (id=" + floorplan.selectedFloorplanButton.id +")");
          }
          else{
            //if already selected space is being touched on...
            //println("else");
            floorplan.selectedFloorplanButton.fillColor = systemFillColor;
            floorplan.selectedFloorplanButton.textColor = systemTextColor;
            floorplan.selectedFloorplanButton = floorplan.noWhere;
            println(" (id=" + floorplan.selectedFloorplanButton.id +")");
          }

        }

 
}

