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
      import sfx.*
  
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

Perform animation of any numeric property on your object

    $sprite.animate({ x: 10 }, 100, 'quadIn', function(this) {
      trace("Animation Complete")
    });