class Floorplan extends GUI {

        color spaceFillColor = color(230,230,230);
        color spaceTextColor = color(0, 0, 0);
        color spaceStrokeColor = color(0, 0, 0);
  
        color selectedSpaceFillColor = color(241,0,38);
        color selectedSpaceTextColor = color(180, 242, 0);
        color selectedSpaceStrokeColor = color(0, 0, 0);
        
        
        FloorplanButton noWhere = new FloorplanButton("nowhere", "nowhere", this);
        FloorplanButton selectedFloorplanButton = noWhere;

	Floorplan() {
           
          for (int i = 0; i < 11; i++) {
            FloorplanButton b1 = new FloorplanButton("Bay " + (i+1), "windowbay" + (i+1), this);
            b1.setBoundaries(70, 70);
            b1.setTranslation((i-5)*90, -250);
            b1.setFont(createFont("Arial", 10));
            addWidget(b1);
            
          }
          
          for (int i = 0; i < 2; i++) {
            FloorplanButton l1 = new FloorplanButton("Lab " + (i+1), "lab" + (i+1), this);
            l1.setBoundaries(160, 120);
            l1.setTranslation(405, (i-1)*140);
            l1.setFont(createFont("Arial", 10));
            addWidget(l1);
            
          }
          
          FloorplanButton a = new FloorplanButton("Auditorium", "auditorium", this);
            a.setBoundaries(350, 270);
            a.setTranslation(-220, -20);
            a.setFont(createFont("Arial", 10));
            addWidget(a);

          FloorplanButton l3 = new FloorplanButton("Lab 3", "lab3", this);
            l3.setBoundaries(70, 120);
            l3.setTranslation(270, 5);
            l3.setFont(createFont("Arial", 10));
            addWidget(l3);
            
          FloorplanButton c = new FloorplanButton("Coffee Kiosk", "coffeekiosk", this);
            c.setBoundaries(100, 50);
            c.setTranslation(135, 5);
            c.setFont(createFont("Arial", 10));
            addWidget(c);
	
	}



        public String getSelectedFloorplanButton(){
          return selectedFloorplanButton.id;
        }
}




