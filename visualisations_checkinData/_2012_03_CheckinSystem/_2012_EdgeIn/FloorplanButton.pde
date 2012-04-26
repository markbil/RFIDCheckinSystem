class FloorplanButton extends Button{
	String id;
//        boolean selected = false;
        Floorplan floorplan;
//        color spaceFillColor = color(248,112,133); //pink

      
      
        
        FloorplanButton(String title, String id, Floorplan f) {
		super(title);
                this.id = id;
                this.floorplan = f;
                this.fillColor = floorplan.spaceFillColor;
                this.textColor = floorplan.spaceTextColor;
                this.strokeColor = floorplan.spaceStrokeColor; 		
	}
        
//        void setBoundaries(int w, int h){
//           bb.reset();
//           bb.addPoint((int)(-w/2), (int)(-h/2)); 
//           bb.addPoint((int)(w/2), (int)(-h/2)); 
//           bb.addPoint((int)(w/2), (int)(h/2)); 
//           bb.addPoint((int)(-w/2), (int)(h/2));
//        }
        
        public void onTouch(){
          //if NOT an already selected space is being touched on...
          if (floorplan.selectedFloorplanButton != this){
            //println("not this");
            if (floorplan.selectedFloorplanButton.id != "nowhere"){
              //println("not nowhere");
              floorplan.selectedFloorplanButton.fillColor = floorplan.spaceFillColor; //paint the previously selected area back to white
              floorplan.selectedFloorplanButton.textColor = floorplan.spaceTextColor; //paint the previously selected area back to white
              floorplan.selectedFloorplanButton.strokeColor = floorplan.spaceStrokeColor; //paint the previously selected area back to white
              
            }
            floorplan.selectedFloorplanButton = this;
            print(getTextString());
            floorplan.selectedFloorplanButton.fillColor = floorplan.selectedSpaceFillColor; //paint the currently selected area
            floorplan.selectedFloorplanButton.textColor = floorplan.selectedSpaceTextColor;
            floorplan.selectedFloorplanButton.strokeColor = floorplan.selectedSpaceStrokeColor;
            println(" (id=" + floorplan.selectedFloorplanButton.id +")");
          }
          else{
            //if already selected space is being touched on...
            //println("else");
            floorplan.selectedFloorplanButton.fillColor = floorplan.spaceFillColor;
            floorplan.selectedFloorplanButton.strokeColor = floorplan.spaceStrokeColor;
            floorplan.selectedFloorplanButton.textColor = floorplan.spaceTextColor;
            floorplan.selectedFloorplanButton = floorplan.noWhere;
            println(" (id=" + floorplan.selectedFloorplanButton.id +")");
          }

          checkinButton_visible = true;
        }

 
}

