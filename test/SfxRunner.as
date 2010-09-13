package {
  import asunit.textui.TestRunner
  import sfx.Tween
  
  public class SFXRunner extends TestRunner {
    public function SFXRunner() {
      
      Tween.getInstance().registerStage(this.stage)
      
      start(AllTests, null, TestRunner.SHOW_TRACE)
    }
  }
}