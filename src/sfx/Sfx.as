package sfx {
  public class Sfx {
    
    private var $object:*;
    
    public function Sfx(object:* = null) {
      $object = object;
    }
    
    public static function wrap(object:* = null):Sfx {
      return new Sfx(object);
    }
  }
}