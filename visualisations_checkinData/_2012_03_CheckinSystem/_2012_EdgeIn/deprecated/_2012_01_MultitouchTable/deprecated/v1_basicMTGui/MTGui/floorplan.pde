class Floorplan extends GUI {

        color selectedSpaceFillColor = color(127, 0, 0);
        color selectedSpaceTextColor = color(255, 255, 255);
        FloorplanButton noWhere = new FloorplanButton("nowhere", 0, this);
        FloorplanButton selectedFloorplanButton = noWhere;

	Floorplan() {
           
          for (int i = 0; i < 11; i++) {
            FloorplanButton b1 = new FloorplanButton("Window Bay " + (i+1), i+1, this);
            b1.setTranslation((i-5)*90, -250);
            b1.setFont(createFont("Arial", 10));
            b1.setBoundaries(70, 70);
            addWidget(b1);
            
          }
          
          for (int i = 0; i < 2; i++) {
            FloorplanButton l1 = new FloorplanButton("Lab " + (i+1), i+1+11, this);
            l1.setFont(createFont("Arial", 10));
            l1.setBoundaries(160, 120);
            l1.setTranslation(405, (i-1)*140);
            addWidget(l1);
            
          }
          
          FloorplanButton a = new FloorplanButton("Auditorium", 15, this);
            a.setFont(createFont("Arial", 10));  
            a.setBoundaries(350, 270);
            a.setTranslation(-220, -20);
            addWidget(a);

          FloorplanButton l3 = new FloorplanButton("Lab 3", 16, this);
            l3.setFont(createFont("Arial", 10));
            l3.setBoundaries(70, 120);
            l3.setTranslation(270, 5);
            addWidget(l3);
            
          FloorplanButton c = new FloorplanButton("Coffee Kiosk", 17, this);
            c.setFont(createFont("Arial", 10));
            c.setBoundaries(100, 50);
            c.setTranslation(135, 5);
            addWidget(c);
	
	}

}




