              ___          
            /'___\         
       ____/\ \__/  __  _  
      /',__\ \ ,__\/\ \/'\ 
     /\__, `\ \ \_/\/>  </ 
     \/\____/\ \_\  /\_/\_\
      \/___/  \/_/  \//\/_/

An AS3 animation library with pre-defined effects, queues and tweening. It 
is optimized for speed and handles anti-garbage collection automatically.

## In Progress

As of versions > 0.6.1 the basic goals for SFX have been reached:

  * Mirrors the jQuery animate() API
  * Supports infinite chaining
  * Implements functional programming callbacks
  * Unlike most AS3 code is backed by actual testing

## Why?

Because animation is supposed to be fun, and using something as dry as BetweenAS3,
Tweensy, TweenMax, or GTween doesn't give you the warm fuzzy feeling that you
deserve!

The goal here isn't to have the most feature packed tween engine, it is to have
the most fun to use animation engine that is blazing fast and light-weight.

## Usage

Returns a a SFX object that wraps the original object

    var $sprite = SFX.wrap(new DisplayObject())

You can always retrieve your original object, if needed

    $sprite.object

Perform animation of any numeric property on your object:
    
    $sprite.animate({ x: 10 }, 250);     // Absolute
    $sprite.animate({ x: '-=10' }, 250); // Relative

Because this is the flash world we need some un-weblike options, such as looping
and yo-yoing:

    $sprite.animate({ alpha: 0 }, 250, { yoyo: 2 }) // Yo-yo 2 times
    $sprite.animate({ alpha: 0 }, 250, { yoyo: 0 }) // Yo-yo infinitely
    
    $sprite.animate({ alpha: 0 }, 250, { loop: 1 }) // Loop once
    $sprite.animate({ alpha: 0 }, 250, { loop: 0 }) // Loop infinitely
    
    // If you set yoyo and loop for the same animation loop will override
    $sprite.animate({ alpha: 0 }, 250, { loop: 0, yoyo: 2 })

Importing specific easing classes is cumbersome. Just provide easing as a string
inside the options hash:
  
    $sprite.animate({ x: 10 }, 100, { easing: 'quadIn' });

SFX eschews onFrame, onPlay type events. Event dispatching slows things down, so 
we only handle a complete event provided as a callback function:

    $sprite.animate({ x: 10 }, 100, { easing: 'quadIn' }, function(this) {
      trace("Animation Complete");
    });

You can also call pre-defined effects:

    $sprite.fade('out', 250); // Using a keyword
    $sprite.fade(0.5, 250);   // Using a numeric value
    
    $sprite.hide();
    $sprite.hide(500);
    $sprite.hide(500, function():void { trace("I'm a callback!") })
    
    // If you want special easing just use the animate method instead
    $sprite.show();
    $sprite
      .hide(250, function():void { trace("I'm faded out") })
      .show(250, function():void { trace("Now I'm faded back in") })

Creating a queue is especially easy to do, simply chain animations together and
they will be called in sequence:

    $sprite
      .hide()
      .fade('in', 250)
      .animate({ x: '+=200' }, 100)
      .animate({ scaleX: 0.25, scaleY: 0.25 }, 100)
      .animate({ x: '-=200', scaleX: 0.25, scaleY: 0.25 }, 200)
      .fade('out', 250);

It is also possible to incorporate a delay between any two items in the queue:

    $sprite.hide().delay(500).fade('in', 250)