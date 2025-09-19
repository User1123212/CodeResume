# CodeResume
Here is some code that I have built.


Wildlands is a top-down 2D game that I intend to flesh out more through making some sprites and animations. At present it features a movable character, a modular inventory and item system, and a basic combat system.
![alt text](https://github.com/User1123212/CodeResume/blob/main/Images/GameOverview.png)

Above you can see the basic layout of the game. The yellow square moves through the world with WASD and is able to pick up the items and add them to an inventory. The press of the buttons grant the character a "velocity", which changes the position of the yellow square in the world based on the game loop update speed. The game engine, Godot, takes care of this using a built-in physics engine, allowing users to merely call the move_and_slide() function on the node.

The items monitor if another shape enters them, then checks if the area is tagged "Player". If it is, it calls logic in the inventory to add itself to the inventory and then clears itself from the world.

![alt text](https://github.com/User1123212/CodeResume/blob/main/Images/ModularInventory.png)

The player is able to manipulate the position of the items within the inventory and the toolbar. When the player passes over an item the item passes its information to the inventory logic, which runs through the inventory array and checks for empty slots. When it finds one it adds the item data into the array, grabs the sprite from the item data, adds the sprite into the panel, then tells the panels to update their texture. I have not yet added a mechanism for inventory overflow, but I may just have it run through the logic, then pop out a new world item if it is unable to add it to the inventory, which will add a fun little "popping out" effect when the inventory is full.

As for the rest of the inventory logic, the panel is the ui element that monitors for input, detecting if it is clicked. If it is, it signals to the panel, which determines the index of the clicked panel and then reports that to the inventory logic. The inventory logic checks if there is an item in the slot, or if there is an item in the "held" slot. If both are empty, nothing happens. If there is an item in the slot and no held item, the item is "picked up" or added to the "held" slot and removed from the inventory array. If there is no item in the slot and one in the held item slot, the item in the held item slot is added to the inventory array. If both slots are full the two items are swapped. Once the inventory logic handles the data and adding or removing the items to the proper arrays, it tells the inventory panel to update the ui to reflect the changes visually to the user.

![alt text](https://github.com/User1123212/CodeResume/blob/main/Images/ItemUse.png)

The player is able to use items using the left mouse button. In order to make a more universal use function, I have the player script check if an "active item" (the red box on the toolbar) has a use function in the item's script. If it does have a use function, the player and the mouse positions are passed to the item's function as arguments, and then the item logic handles the effects of the use function. In the case of the sword, it generates an area which deducts hitpoints from enemies. I addedd a large red texturebox for debugging so that I was able to see the area of the hurtbox. For now, I generate a timer to determine how long the sword "swing" lasts before the hitbox removes itself from the scene.

I look forward to adding more items and potentially some fun combat mechanics such as dodging. 

Survive is a very basic first-person shooter. I added a store system as well as rudimentary 3D models and animations for certain actions. There is a damage system using raycasts and enemy hitboxes
