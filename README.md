# Learn Jam 2018 - GameMaker Studio 2

## Intro

- We're going to use GameMaker Studio 2 to make a _Space Invaders_ game
- Download trial here: http://www.yoyogames.com/get
- Minimal programing experience is required, we'll cover the basics.

## Editor Basics

- Resource tree
  - There are different categories, the important ones for now are:
    - `Sprites`
    - `Objects`
    - `Rooms`
  - To make a new resource right click the category and click create
- Make a sprite
  - This opens the properties of the sprite you just created
  - "Sprites" are the images used in our game
  - Click "Edit Image", this opens up a sprite editor window
    - It's basically MS Paint with a few cool features
    - Just use the fill tool to make a square for now, this isn't Katie's art lesson
  - Close the sprite editor to get back to the sprite properties
  - Above the preview of our image change the drop down from `Top Left` to `Middle Center`
  - Let's give our sprite a name other than `sprite0`. Change it to `spr_player`
- Make an object
  - Click `No Sprite` and assign it the sprite we just made, `spr_player`
  - Name our object obj_player
  - The object window is the main place we add code, but for now close the object editor
- Place object in room
  - Double click the existing room, `room0`
  - Drag our object, `obj_player` into the room
- Run Game
  - Let's test our game so far (test early, test often)
  - Click the play button on the top toolbar or press F5
  - It's not a game yet but we got something on the screen!

## Add Some Code

- Open `obj_player`
- Click "Add Event" > "Step" > "Step"
  - A note on `Step`, the code we write here will run once per frame
- Edit the comment at the top to something more descriptive.
  - `Controls player movement`
  - Comments, lines that start with `//` don't have any effect on the code, they're just for organization.
- Enter this code:

```javascript
// Move left
if (keyboard_check(vk_left)) {
  x = x - 1;
}

// Move right
if (keyboard_check(vk_right)) {
  x = x + 1;
}
```

- **_AAAHHHHHH COOOODDDDEEEE_**
  - Calm down! Everything is alright!
- This code very simple, if you have any programming experience you probably already know what it means.
  - `keyboard_check` is a function that returns `true` or `false` depending on whether the key we're asking about is pressed. In this case, left or right arrow.
  - `x = x + 1` takes the x-coordinate of our object and moves it to the left or right.
- Run the game now, watch what happens!

## Some "Gameplay" Tweaks

- Our character moves super slow
- Lets try one way to speed him up:
  - Find "Options" > "Main" near the bottom of the resources tree.
  - In "General" edit "Game frames per second" from 30 to 60.
    - _Please do this for everything you make ever, I have no idea why it is not the default!_
- Run the game again! Twice as fast! Still stupidly slow!
  - Note, why did the character move faster? Because the code in Step runs twice as often.
- We're going to write some more code to make the player go a reasonable speed.
- Open `obj_player` again, and click "Add Event" > "Create"
  - My comment at the top this time will be `Initialize player speed`
  - The code in `Create` runs once when the object is created
- Write this code: `x_speed = 5;`
  - If I just write `speed` it turns green that's cool, I'm gonna use that!
  - Stop that! If it turns green then it's built in to GameMaker and the physics engine will use it. If you don't understand the physics engine you shouldn't use it in my opinion.
  - Also if you don't know what a `variable` is in programming all it means is that we can use `x_speed` and it will mean `5`
- Go back to the `Step` Event
- Change some stuff around:

```javascript
var dir = 0;

// Moving left
if (keyboard_check(vk_left)) {
  dir -= 1;
}

// Moving right
if (keyboard_check(vk_right)) {
  dir += 1;
}

// Move player
x += dir * x_speed;
```

Note: `dir += 1` is shorthand for `dir = dir + 1`

- Here we create a variable `dir`
  - If the player presses left it will be `-1`
  - If the player presses right it will be `+1`
  - x is changed by either `5` or `-5` every frame, making our player 5 times as fast!
- Run the game again... it feels better now!
  - You can edit x_speed to change the speed of your ship to whatever you want if you think it goes too fast or too slow.
- Some of you will probably notice one, _undesireable_ behavior. The ship will leave the sceen if you hold a direction for long enough.
- Add this code to the bottom of the step event:

```javascript
// If the player is outside the screen, move them to the edge
if (bbox_left < 0) {
  x -= bbox_left;
} else if (bbox_right > room_width) {
  x += room_width - bbox_right;
}
```

- This might be a bit confusing, but if you don't understand it that's okay for the sake of this tutorial. Basically, if the left or right edge is past the edge of the screen, move the player the amount of distance they are off.
- If you test the game again you'll see the player no longer leaves the screen

## Shooting

### Creating the bullet

- Next we're going to create a bullet object that the player will fire
- Create a sprite for it and name it `spr_bullet`
- We're going to change the size of the sprite to 8 x 32
  - Click the icon under Size: enter 8 for width and 32 for height
  - Be sure to uncheck "Maintain Aspect Ratio", or we'll get a square
- Create an object `obj_player_bullet` and write this code in the step and create events:

#### Create

```javascript
/// @description Initialize y_speed

y_speed = -10;
```

#### Step

```javascript
/// @description Move

y += y_speed;
```

- Drag an instance of this bullet into the room and run the game. The bullet should move up the screen.
  - But `y_speed` is negative, shouldn't it move down?
  - In GameMaker the top left corner of the screen is `(0, 0)`
  - Moving to the right increases x and moving down increases y
  - I know this seems weird, but it really is the best way
- Delete the instance of the bullet in the room, we don't want a random bullet the player didn't shoot to appear at the begining of the game.
- We want to add one last thing to the end of the `obj_player_bullet` step event

```javascript
// If the bullet goes past the top of the screen, delete it
if (bbox_bottom < 0) {
  instance_destroy();
}
```

### Shooting the bullet

- Go to `obj_player` and add this code to the bottom of the step event:

```javascript
// Shoot bullet
if (keyboard_check_pressed(vk_space)) {
  instance_create_depth(x, bbox_top, 0, obj_player_bullet);
}
```

- What's the `_pressed` for?
  - If you hold space you don't create an infinite stream of bullets
  - However if you _mash_ space you can get a lot of bullets very quickly. Lets fix that.
- Go to the `Create` event and add these lines

```javascript
shot_recharge = 30;
shot_charge = true;
```

- We'll make it so it takes 30 frames (0.5 seconds) before you can fire again
- Next go back to `Step` and add some stuff to our `if`

```javascript
// Shoot bullet
if (keyboard_check_pressed(vk_space) && shot_charged) {
  instance_create_depth(x, bbox_top, 0, obj_player_bullet);

  shot_charged = false;
  alarm[0] = shot_recharge;
}
```

- Create the `Alarm 0` event and give it this line: `shot_charged = true;`
- What happens here is we make it so we can't fire until `shot_charged` is `true`, and when we do shoot we set it to false. We then rig `alarm[0]` to go off in 30 frames, and when it does it sets `shot_charged` to `true`

## Enemies

- Finally lets add some enemies so this thing is a game!
- Make a sprite for the enemies `spr_enemy`
- Make an object `obj_enemy` and set its sprite to `spr_enemy`
- Make an object `obj_enemy_bullet` and set its sprite to `spr_bullet`

### obj_enemy_bullet

Okay easy one first! Should look familiar.

#### Create

```javascript
/// @description Initialize y_speed

y_speed = 10;
```

#### Step

```javascript
/// @description Move

y += y_speed;

// If the bullet goes past the bottom of the screen, delete it
if (bbox_top > room_width) {
  instance_destroy();
}
```

### obj_enemy Movement

#### Create

```javascript
/// @description Initialize variables

x_speed = 2;

drift_dist = 50;

dir = -1;
```

#### Step

```javascript
/// @description Move and shoot

// Move
x += dir * x_speed;

// If too far switch direction
if (abs(x - xstart) >= drift_dist) {
  dir *= -1;
}
```

- Add some enemyies to the room and watch them bob back and forth

### obj_enemy Shooting

#### Create

```javascript
shoot_time_min = 45;
shoot_time_range = 120;

alarm[0] = shoot_time_min + random(shoot_time_range);
```

#### Alarm 0

```javascript
instance_create_depth(x, bbox_bottom, 0, obj_enemy_bullet);

alarm[0] = shoot_time_min + random(shoot_time_range);
```

- Run the game again and find a hellfire of bullets raining down on your soul

## Taking damage

- Finally to make this a game lets add some consequences of getting hit

### obj_enemy > Collision > obj_player_bullet and obj_player > Collision > obj_player_bullet

```javascript
instance_destroy(other);
instance_destroy();
```
