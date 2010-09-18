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

The current version has a rather generic syntax and is entirely OO, goals for
the next version include:

  * Mirror the jQuery animate() API
  * Add support for infinite chaining
  * Implement functional programming callbacks
  * Some actual testing

## Getting Started

Sfx uses a singleton Tween object to sync all tweening to the Stage framerate.
This has many benefits for performance, but does require you to register the 
stage in your main display class.

Here is a sample implementation:

    package {
      import flash.display.Sprite
      import sfx.Tween
      import sfx.SFX
  
      public class MyClass extends DisplayObject {
        public function MyClass() {
          // Register the tween singleton
          Tween.getInstance().registerStage(this.stage)
        }
      }
    }

## Usage

Returns a a SFX object that wraps the original object

    var $sprite = Sfx.wrap(new DisplayObject())

You can always retrieve your original object, if needed

    $sprite.object

Perform animation of any numeric property on your object:
    
    $sprite.animate({ x: 10 }, 250);     // Absolute
    $sprite.animate({ x: '-=10' }, 250); // Relative

Importing specific easing classes is cumbersome. Just provide easing as a string:
  
  $sprite.animate({ x: 10 }, 100, 'quadIn');

SFX eschews onFrame, onPlay type events. Event dispatching slows things down, so 
we only handle a complete event provided as a callback function:

    $sprite.animate({ x: 10 }, 100, 'quadIn', function(this) {
      trace("Animation Complete");
    });

You can also call pre-defined effects:

    $sprite.fade('out', 250); // Using a keyword
    $sprite.fade(0.5, 250);   // Using a numeric value
    
    // Instant effects, they don't take a duration
    $sprite.hide();
    $sprite.show();
    $sprite.move({ x: 5, y: 5});
    
    // Change object registration. Very useful for rotation.
    $sprite.register('center');
    $sprite.register('top-left');

Creating a queue is especially easy to do, simply chain animations together and
they will be called in sequence:

    $sprite
      .hide()
      .fade('in', 250)
      .animate({ x: '+=200' }, 100)
      .animate({ scaleX: 0.25, scaleY: 0.25 }, 100)
      .animate({ x: '-=200', scaleX: 0.25, scaleY: 0.25 }, 200)
      .fade('out', 250);