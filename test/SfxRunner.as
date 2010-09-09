package {
  import asunit.textui.TestRunner
  
  public class SfxRunner extends TestRunner {
    public function SfxRunner() {
      start(AllTests, null, TestRunner.SHOW_TRACE)
    }
  }
}