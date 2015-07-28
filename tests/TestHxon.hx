package;

import haxe.unit.TestCase;
import macrox.Hxon;

typedef A = {
	name:String,
	foo:String
}

class Ref<T>{}
/**
 * ...
 * @author Porfirio
 */
class TestHxon extends TestCase{

	public function new() {
		super();
		
	}
	
	public function testParse() {
        var a: TestHxon.A = Hxon.parse("tests/a.hxon");
        var r:TestHxon.A;

        // var b=Hxon.pp("tests/a.hxon",A);
        // $type(b);
		assertEquals(a.name, "a");
	}
}

