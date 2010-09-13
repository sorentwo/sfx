package sfx {
  public class SFX {
    
    private var _object:*;
    
    public function SFX(object:* = null) {
      _object = object;
    }
    
    /**
     * Wrap an object in an Sfx object. Think jQuery's '$()
    **/
    public static function wrap(object:* = null):SFX {
      return new SFX(object);
    }
    
    /**
     * Returns the originally wrapped object.
    **/
    public function get object():* { return _object; }
  }
}