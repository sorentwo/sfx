package {
  
  import flash.utils.describeType
  import asunit.framework.TestSuite
  
  public class AllTests extends TestSuite {
    public function AllTests() {
      var tests:Array = [CoreTest, AnimationTest, TweenTest, EasingTest]

      iterateTestArray(tests)
    }
    
    public function iterateTestArray(array:Array):void {
      for each (var test_class:Class in array) {
        runTests(test_class)
      }
    }

    public function runTests(test_class:Class):void {
      var description:XML = describeType(test_class)
      var pattern:RegExp  = /test.*/

      for each (var method:XML in description..method) {
        if (pattern.test(method.@name)) {
          addTest(new test_class(method.@name))
        }
      }
    }
  }
}