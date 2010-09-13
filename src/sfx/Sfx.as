package sfx {
  public class Sfx {
    
    private var _object:*;
    
    public function Sfx(object:* = null) {
      _object = object;
    }
    
    /**
     * Wrap an object in an Sfx object. Think jQuery's '$()
    **/
    public static function wrap(object:* = null):Sfx {
      return new Sfx(object);
    }
    
    /**
     * Returns the originally wrapped object.
    **/
    public function get object():* { return _object; }
  }
}