package {
  import asunit.textui.TestRunner
  
  public class SFXRunner extends TestRunner {
    public function SFXRunner() {
      start(AllTests, null, TestRunner.SHOW_TRACE)
    }
  }
}